local CONFIG = {
	SourceFile = "saveinstance.luau", 
	Repo = "andrewexec/USSI-Redux",
	Branch = "experimental",
	OutFolder = "ussi_test/",
	ReportFile = "ussi_test_report.txt",
	KeepFiles = false,
	DecompileTimeout = 20,
}

local env = getgenv()
local HttpService = game:GetService("HttpService")
local LogService = game:GetService("LogService")
local Players = game:GetService("Players")

local report = {}
local results = { pass = 0, fail = 0, skip = 0 }
local seenWarnings = {}
local warningOrder = {}

local function log(line)
	table.insert(report, line)
	print(line)
end

local function recordWarning(message)
	if not seenWarnings[message] then
		seenWarnings[message] = true
		table.insert(warningOrder, message)
	end
end

local warnConnection = LogService.MessageOut:Connect(function(message, messageType)
	if messageType == Enum.MessageType.MessageWarning or messageType == Enum.MessageType.MessageError then
		recordWarning(message)
	end
end)

local capturing = true
local originalWarn = env.warn
local function capturingWarn(...)
	local parts = table.pack(...)
	for i = 1, parts.n do
		parts[i] = tostring(parts[i])
	end
	if capturing then
		recordWarning(table.concat(parts, " ", 1, parts.n))
	end
	return originalWarn(...)
end

local hookedInPlace = false
if env.hookfunction and originalWarn then
	local wrap = env.newcclosure or function(f)
		return f
	end
	local ok, previous = pcall(env.hookfunction, originalWarn, wrap(capturingWarn))
	if ok and type(previous) == "function" then
		originalWarn = previous
		hookedInPlace = true
	end
end
if not hookedInPlace then
	env.warn = capturingWarn
end

local function stopCapturing()
	capturing = false
	warnConnection:Disconnect()
	if not hookedInPlace then
		env.warn = originalWarn
	end
end

local function exists(path)
	return isfile(path)
end

local function read(path)
	local ok, data = pcall(readfile, path)
	return ok and data or nil
end

local function remove(path)
	if not CONFIG.KeepFiles and exists(path) then
		pcall(delfile, path)
	end
end

local function count(text, pattern)
	local _, n = string.gsub(text, pattern, "")
	return n
end

local function test(name, fn)
	local started = os.clock()
	local ok, passed, detail = pcall(fn)
	local seconds = string.format("%.1fs", os.clock() - started)
	if not ok then
		results.fail += 1
		log(`FAIL  {name} ({seconds}): error: {tostring(passed)}`)
	elseif passed == nil then
		results.skip += 1
		log(`SKIP  {name}: {detail or ""}`)
	elseif passed then
		results.pass += 1
		log(`PASS  {name} ({seconds}){detail and (": " .. detail) or ""}`)
	else
		results.fail += 1
		log(`FAIL  {name} ({seconds}){detail and (": " .. detail) or ""}`)
	end
end

log("USSI Redux executor test")
local executorName, executorVersion = "unknown", ""
for _, getName in { env.identifyexecutor, env.getexecutorname, env.whatexecutor } do
	local ok, name, version = pcall(getName)
	if ok and name then
		executorName, executorVersion = tostring(name), tostring(version or "")
		break
	end
end
log(`Executor: {executorName} {executorVersion}`)
log(`Game: {game.PlaceId} | Date: {os.date("%Y-%m-%d %H:%M:%S")}`)
log("")

local synsaveinstance
local sourceOrigin

test("warning capture works", function()
	warn("USSI_PROBE_DIRECT")
	pcall(function()
		loadstring("warn('USSI_PROBE_CHUNK')")()
	end)
	local direct, chunk = seenWarnings["USSI_PROBE_DIRECT"] == true, seenWarnings["USSI_PROBE_CHUNK"] == true
	return direct and chunk,
		`direct {tostring(direct)}, loadstring chunk {tostring(chunk)}, via {hookedInPlace and "hookfunction" or "env.warn"}. If this fails, the DUPLICATE test below cannot be trusted`
end)

test("load saveinstance.luau", function()
	local source
	if exists(CONFIG.SourceFile) then
		source = readfile(CONFIG.SourceFile)
		sourceOrigin = `workspace file {CONFIG.SourceFile}`
	else
		source = (game :: any):HttpGet(
			`https://raw.githubusercontent.com/{CONFIG.Repo}/{CONFIG.Branch}/saveinstance.luau`,
			true
		)
		sourceOrigin = `download from branch {CONFIG.Branch}`
	end
	local chunk, err = loadstring(source, "saveinstance")
	if not chunk then
		return false, tostring(err)
	end
	synsaveinstance = chunk()
	return type(synsaveinstance) == "function", `{sourceOrigin}, {#source} bytes`
end)

if not synsaveinstance then
	log("Could not load saveinstance, so the remaining tests are skipped.")
	stopCapturing()
	pcall(writefile, CONFIG.ReportFile, table.concat(report, "\n"))
	return
end

pcall(env.makefolder or function() end, CONFIG.OutFolder)

local model = Instance.new("Folder")
model.Name = "USSI_TEST_MODEL"
local part = Instance.new("Part")
part.Name = "TestPart"
part.Anchored = true
part.Position = Vector3.new(1, 2, 3)
part.Parent = model
local text = Instance.new("StringValue")
text.Name = "TestString"
text.Value = "a\0b\r\nc\u{e9}\u{4e2d}"
text.Parent = model
model.Parent = game:GetService("ReplicatedStorage")

local function save(options)
	options.Object = options.Object or model
	options.ShowStatus = false
	options.SafeMode = false
	options.ReadMe = false
	options.AvoidFileOverwrite = false
	options.DecompileTimeout = CONFIG.DecompileTimeout
	return pcall(synsaveinstance, options)
end

local function saveTo(name, options)
	options.FilePath = CONFIG.OutFolder .. name
	local ok, err = save(options)
	local ext = options.Binary == false and ".rbxmx" or ".rbxm"
	if options.XML then
		ext = ".rbxmx"
	end
	local path = CONFIG.OutFolder .. name .. ext
	return ok, err, path
end

local binarySize, xmlText

test("binary save writes a valid .rbxm", function()
	local ok, err, path = saveTo("binary", { Binary = true })
	if not ok then
		return false, tostring(err)
	end
	if not exists(path) then
		return false, `{path} was not created`
	end
	local data = read(path)
	binarySize = data and #data
	local header = data and string.sub(data, 1, 8)
	remove(path)
	return header == "<roblox!", `{binarySize} bytes, header {string.format("%q", header or "")}`
end)

test("uncompressed binary keeps the instance names", function()
	local ok, err, path = saveTo("binary_raw", { Binary = true, CompressionMode = false })
	if not ok then
		return false, tostring(err)
	end
	local data = read(path)
	remove(path)
	if not data then
		return false, "file missing"
	end
	local hasNames = string.find(data, "TestPart", 1, true) and string.find(data, "USSI_TEST_MODEL", 1, true)
	return hasNames ~= nil, `{#data} bytes`
end)

test("compressed binary is not larger than uncompressed", function()
	local ok1, _, rawPath = saveTo("size_raw", { Binary = true, CompressionMode = false })
	local ok2, _, zPath = saveTo("size_zstd", { Binary = true, CompressionMode = "zstd" })
	local raw, z = read(rawPath), read(zPath)
	remove(rawPath)
	remove(zPath)
	if not (ok1 and ok2 and raw and z) then
		return nil, "one of the saves failed"
	end
	return #z <= #raw, `raw {#raw}, zstd {#z}`
end)

test("XML save writes a well-formed .rbxmx", function()
	local ok, err, path = saveTo("xml", { XML = true })
	if not ok then
		return false, tostring(err)
	end
	local data = read(path)
	xmlText = data
	remove(path)
	if not data then
		return false, `{path} was not created`
	end
	local opens, closes = count(data, "<Item[ >]"), count(data, "</Item>")
	local good = string.sub(data, 1, 7) == "<roblox"
		and string.find(data, 'class="Part"', 1, true) ~= nil
		and string.find(data, "TestPart", 1, true) ~= nil
		and opens == closes
	return good, `{#data} bytes, {opens} items, {closes} closed`
end)

test('mode = "full" turns IgnoreDefaultProperties off', function()
	local ok1, _, p1 = saveTo("mode_default", { XML = true, mode = "full" })
	local ok2, _, p2 = saveTo("mode_forced_off", { XML = true, mode = "full", IgnoreDefaultProperties = false })
	local ok3, _, p3 = saveTo("mode_forced_on", { XML = true, mode = "full", IgnoreDefaultProperties = true })
	local a, b, c = read(p1), read(p2), read(p3)
	remove(p1)
	remove(p2)
	remove(p3)
	if not (ok1 and ok2 and ok3 and a and b and c) then
		return false, "one of the saves failed"
	end
	local detail = `default {#a}, set false {#b}, set true {#c}`
	return #a == #b and #c < #a, detail
end)

local function findScript()
	local getbytecode = env.getscriptbytecode
	if not getbytecode then
		return nil
	end
	local roots = { Players.LocalPlayer, game:GetService("ReplicatedFirst"), game:GetService("StarterPlayer") }
	for _, root in roots do
		if root then
			for _, descendant in root:GetDescendants() do
				if descendant:IsA("LuaSourceContainer") then
					local ok, bytecode = pcall(getbytecode, descendant)
					if ok and bytecode and #bytecode > 0 then
						return descendant
					end
				end
			end
		end
	end
	return nil
end

local function readState()
	local raw = read("ussi_cache/EXEC_STATE.json")
	if not raw then
		return nil
	end
	local ok, decoded = pcall(function()
		return HttpService:JSONDecode(raw)
	end)
	if not ok then
		return nil
	end
	for key, state in decoded do
		if type(state) == "table" then
			return decoded, key, state
		end
	end
	return nil
end

local function wasSkipped(data)
	return data ~= nil and string.find(data, "-- Skipped:", 1, true) ~= nil
		and string.find(data, "RetryCrashedScripts", 1, true) ~= nil
end

local target = findScript()
local injectedKey

test("crash protection: a normal decompile leaves nothing marked", function()
	if not target then
		return nil, "no script with bytecode found (needs getscriptbytecode and a game with scripts)"
	end
	local ok, err, path = saveTo("guard_normal", { XML = true, Object = target, scriptcache = false, Decompile = true })
	remove(path)
	if not ok then
		return false, tostring(err)
	end
	local _, _, state = readState()
	if not state then
		return nil, "ussi_cache/EXEC_STATE.json was not written (needs writefile)"
	end
	local inFlight = state.decompiling and next(state.decompiling)
	return inFlight == nil, `decompiling is {inFlight == nil and "empty" or "not empty"}`
end)

test("crash protection: a crashed script is skipped", function()
	if not target then
		return nil, "no script to test with"
	end
	local decoded, key, state = readState()
	if not state then
		return nil, "no state file"
	end
	state.crashedScripts = state.crashedScripts or {}
	injectedKey = target.ClassName .. ":" .. target:GetFullName()
	state.crashedScripts[injectedKey] = true
	writefile("ussi_cache/EXEC_STATE.json", HttpService:JSONEncode(decoded))

	local _, _, afterWrite = readState()
	local persisted = afterWrite and afterWrite.crashedScripts and afterWrite.crashedScripts[injectedKey] == true

	local ok, err, path = saveTo("guard_skip", { XML = true, Object = target, scriptcache = false, Decompile = true })
	local data = read(path)
	remove(path)
	if not ok then
		return false, tostring(err)
	end

	local _, _, afterSave = readState()
	local keptAfterSave = afterSave and afterSave.crashedScripts and afterSave.crashedScripts[injectedKey] == true
	local skipped = wasSkipped(data)

	local snippet = "no output file"
	if data then
		local from = string.find(data, 'name="Source"', 1, true)
		snippet = from and string.gsub(string.sub(data, from, from + 260), "[\r\n]+", " | ") or "no Source property in output"
	end

	return skipped,
		`key {injectedKey} | persisted after write: {tostring(persisted)} | still marked after save: {tostring(keptAfterSave)} | Source: {snippet}`
end)

test("crash protection: RetryCrashedScripts decompiles it again", function()
	if not target then
		return nil, "no script to test with"
	end
	local ok, err, path =
		saveTo("guard_retry", { XML = true, Object = target, scriptcache = false, Decompile = true, RetryCrashedScripts = true })
	local data = read(path)
	remove(path)
	if not ok then
		return false, tostring(err)
	end
	local _, _, state = readState()
	local stillMarked = state and state.crashedScripts and next(state.crashedScripts) ~= nil
	local skipped = wasSkipped(data)
	return (not skipped) and not stillMarked,
		`skipped text {skipped and "present" or "gone"}, list {stillMarked and "not empty" or "empty"}`
end)

test("SaveSpecialProperties keeps only the properties you list", function()
	local function saveXml(options)
		options.XML = true
		local ok, _, path = saveTo("special", options)
		local data = ok and read(path)
		remove(path)
		return data
	end
	local function names(data)
		local set = {}
		for name in string.gmatch(data, 'name="([^"]+)"') do
			set[name] = true
		end
		return set
	end

	local all = saveXml({})
	local none = saveXml({ SaveSpecialProperties = {} })
	if not (all and none) then
		return false, "one of the saves failed"
	end

	local allNames, noneNames = names(all), names(none)
	local dropped = {}
	for name in allNames do
		if not noneNames[name] then
			table.insert(dropped, name)
		end
	end
	table.sort(dropped)
	if #dropped == 0 then
		return nil, `an empty list changed nothing but values, so no property name was dropped (all {#all}, empty {#none} bytes)`
	end

	local wanted = dropped[1]
	local only = saveXml({ SaveSpecialProperties = { wanted } })
	if not only then
		return false, "the save with a list failed"
	end
	local onlyNames = names(only)
	local keptWanted = onlyNames[wanted] == true
	local droppedOthers = 0
	for _, name in dropped do
		if name ~= wanted and not onlyNames[name] then
			droppedOthers += 1
		end
	end
	return keptWanted and none ~= all,
		`empty list dropped {#dropped} ({table.concat(dropped, ", ", 1, math.min(#dropped, 6))}); listing "{wanted}" kept it: {tostring(keptWanted)}; other dropped ones still gone: {droppedOthers}/{#dropped - 1}`
end)

test("no DUPLICATE option or alias warnings", function()
	local found = {}
	for _, message in warningOrder do
		if string.find(message, "DUPLICATE", 1, true) then
			table.insert(found, message)
		end
	end
	return #found == 0, #found > 0 and table.concat(found, " | ") or nil
end)

model:Destroy()
stopCapturing()

if injectedKey then
	local decoded, _, state = readState()
	if state and state.crashedScripts and state.crashedScripts[injectedKey] then
		state.crashedScripts[injectedKey] = nil
		pcall(writefile, "ussi_cache/EXEC_STATE.json", HttpService:JSONEncode(decoded))
	end
end

log("")
log(`Result: {results.pass} passed, {results.fail} failed, {results.skip} skipped`)
if #warningOrder > 0 then
	log("")
	log(`Warnings and errors printed during the run ({#warningOrder}, first 40):`)
	for i = 1, math.min(#warningOrder, 40) do
		if not string.find(warningOrder[i], "USSI_PROBE", 1, true) then
			log("  " .. string.sub(warningOrder[i], 1, 300))
		end
	end
end
log("")
log(`Source: {sourceOrigin}`)

local wrote = pcall(writefile, CONFIG.ReportFile, table.concat(report, "\n"))
print(wrote and `Report written to {CONFIG.ReportFile} in the executor workspace.` or "Could not write the report file.")
