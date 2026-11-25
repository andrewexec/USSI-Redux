--!nocheck

local Moon = {}

local OPS = {}
do
	local nextCode = 0
	local function op(name, fmt, len)
		OPS[nextCode] = { name = name, fmt = fmt, len = len or 1 }
		nextCode += 1
	end

	op("NOP", "")
	op("BREAK", "")
	op("LOADNIL", "A")
	op("LOADB", "ABC")
	op("LOADN", "AD")
	op("LOADK", "AD")
	op("MOVE", "AB")
	op("GETGLOBAL", "AC", 2)
	op("SETGLOBAL", "AC", 2)
	op("GETUPVAL", "AB")
	op("SETUPVAL", "AB")
	op("CLOSEUPVALS", "A")
	op("GETIMPORT", "AD", 2)
	op("GETTABLE", "ABC")
	op("SETTABLE", "ABC")
	op("GETTABLEKS", "ABC", 2)
	op("SETTABLEKS", "ABC", 2)
	op("GETTABLEN", "ABC")
	op("SETTABLEN", "ABC")
	op("NEWCLOSURE", "AD")
	op("NAMECALL", "ABC", 2)
	op("CALL", "ABC")
	op("RETURN", "AB")
	op("JUMP", "D")
	op("JUMPBACK", "D")
	op("JUMPIF", "AD")
	op("JUMPIFNOT", "AD")
	op("JUMPIFEQ", "AD", 2)
	op("JUMPIFLE", "AD", 2)
	op("JUMPIFLT", "AD", 2)
	op("JUMPIFNOTEQ", "AD", 2)
	op("JUMPIFNOTLE", "AD", 2)
	op("JUMPIFNOTLT", "AD", 2)
	op("ADD", "ABC")
	op("SUB", "ABC")
	op("MUL", "ABC")
	op("DIV", "ABC")
	op("MOD", "ABC")
	op("POW", "ABC")
	op("ADDK", "ABC")
	op("SUBK", "ABC")
	op("MULK", "ABC")
	op("DIVK", "ABC")
	op("MODK", "ABC")
	op("POWK", "ABC")
	op("AND", "ABC")
	op("OR", "ABC")
	op("ANDK", "ABC")
	op("ORK", "ABC")
	op("CONCAT", "ABC")
	op("NOT", "AB")
	op("MINUS", "AB")
	op("LENGTH", "AB")
	op("NEWTABLE", "ABC", 2)
	op("DUPTABLE", "AD")
	op("SETLIST", "ABC", 2)
	op("FORNPREP", "AD")
	op("FORNLOOP", "AD")
	op("FORGLOOP", "AD", 2)
	op("FORGPREP_INEXT", "AD")
	op("FASTCALL3", "ABC", 2)
	op("FORGPREP_NEXT", "AD")
	op("NATIVECALL", "")
	op("GETVARARGS", "AB")
	op("DUPCLOSURE", "AD")
	op("PREPVARARGS", "A")
	op("LOADKX", "A", 2)
	op("JUMPX", "E")
	op("FASTCALL", "AC")
	op("COVERAGE", "E")
	op("CAPTURE", "AB")
	op("SUBRK", "ABC")
	op("DIVRK", "ABC")
	op("FASTCALL1", "ABC")
	op("FASTCALL2", "ABC", 2)
	op("FASTCALL2K", "ABC", 2)
	op("FORGPREP", "AD")
	op("JUMPXEQKNIL", "AD", 2)
	op("JUMPXEQKB", "AD", 2)
	op("JUMPXEQKN", "AD", 2)
	op("JUMPXEQKS", "AD", 2)
	op("IDIV", "ABC")
	op("IDIVK", "ABC")
	op("GETUDATAKS", "ABC", 2)
	op("SETUDATAKS", "ABC", 2)
	op("NAMECALLUDATA", "ABC", 2)
	op("NEWCLASSMEMBER", "ABC", 2)
	op("CALLFB", "ABC", 2)
	op("CMPPROTO", "AD", 2)
	op("FASTPCALL", "ABC")
	op("NEWCLASS", "ABC", 2)
	op("CONSTRUCT", "ABC", 2)
	op("FINCONSTRUCT", "ABC")
	op("GETPRIVATEFIELD", "ABC", 2)
	op("SETPRIVATEFIELD", "ABC", 2)
end

local function buildOpMap(multiplier)
	local map = {}
	for real = 0, 255 do
		map[(real * multiplier) % 256] = real
	end
	return map
end
local OPMAP_VANILLA = buildOpMap(1)
local OPMAP_ROBLOX = buildOpMap(227)

local band, bor, rshift, lshift = bit32.band, bit32.bor, bit32.rshift, bit32.lshift

local CONSTANT_NIL = 0
local CONSTANT_BOOLEAN = 1
local CONSTANT_NUMBER = 2
local CONSTANT_STRING = 3
local CONSTANT_IMPORT = 4
local CONSTANT_TABLE = 5
local CONSTANT_CLOSURE = 6
local CONSTANT_VECTOR = 7
local CONSTANT_TABLE_WITH_CONSTANTS = 8
local CONSTANT_VECTORD = 11

local function countDecodeErrors(code, map)
	local errors = 0
	local i = 1
	local n = #code
	while i <= n do
		local info = OPS[map[band(code[i], 255)]]
		if info then
			i += info.len
		else
			errors += 1
			i += 1
		end
	end
	if i ~= n + 1 then
		errors += 1
	end
	return errors
end

local function decodeInstructions(p, map)
	local code = p.code
	local insns = {}
	local i = 1
	local n = #code
	while i <= n do
		local w = code[i]
		local realOp = map[band(w, 255)]
		local info = OPS[realOp]
		local ins = {
			pc = i - 1,
			op = realOp,
			name = info and info.name or ("UNKNOWN_" .. tostring(band(w, 255))),
			len = info and info.len or 1,
			A = band(rshift(w, 8), 255),
			B = band(rshift(w, 16), 255),
			C = rshift(w, 24),
		}
		local d = rshift(w, 16)
		if d >= 32768 then
			d -= 65536
		end
		ins.D = d
		local e = rshift(w, 8)
		if e >= 8388608 then
			e -= 16777216
		end
		ins.E = e
		if ins.len == 2 then
			ins.aux = code[i + 1]
		end
		insns[#insns + 1] = ins
		i += ins.len
	end
	p.insns = insns
end

function Moon.parse(bytecode: string)
	local size = #bytecode
	if size == 0 then
		return nil, "empty bytecode"
	end

	local buf = buffer.fromstring(bytecode)
	local pos = 0

	local function need(n)
		if pos + n > size then
			error("unexpected end of bytecode at offset " .. pos, 0)
		end
	end
	local function u8()
		need(1)
		local v = buffer.readu8(buf, pos)
		pos += 1
		return v
	end
	local function u32()
		need(4)
		local v = buffer.readu32(buf, pos)
		pos += 4
		return v
	end
	local function i32()
		need(4)
		local v = buffer.readi32(buf, pos)
		pos += 4
		return v
	end
	local function f32()
		need(4)
		local v = buffer.readf32(buf, pos)
		pos += 4
		return v
	end
	local function f64()
		need(8)
		local v = buffer.readf64(buf, pos)
		pos += 8
		return v
	end
	local function varint()
		local result, shift = 0, 0
		while true do
			local b = u8()
			result = bor(result, lshift(band(b, 127), shift))
			shift += 7
			if b < 128 then
				break
			end
		end
		return result
	end

	local version = u8()
	if version == 0 then
		return nil, bytecode:sub(2)
	end
	if (version < 3 or version > 14) and version ~= 100 then
		return nil, ("unsupported bytecode version %d (supported: 3-14)"):format(version)
	end
	local typesVersion = 0
	if version >= 4 then
		typesVersion = u8()
		if typesVersion < 1 or typesVersion > 3 then
			return nil, ("unsupported bytecode type version %d"):format(typesVersion)
		end
	end

	local ok, result = pcall(function()
		local strings = {}
		local stringCount = varint()
		for i = 1, stringCount do
			local len = varint()
			need(len)
			strings[i] = bytecode:sub(pos + 1, pos + len)
			pos += len
		end

		local function readString()
			local id = varint()
			if id == 0 then
				return nil
			end
			return strings[id]
		end

		if typesVersion == 3 then
			local index = u8()
			while index ~= 0 do
				readString()
				index = u8()
			end
		end

		local protos = {}
		local protoCount = varint()
		for i = 1, protoCount do
			local protoSize = 0
			if version >= 12 then
				protoSize = varint()
			end
			local protoStart = pos

			local p = {}
			p.index = i
			p.maxStack = u8()
			p.numParams = u8()
			p.numUpvals = u8()
			p.isVararg = u8() ~= 0
			p.flags = 0
			if version >= 4 then
				p.flags = u8()
				if typesVersion >= 1 then
					local typeSize = varint()
					need(typeSize)
					p.typeBlob = bytecode:sub(pos + 1, pos + typeSize)
					pos += typeSize
				end
			end

			local sizeCode = varint()
			p.codeOffset = pos
			local code = table.create(sizeCode)
			for j = 1, sizeCode do
				code[j] = u32()
			end
			p.code = code

			local sizeK = varint()
			local constants = table.create(sizeK)
			for j = 1, sizeK do
				local tag = u8()
				local k
				if tag == CONSTANT_NIL then
					k = { type = "nil" }
				elseif tag == CONSTANT_BOOLEAN then
					k = { type = "boolean", value = u8() ~= 0 }
				elseif tag == CONSTANT_NUMBER then
					k = { type = "number", value = f64() }
				elseif tag == CONSTANT_STRING then
					k = { type = "string", value = readString() or "" }
				elseif tag == CONSTANT_IMPORT then
					k = { type = "import", id = u32() }
				elseif tag == CONSTANT_TABLE then
					local keys = {}
					for q = 1, varint() do
						keys[q] = varint()
					end
					k = { type = "table", keys = keys }
				elseif tag == CONSTANT_TABLE_WITH_CONSTANTS then
					local keys = {}
					local values = {}
					for q = 1, varint() do
						keys[q] = varint()
						values[q] = i32()
					end
					k = { type = "table", keys = keys, values = values }
				elseif tag == CONSTANT_CLOSURE then
					k = { type = "closure", protoId = varint() }
				elseif tag == CONSTANT_VECTOR then
					k = { type = "vector", x = f32(), y = f32(), z = f32(), w = f32() }
				elseif tag == CONSTANT_VECTORD then
					k = { type = "vector", x = f64(), y = f64(), z = f64(), w = f64() }
				elseif tag == 9 then
					local low = u32()
					local high = i32()
					k = { type = "number", value = high * 4294967296 + low }
				elseif tag == 10 then
					local nameIndex = varint()
					local privateFields, privateMethods = u8(), u8()
					local properties, methods = varint(), varint()
					for _ = 1, (properties - privateFields) + (methods - privateMethods) do
						varint()
					end
					k = { type = "classshape", nameIndex = nameIndex }
				else
					error(("unsupported constant type %d"):format(tag), 0)
				end
				constants[j] = k
			end
			p.constants = constants

			local children = {}
			for j = 1, varint() do
				children[j] = varint()
			end
			p.children = children

			p.lineDefined = varint()
			p.debugName = readString()

			local lines = {}
			if u8() ~= 0 then
				local gapLog2 = u8()
				local deltas = table.create(sizeCode)
				local last = 0
				for j = 1, sizeCode do
					last = (last + u8()) % 256
					deltas[j] = last
				end
				local intervals = if sizeCode > 0 then rshift(sizeCode - 1, gapLog2) + 1 else 0
				local abs = {}
				local lastLine = 0
				for j = 1, intervals do
					lastLine += i32()
					abs[j] = lastLine
				end
				for j = 1, sizeCode do
					lines[j] = abs[rshift(j - 1, gapLog2) + 1] + deltas[j]
				end
			end
			p.lines = lines

			p.locVars = {}
			p.upvalNames = {}
			if u8() ~= 0 then
				for j = 1, varint() do
					p.locVars[j] = {
						name = readString() or "?",
						startPc = varint(),
						endPc = varint(),
						reg = u8(),
					}
				end
				for j = 1, varint() do
					p.upvalNames[j] = readString()
				end
			end

			if version >= 11 then
				for _ = 1, varint() do
					local slotType = u8()
					if slotType == 0 or slotType == 1 then
						varint()
					else
						error(("unknown feedback slot type %d"):format(slotType), 0)
					end
				end
			end
			if version >= 12 and band(p.flags, 8) ~= 0 then
				varint()
			end
			if version >= 12 then
				pos = protoStart + protoSize
			end

			protos[i] = p
		end

		local mainId = varint()
		return { strings = strings, protos = protos, main = protos[mainId + 1] }
	end)

	if not ok then
		return nil, tostring(result)
	end

	local chunk = result
	chunk.version = version
	chunk.typesVersion = typesVersion

	local vanillaErrors, robloxErrors = 0, 0
	for _, p in chunk.protos do
		vanillaErrors += countDecodeErrors(p.code, OPMAP_VANILLA)
		robloxErrors += countDecodeErrors(p.code, OPMAP_ROBLOX)
	end
	local map
	if robloxErrors < vanillaErrors then
		map = OPMAP_ROBLOX
		chunk.opEncoding = "roblox"
	else
		map = OPMAP_VANILLA
		chunk.opEncoding = "vanilla"
	end
	chunk.decodeErrors = math.min(vanillaErrors, robloxErrors)
	for _, p in chunk.protos do
		decodeInstructions(p, map)
	end

	return chunk
end

local LUA_KEYWORDS = {}
for _, w in
	{
		"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in",
		"local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while", "continue",
	}
do
	LUA_KEYWORDS[w] = true
end

local function isIdentifier(s)
	return s:match("^[%a_][%w_]*$") ~= nil and not LUA_KEYWORDS[s]
end

local function quote(s)
	return '"'
		.. s:gsub('[%c"\\\127-\255]', function(c)
			if c == "\n" then
				return "\\n"
			elseif c == "\r" then
				return "\\r"
			elseif c == "\t" then
				return "\\t"
			elseif c == '"' then
				return '\\"'
			elseif c == "\\" then
				return "\\\\"
			end
			return ("\\%03d"):format(c:byte())
		end)
		.. '"'
end

local function formatNumber(v)
	if v ~= v then
		return "(0/0)"
	elseif v == math.huge then
		return "math.huge"
	elseif v == -math.huge then
		return "-math.huge"
	end
	if v == math.floor(v) and math.abs(v) < 1e15 then
		if v == 0 and 1 / v < 0 then
			return "-0"
		end
		return ("%d"):format(v)
	end
	local s = ("%.14g"):format(v)
	if tonumber(s) ~= v then
		s = ("%.17g"):format(v)
	end
	return s
end

local function constString(p, kIndex)
	local k = p.constants[kIndex + 1]
	return k and k.type == "string" and k.value or ("?K" .. kIndex)
end

local function importPath(p, id)
	local count = rshift(id, 30)
	local parts = {}
	local indices = { band(rshift(id, 20), 1023), band(rshift(id, 10), 1023), band(id, 1023) }
	for i = 1, count do
		parts[i] = constString(p, indices[i])
	end
	return parts
end

local function importExpr(p, id)
	local parts = importPath(p, id)
	local out = {}
	for i, name in parts do
		if i == 1 then
			out[1] = if isIdentifier(name) then name else ("_G[%s]"):format(quote(name))
		elseif isIdentifier(name) then
			out[#out + 1] = "." .. name
		else
			out[#out + 1] = ("[%s]"):format(quote(name))
		end
	end
	return table.concat(out)
end

local function constText(p, k)
	if not k then
		return "?"
	elseif k.type == "nil" then
		return "nil"
	elseif k.type == "boolean" then
		return tostring(k.value)
	elseif k.type == "number" then
		return formatNumber(k.value)
	elseif k.type == "string" then
		return quote(k.value)
	elseif k.type == "import" then
		return importExpr(p, k.id)
	elseif k.type == "vector" then
		return ("Vector3.new(%s, %s, %s)"):format(
			formatNumber(k.x),
			formatNumber(k.y),
			formatNumber(k.z)
		)
	elseif k.type == "closure" then
		return "<closure proto " .. k.protoId .. ">"
	elseif k.type == "table" then
		return "<table template>"
	end
	return "?"
end

local JUMP_D = {
	JUMP = true, JUMPBACK = true, JUMPIF = true, JUMPIFNOT = true, JUMPIFEQ = true, JUMPIFLE = true,
	JUMPIFLT = true, JUMPIFNOTEQ = true, JUMPIFNOTLE = true, JUMPIFNOTLT = true, FORNPREP = true,
	FORNLOOP = true, FORGLOOP = true, FORGPREP = true, FORGPREP_INEXT = true, FORGPREP_NEXT = true,
	JUMPXEQKNIL = true, JUMPXEQKB = true, JUMPXEQKN = true, JUMPXEQKS = true, CMPPROTO = true,
}

local function describe(p, ins)
	local name, A, B, C, D = ins.name, ins.A, ins.B, ins.C, ins.D
	local aux = ins.aux
	local function K(idx)
		return constText(p, p.constants[idx + 1])
	end
	local target = ins.pc + 1 + D

	if name == "LOADB" then
		return ("R%d %s +%d"):format(A, tostring(B ~= 0), C), (C ~= 0 and ("-> %d"):format(ins.pc + 1 + C) or nil)
	elseif name == "LOADN" then
		return ("R%d %d"):format(A, D)
	elseif name == "LOADK" then
		return ("R%d K%d"):format(A, D), K(D)
	elseif name == "LOADKX" then
		return ("R%d K%d"):format(A, aux), K(aux)
	elseif name == "GETGLOBAL" or name == "SETGLOBAL" then
		return ("R%d K%d"):format(A, aux), K(aux)
	elseif name == "GETUPVAL" or name == "SETUPVAL" then
		return ("R%d U%d"):format(A, B), p.upvalNames[B + 1]
	elseif name == "GETIMPORT" then
		return ("R%d K%d"):format(A, D), importExpr(p, aux)
	elseif name == "GETTABLEKS" or name == "SETTABLEKS" or name == "NAMECALL" then
		return ("R%d R%d K%d"):format(A, B, aux), K(aux)
	elseif name == "GETTABLEN" or name == "SETTABLEN" then
		return ("R%d R%d [%d]"):format(A, B, C + 1)
	elseif name == "NEWCLOSURE" then
		return ("R%d P%d"):format(A, D)
	elseif name == "DUPCLOSURE" or name == "DUPTABLE" then
		return ("R%d K%d"):format(A, D), K(D)
	elseif name == "CALL" or name == "CALLFB" then
		return ("R%d args=%s results=%s"):format(A, B == 0 and "..." or B - 1, C == 0 and "..." or C - 1)
	elseif name == "RETURN" then
		return ("R%d n=%s"):format(A, B == 0 and "..." or B - 1)
	elseif name == "JUMP" or name == "JUMPBACK" then
		return ("-> %d"):format(target)
	elseif name == "JUMPX" then
		return ("-> %d"):format(ins.pc + 1 + ins.E)
	elseif name == "JUMPIF" or name == "JUMPIFNOT" then
		return ("R%d -> %d"):format(A, target)
	elseif
		name == "JUMPIFEQ" or name == "JUMPIFLE" or name == "JUMPIFLT"
		or name == "JUMPIFNOTEQ" or name == "JUMPIFNOTLE" or name == "JUMPIFNOTLT"
	then
		return ("R%d R%d -> %d"):format(A, aux, target)
	elseif name == "JUMPXEQKNIL" then
		return ("R%d nil%s -> %d"):format(A, rshift(aux, 31) == 1 and " (not)" or "", target)
	elseif name == "JUMPXEQKB" then
		return ("R%d %s%s -> %d"):format(A, tostring(band(aux, 1) == 1), rshift(aux, 31) == 1 and " (not)" or "", target)
	elseif name == "JUMPXEQKN" or name == "JUMPXEQKS" then
		return ("R%d K%d%s -> %d"):format(A, band(aux, 0xffffff), rshift(aux, 31) == 1 and " (not)" or "", target),
			K(band(aux, 0xffffff))
	elseif name == "ADDK" or name == "SUBK" or name == "MULK" or name == "DIVK" or name == "MODK"
		or name == "POWK" or name == "ANDK" or name == "ORK" or name == "IDIVK" then
		return ("R%d R%d K%d"):format(A, B, C), K(C)
	elseif name == "SUBRK" or name == "DIVRK" then
		return ("R%d K%d R%d"):format(A, B, C), K(B)
	elseif name == "CONCAT" then
		return ("R%d R%d..R%d"):format(A, B, C)
	elseif name == "NEWTABLE" then
		return ("R%d hash=%d array=%d"):format(A, B == 0 and 0 or 2 ^ (B - 1), aux)
	elseif name == "SETLIST" then
		return ("R%d R%d n=%s start=%d"):format(A, B, C == 0 and "..." or C - 1, aux)
	elseif name == "FORGLOOP" then
		return ("R%d -> %d vars=%d"):format(A, target, band(aux, 255))
	elseif JUMP_D[name] then
		return ("R%d -> %d"):format(A, target)
	elseif name == "GETVARARGS" then
		return ("R%d n=%s"):format(A, B == 0 and "..." or B - 1)
	elseif name == "PREPVARARGS" then
		return ("%d"):format(A)
	elseif name == "FASTCALL" then
		return ("builtin=%d -> %d"):format(A, ins.pc + 1 + C)
	elseif name == "CAPTURE" then
		local kinds = { [0] = "VAL R", "REF R", "UPVAL U" }
		return (kinds[A] or "?") .. B
	end

	local fmt = ins.name and OPS[ins.op] and OPS[ins.op].fmt or ""
	if fmt == "A" then
		return ("R%d"):format(A)
	elseif fmt == "AB" then
		return ("R%d R%d"):format(A, B)
	elseif fmt == "ABC" then
		return ("R%d R%d R%d"):format(A, B, C)
	elseif fmt == "AD" then
		return ("R%d %d"):format(A, D)
	elseif fmt == "D" then
		return tostring(D)
	elseif fmt == "E" then
		return tostring(ins.E)
	end
	return ""
end

local function disassembleProto(chunk, p, index)
	local out = {}
	local label = p.debugName or "(anonymous)"
	out[#out + 1] = ("function #%d %s: params=%d upvalues=%d%s maxstack=%d line=%d"):format(
		index - 1,
		label,
		p.numParams,
		p.numUpvals,
		p.isVararg and " vararg" or "",
		p.maxStack,
		p.lineDefined
	)
	for _, ins in p.insns do
		local operands, comment = describe(p, ins)
		local line = ("  %04d  %-14s %s"):format(ins.pc, ins.name, operands)
		if comment then
			line ..= "  ; " .. comment
		end
		local srcLine = p.lines[ins.pc + 1]
		if srcLine then
			line ..= (comment and "" or "  ;") .. (" [line %d]"):format(srcLine)
		end
		out[#out + 1] = line
	end
	return out
end

local SKIP_OPS = {
	NOP = true, BREAK = true, COVERAGE = true, NATIVECALL = true, CLOSEUPVALS = true, PREPVARARGS = true,
	FASTCALL = true, FASTCALL1 = true, FASTCALL2 = true, FASTCALL2K = true, FASTCALL3 = true,
	FASTPCALL = true,
}

local UDATA_ALIASES = { GETUDATAKS = "GETTABLEKS", SETUDATAKS = "SETTABLEKS", NAMECALLUDATA = "NAMECALL" }

local UNCOND = { JUMP = true, JUMPBACK = true, JUMPX = true }

local COND = {
	JUMPIF = true, JUMPIFNOT = true, JUMPIFEQ = true, JUMPIFLE = true, JUMPIFLT = true,
	JUMPIFNOTEQ = true, JUMPIFNOTLE = true, JUMPIFNOTLT = true, JUMPXEQKNIL = true,
	JUMPXEQKB = true, JUMPXEQKN = true, JUMPXEQKS = true,
}

local LOOP_OPS = { FORNPREP = true, FORNLOOP = true, FORGPREP = true, FORGLOOP = true }

local STMT_OPS = {
	CALL = true, SETGLOBAL = true, SETUPVAL = true, SETTABLE = true, SETTABLEKS = true,
	SETTABLEN = true, SETLIST = true,
}

local SINGLE_WRITE = {
	LOADNIL = true, LOADB = true, LOADN = true, LOADK = true, LOADKX = true, GETGLOBAL = true,
	GETUPVAL = true, GETIMPORT = true, NEWTABLE = true, DUPTABLE = true,
}

local TRIVIAL_OPS = { LOADNIL = true, LOADN = true, LOADK = true, LOADKX = true }

local JUMPS_WHEN_TRUE = { JUMPIF = true, JUMPIFEQ = true, JUMPIFLE = true, JUMPIFLT = true }

local BINARY = {
	ADD = { "+", 5 }, SUB = { "-", 5 }, MUL = { "*", 6 }, DIV = { "/", 6 }, MOD = { "%", 6 },
	POW = { "^", 8 }, IDIV = { "//", 6 }, AND = { "and", 2 }, OR = { "or", 1 },
}

local BINARY_K = {
	ADDK = { "ADD", true }, SUBK = { "SUB", true }, MULK = { "MUL", true }, DIVK = { "DIV", true },
	MODK = { "MOD", true }, POWK = { "POW", true }, IDIVK = { "IDIV", true }, ANDK = { "AND", true },
	ORK = { "OR", true }, SUBRK = { "SUB", false }, DIVRK = { "DIV", false },
}

local FLIP = { ["<"] = ">", ["<="] = ">=" }

local PREC_ATOM = 100
local PREC_LITERAL = 99
local PREC_UNARY = 7
local PREC_COMPARE = 3

local function atom(s)
	return { s = s, p = PREC_ATOM }
end

local function wrap(e, minPrec)
	if e.p >= minPrec then
		return e.s
	end
	return "(" .. e.s .. ")"
end

local function indentText(text)
	return (("\t" .. text):gsub("\n", "\n\t"))
end

local function constExpr(p, k)
	if not k then
		return { s = "nil", p = PREC_LITERAL, lit = true }
	elseif k.type == "number" then
		local s = formatNumber(k.value)
		return { s = s, p = if s:sub(1, 1) == "-" then PREC_UNARY else PREC_LITERAL, lit = true }
	elseif k.type == "vector" then
		return atom(constText(p, k))
	end
	return { s = constText(p, k), p = PREC_LITERAL, lit = true }
end

local function indexSuffix(keyName)
	if isIdentifier(keyName) then
		return "." .. keyName
	end
	return ("[%s]"):format(quote(keyName))
end

local function exprKeySuffix(e)
	local name = e.lit and e.s:match('^"([%a_][%w_]*)"$')
	if name and isIdentifier(name) then
		return "." .. name
	end
	return "[" .. e.s .. "]"
end

local function compare(op, l, r)
	if l.lit and not r.lit then
		if op == "<" or op == "<=" then
			op, l, r = FLIP[op], r, l
		elseif op == "==" or op == "~=" then
			l, r = r, l
		end
	end
	return {
		s = wrap(l, PREC_COMPARE + 1) .. " " .. op .. " " .. wrap(r, PREC_COMPARE + 1),
		p = PREC_COMPARE,
		op = op,
		l = l,
		r = r,
	}
end

local function negate(e)
	if e.op == "==" or e.op == "~=" then
		return compare(if e.op == "==" then "~=" else "==", e.l, e.r)
	end
	if e.notOf then
		return e.notOf
	end
	return { s = "not " .. wrap(e, PREC_UNARY), p = PREC_UNARY, notOf = e }
end

local function logicAnd(a, b)
	return { s = wrap(a, 2) .. " and " .. wrap(b, 2), p = 2 }
end

local function logicOr(a, b)
	return { s = wrap(a, 1) .. " or " .. wrap(b, 1), p = 1 }
end

local function regRange(first, count)
	local out = {}
	for i = 0, count - 1 do
		out[#out + 1] = first + i
	end
	return out
end

local function isTerminator(ins)
	local nm = ins.name
	return UNCOND[nm] or COND[nm] or nm == "RETURN" or LOOP_OPS[nm] or (nm == "LOADB" and ins.C ~= 0)
end

local function lowerFirst(s)
	return s:sub(1, 1):lower() .. s:sub(2)
end

local function suggestName(text)
	local service = text:match(':GetService%("([%a_][%w_]*)"%)$')
	if service then
		return service
	end
	local class = text:match('^Instance%.new%("([%a_][%w_]*)"')
	if class then
		return lowerFirst(class)
	end
	local child = text:match(':WaitForChild%("([%a_][%w_]*)"%)$')
		or text:match(':FindFirstChild%("([%a_][%w_]*)"%)$')
		or text:match(':FindFirstChildOfClass%("([%a_][%w_]*)"%)$')
	if child then
		return lowerFirst(child)
	end
	local simple = {
		{ ":GetChildren%(%)$", "children" },
		{ ":GetDescendants%(%)$", "descendants" },
		{ ":Clone%(%)$", "clone" },
		{ ":Connect%(", "connection" },
		{ ":Once%(", "connection" },
		{ "^tick%(%)$", "now" },
		{ "^os%.clock%(%)$", "now" },
		{ "^os%.time%(%)$", "time" },
		{ "^tostring%(", "text" },
		{ "^string%.format%(", "text" },
		{ "^tonumber%(", "number" },
		{ "^CFrame%.", "cframe" },
		{ "^Color3%.", "color" },
		{ "^TweenInfo%.new", "tweenInfo" },
		{ ":Create%(", "tween" },
		{ "^coroutine%.create%(", "thread" },
		{ "^task%.spawn%(", "thread" },
		{ "^task%.delay%(", "thread" },
	}
	for _, rule in simple do
		if text:find(rule[1]) then
			return rule[2]
		end
	end
	local required = text:match("^require%((.-)%)$")
	if required then
		local last = required:match("([%a_][%w_]*)$")
		if last then
			return lowerFirst(last)
		end
	end
	local field = text:match("^[%a_][%w_%.]*%.([%a_][%w_]*)$")
	if field and #field <= 24 then
		return lowerFirst(field)
	end
	return nil
end

local function computeAccess(ins)
	local nm, A, B, C = ins.name, ins.A, ins.B, ins.C
	local reads, writes = {}, {}

	if SINGLE_WRITE[nm] then
		writes = { A }
	elseif nm == "MOVE" then
		reads, writes = { B }, { A }
	elseif nm == "SETGLOBAL" or nm == "SETUPVAL" then
		reads = { A }
	elseif nm == "GETTABLE" then
		reads, writes = { B, C }, { A }
	elseif nm == "SETTABLE" then
		reads = { A, B, C }
	elseif nm == "GETTABLEKS" or nm == "GETTABLEN" then
		reads, writes = { B }, { A }
	elseif nm == "SETTABLEKS" or nm == "SETTABLEN" then
		reads = { A, B }
	elseif nm == "NAMECALL" then
		reads, writes = { B }, { A, A + 1 }
	elseif nm == "CALL" then
		reads = { A }
		if B == 0 then
			for r = A + 1, ins.openFrom - 1 do
				reads[#reads + 1] = r
			end
			reads[#reads + 1] = ins.openFrom
		else
			for r = A + 1, A + B - 1 do
				reads[#reads + 1] = r
			end
		end
		if C == 0 then
			writes = { A }
		elseif C >= 2 then
			writes = regRange(A, C - 1)
		end
	elseif nm == "RETURN" then
		if B == 0 then
			reads = regRange(A, ins.openFrom - A)
			reads[#reads + 1] = ins.openFrom
		else
			reads = regRange(A, B - 1)
		end
	elseif nm == "SETLIST" then
		reads = { A }
		if C == 0 then
			for r = B, ins.openFrom - 1 do
				reads[#reads + 1] = r
			end
			reads[#reads + 1] = ins.openFrom
		else
			for r = B, B + C - 2 do
				reads[#reads + 1] = r
			end
		end
	elseif nm == "JUMPIF" or nm == "JUMPIFNOT" then
		reads = { A }
	elseif
		nm == "JUMPIFEQ" or nm == "JUMPIFLE" or nm == "JUMPIFLT"
		or nm == "JUMPIFNOTEQ" or nm == "JUMPIFNOTLE" or nm == "JUMPIFNOTLT"
	then
		reads = { A, ins.aux }
	elseif nm == "JUMPXEQKNIL" or nm == "JUMPXEQKB" or nm == "JUMPXEQKN" or nm == "JUMPXEQKS" then
		reads = { A }
	elseif BINARY[nm] then
		reads, writes = { B, C }, { A }
	elseif BINARY_K[nm] then
		reads, writes = { if BINARY_K[nm][2] then B else C }, { A }
	elseif nm == "CONCAT" then
		reads, writes = regRange(B, C - B + 1), { A }
	elseif nm == "NOT" or nm == "MINUS" or nm == "LENGTH" then
		reads, writes = { B }, { A }
	elseif nm == "NEWCLOSURE" or nm == "DUPCLOSURE" then
		for _, cap in ins.captures do
			if cap.kind ~= 2 and cap.index ~= A then
				reads[#reads + 1] = cap.index
			end
		end
		writes = { A }
	elseif nm == "FORNPREP" then
		reads, writes = { A, A + 1, A + 2 }, { A + 2 }
	elseif nm == "FORNLOOP" then
		writes = { A + 2 }
	elseif nm == "FORGPREP" then
		reads, writes = { A, A + 1, A + 2 }, regRange(A + 3, ins.nvars)
	elseif nm == "FORGLOOP" then
		writes = regRange(A + 3, ins.nvars)
	elseif nm == "GETVARARGS" then
		writes = if B == 0 then { A } else regRange(A, B - 1)
	elseif UNCOND[nm] then
		reads = {}
	else
		error("unsupported instruction " .. nm, 0)
	end

	ins.reads, ins.writes = reads, writes
end

local function buildInstructionList(p)
	local list = {}
	local pending = nil
	for _, ins in p.insns do
		if not OPS[ins.op] then
			error("unknown opcode " .. ins.name, 0)
		end
		local alias = UDATA_ALIASES[ins.name]
		if alias then
			ins.name = alias
			ins.aux = bit32.band(ins.aux, 0xffff)
		elseif ins.name == "CALLFB" then
			ins.name = "CALL"
		elseif ins.name == "FORGPREP_INEXT" or ins.name == "FORGPREP_NEXT" then
			ins.name = "FORGPREP"
		end
		ins.folded, ins.forGen, ins.selfCapture, ins.captures = nil, nil, nil, nil
		ins.openFrom, ins.target, ins.nvars = nil, nil, nil
		local nm = ins.name
		if nm == "CAPTURE" then
			if pending then
				pending.captures[#pending.captures + 1] = { kind = ins.A, index = ins.B }
			end
		elseif not SKIP_OPS[nm] then
			list[#list + 1] = ins
			ins.idx = #list
			if nm == "NEWCLOSURE" or nm == "DUPCLOSURE" then
				ins.captures = {}
				pending = ins
			else
				pending = nil
			end
		end
	end
	return list
end

local function resolveTargets(p, list)
	local nextIdx = {}
	local cursor = #list + 1
	for i = #p.insns, 1, -1 do
		local ins = p.insns[i]
		if ins.idx and not SKIP_OPS[ins.name] and ins.name ~= "CAPTURE" then
			cursor = ins.idx
		end
		for w = 0, ins.len - 1 do
			nextIdx[ins.pc + w] = cursor
		end
	end

	for _, ins in list do
		local nm = ins.name
		local tpc
		if nm == "JUMPX" then
			tpc = ins.pc + 1 + ins.E
		elseif nm == "LOADB" then
			if ins.C ~= 0 then
				tpc = ins.pc + 1 + ins.C
			end
		elseif JUMP_D[nm] then
			tpc = ins.pc + 1 + ins.D
		end
		if tpc then
			ins.target = nextIdx[tpc]
			if not ins.target then
				error("jump leaves the function", 0)
			end
		end
	end

	for _, ins in list do
		if ins.name == "FORGPREP" then
			local loop = list[ins.target]
			if not loop or loop.name ~= "FORGLOOP" then
				error("generic for prep without a loop instruction", 0)
			end
			ins.nvars = bit32.band(loop.aux, 255)
			loop.nvars = ins.nvars
		end
	end
end

local function linkOpenResults(list)
	local open = nil
	for _, ins in list do
		local nm = ins.name
		local consumes = (nm == "CALL" and ins.B == 0) or (nm == "RETURN" and ins.B == 0)
			or (nm == "SETLIST" and ins.C == 0)
		if consumes then
			if not open then
				error("open-ended values without a producer", 0)
			end
			ins.openFrom = open
			open = nil
		end
		if (nm == "CALL" and ins.C == 0) or (nm == "GETVARARGS" and ins.B == 0) then
			open = ins.A
		end
	end
end

local function buildBlocks(list)
	local leader = { true }
	for _, ins in list do
		if isTerminator(ins) then
			if ins.target then
				leader[ins.target] = true
			end
			leader[ins.idx + 1] = true
		end
	end

	local blocks, blockOf = {}, {}
	local current = nil
	for i = 1, #list do
		if leader[i] or not current then
			current = { index = #blocks + 1, start = i, stop = i, succs = {}, preds = {} }
			blocks[#blocks + 1] = current
		end
		current.stop = i
		blockOf[i] = current
	end

	for _, blk in blocks do
		local last = list[blk.stop]
		local nm = last.name
		local function edge(idx)
			local to = blockOf[idx]
			if to then
				table.insert(blk.succs, to)
				table.insert(to.preds, blk)
			end
		end
		if UNCOND[nm] or (nm == "LOADB" and last.C ~= 0) or nm == "FORGPREP" then
			edge(last.target)
		elseif COND[nm] or nm == "FORNPREP" or nm == "FORNLOOP" or nm == "FORGLOOP" then
			edge(last.target)
			edge(blk.stop + 1)
		elseif nm ~= "RETURN" then
			edge(blk.stop + 1)
		end
	end

	return blocks, blockOf
end

local function analyze(chunk, p, upvalNames)
	local fn = { chunk = chunk, p = p }
	local list = buildInstructionList(p)
	fn.list = list
	resolveTargets(p, list)
	linkOpenResults(list)
	for _, ins in list do
		computeAccess(ins)
	end
	local blocks, blockOf = buildBlocks(list)
	fn.blocks, fn.blockOf = blocks, blockOf

	local defs = {}
	local parent = {}
	fn.defs = defs

	local function newDef(reg, ins, kind)
		local d = {
			id = #defs + 1,
			reg = reg,
			ins = ins,
			idx = if ins then ins.idx else 0,
			kind = kind or "def",
			useList = {},
			inline = false,
		}
		d.pos = d.idx
		defs[d.id] = d
		parent[d.id] = d.id
		return d
	end

	local function find(x)
		local root = x
		while parent[root] ~= root do
			root = parent[root]
		end
		while parent[x] ~= root do
			local nxt = parent[x]
			parent[x] = root
			x = nxt
		end
		return root
	end

	local function union(a, b)
		local ra, rb = find(a), find(b)
		if ra ~= rb then
			parent[rb] = ra
		end
	end

	local paramDefs = {}
	for r = 0, p.numParams - 1 do
		paramDefs[r] = newDef(r, nil, "param")
	end
	for _, ins in list do
		ins.defs = {}
		for k, reg in ins.writes do
			ins.defs[k] = newDef(reg, ins)
		end
	end

	local gen = {}
	for bi, blk in blocks do
		local g = {}
		for i = blk.start, blk.stop do
			for _, d in list[i].defs do
				g[d.reg] = d.id
			end
		end
		gen[bi] = g
	end

	local inSet = {}
	for bi = 1, #blocks do
		inSet[bi] = {}
	end
	if #blocks > 0 then
		for r, d in paramDefs do
			inSet[1][r] = { [d.id] = true }
		end
	end

	local changed, rounds = true, 0
	while changed do
		changed = false
		rounds += 1
		if rounds > 300 then
			error("dataflow did not settle", 0)
		end
		for bi, blk in blocks do
			local g, inn = gen[bi], inSet[bi]
			for _, succ in blk.succs do
				local target = inSet[succ.index]
				for reg, id in g do
					local set = target[reg]
					if not set then
						set = {}
						target[reg] = set
					end
					if not set[id] then
						set[id] = true
						changed = true
					end
				end
				for reg, set in inn do
					if not g[reg] then
						local ts = target[reg]
						if not ts then
							ts = {}
							target[reg] = ts
						end
						for id in set do
							if not ts[id] then
								ts[id] = true
								changed = true
							end
						end
					end
				end
			end
		end
	end

	local phantoms = {}
	local function phantom(reg)
		local d = phantoms[reg]
		if not d then
			d = newDef(reg, nil, "unknown")
			phantoms[reg] = d
		end
		return d
	end

	for bi, blk in blocks do
		local last = {}
		for i = blk.start, blk.stop do
			local ins = list[i]
			ins.readSet = {}
			local seen = {}
			for _, reg in ins.reads do
				local ids = seen[reg]
				if not ids then
					if last[reg] then
						ids = { last[reg] }
					else
						ids = {}
						local set = inSet[bi][reg]
						if set then
							for id in set do
								ids[#ids + 1] = id
							end
							table.sort(ids)
						else
							ids[1] = phantom(reg).id
						end
					end
					seen[reg] = ids
					ins.readSet[reg] = ids
					for k = 2, #ids do
						union(ids[1], ids[k])
					end
				end
				for _, id in ids do
					local d = defs[id]
					d.useList[#d.useList + 1] = ins.idx
				end
			end
			for _, d in ins.defs do
				last[d.reg] = d.id
			end
		end
	end

	for _, ins in list do
		if ins.captures then
			local own = ins.defs[1]
			for _, cap in ins.captures do
				if cap.kind ~= 2 then
					if cap.index == ins.A then
						ins.selfCapture = true
						own.forceLocal = true
					else
						for _, id in ins.readSet[cap.index] do
							defs[id].forceLocal = true
						end
					end
				end
			end
		end
	end

	local function singleDef(ins, reg)
		local set = ins.readSet and ins.readSet[reg]
		if set and #set == 1 then
			return defs[set[1]]
		end
		return nil
	end
	fn.singleDef = singleDef

	for _, ins in list do
		if ins.name == "CALL" then
			local fd = singleDef(ins, ins.A)
			if fd and fd.ins and fd.ins.name == "NAMECALL" and fd.reg == fd.ins.A then
				local nc = fd.ins
				for _, id in nc.readSet[nc.B] do
					local obj = defs[id]
					if blockOf[ins.idx] == blockOf[nc.idx] then
						for k, u in obj.useList do
							if u == nc.idx then
								obj.useList[k] = ins.idx
								break
							end
						end
					else
						obj.forceLocal = true
					end
				end
			end
		end
	end

	local declarationOf = {}
	for _, d in defs do
		if d.kind == "param" then
			declarationOf[d.reg .. ":0"] = d
		elseif d.ins then
			declarationOf[d.reg .. ":" .. (d.ins.pc + d.ins.len)] = d
		end
	end

	local declaredAt = {}
	for _, lv in p.locVars do
		declaredAt[lv.reg] = declaredAt[lv.reg] or {}
		declaredAt[lv.reg][lv.startPc] = lv.name
	end
	local activeLocal
	function activeLocal(reg, pc)
		for _, lv in p.locVars do
			if lv.reg == reg and lv.startPc <= pc and pc < lv.endPc then
				return lv
			end
		end
		return nil
	end

	for _, d in defs do
		if d.ins and not (declaredAt[d.reg] and declaredAt[d.reg][d.ins.pc + d.ins.len]) then
			local lv = activeLocal(d.reg, d.ins.pc)
			if lv then
				local decl = declarationOf[d.reg .. ":" .. lv.startPc]
				if decl and decl ~= d then
					union(decl.id, d.id)
				end
			end
		end
	end

	local webs = {}
	fn.webs = webs
	for _, d in defs do
		local root = find(d.id)
		local w = webs[root]
		if not w then
			w = { id = root, defs = {}, min = math.huge, max = -1, declared = false }
			webs[root] = w
		end
		d.web = w
		w.defs[#w.defs + 1] = d
		w.min = math.min(w.min, d.idx)
		w.max = math.max(w.max, d.idx)
		for _, u in d.useList do
			w.min = math.min(w.min, u)
			w.max = math.max(w.max, u)
		end
	end


	local reserved = {}
	for _, taken in upvalNames or {} do
		reserved[taken] = true
	end
	fn.paramNames = {}
	for r = 0, p.numParams - 1 do
		local name
		for _, lv in p.locVars do
			if lv.reg == r and lv.startPc == 0 then
				name = lv.name
				break
			end
		end
		if not name then
			name = "arg" .. (r + 1)
			while reserved[name] do
				name ..= "_"
			end
		end
		fn.paramNames[r + 1] = name
		local w = paramDefs[r].web
		w.name = name
		w.declared = true
		w.fixed = true
	end
	for _, d in phantoms do
		d.web.name = "r" .. d.reg
		d.web.declared = true
		d.web.fixed = true
	end

	fn.debugNames = {}
	for _, d in defs do
		if d.ins and not d.web.debugName then
			local pc, len = d.ins.pc, d.ins.len
			local active = activeLocal(d.reg, pc)
			local name = (declaredAt[d.reg] and declaredAt[d.reg][pc + len]) or (active and active.name)
			if name then
				d.web.debugName = name
				fn.debugNames[name] = true
			end
		end
	end

	fn.globals = {}
	for _, ins in list do
		if ins.name == "GETGLOBAL" or ins.name == "SETGLOBAL" then
			fn.globals[constString(p, ins.aux)] = true
		elseif ins.name == "GETIMPORT" then
			local parts = importPath(p, ins.aux)
			if parts[1] then
				fn.globals[parts[1]] = true
			end
		end
	end

	fn.loopsAt = {}
	for _, ins in list do
		if (UNCOND[ins.name] or COND[ins.name]) and ins.target and ins.target <= ins.idx then
			local lp = fn.loopsAt[ins.target]
			if not lp then
				lp = { head = ins.target, back = ins.idx, started = false }
				fn.loopsAt[ins.target] = lp
			elseif ins.idx > lp.back then
				lp.back = ins.idx
			end
		end
	end
	for _, lp in fn.loopsAt do
		lp.uncond = UNCOND[list[lp.back].name] == true
	end

	for _, ins in list do
		if ins.name == "FORGPREP" then
			local d = singleDef(ins, ins.A)
			local call = d and d.ins
			if call and call.name == "CALL" and call.A == ins.A and call.C == 4 then
				local ok = true
				for k = 1, 3 do
					local x = call.defs[k]
					if #x.web.defs ~= 1 or #x.useList ~= 1 or x.useList[1] ~= ins.idx then
						ok = false
					end
				end
				if ok then
					call.forGen = true
				end
			end
		end
	end

	local function depsOf(d)
		local out = {}
		local function addFrom(ins)
			for _, reg in ins.reads do
				for _, id in ins.readSet[reg] do
					local e = defs[id]
					if e ~= d then
						out[#out + 1] = e
					end
				end
			end
		end
		addFrom(d.ins)
		if d.fold then
			for _, s in d.fold.sets do
				addFrom(s)
			end
		end
		return out
	end

	for _, ins in list do
		if ins.name == "NEWTABLE" or ins.name == "DUPTABLE" then
			local d = ins.defs[1]
			if #d.web.defs == 1 and not d.web.debugName and not d.forceLocal then
				local blk = blockOf[ins.idx]
				local run = {}
				local j = ins.idx + 1
				while j <= blk.stop do
					local x = list[j]
					if isTerminator(x) then
						break
					end
					local nm = x.name
					local isSet = nm == "SETTABLEKS" or nm == "SETTABLEN" or nm == "SETTABLE" or nm == "SETLIST"
					if isSet and singleDef(x, if nm == "SETLIST" then x.A else x.B) == d then
						run[#run + 1] = x
					elseif isSet or nm == "SETGLOBAL" or nm == "SETUPVAL" or (nm == "CALL" and x.C == 1) then
						break
					end
					j += 1
				end

				while #run > 0 do
					local lastIdx = run[#run].idx
					local inRun = {}
					for _, s in run do
						inRun[s] = true
					end
					local ok = true
					for k = ins.idx + 1, lastIdx - 1 do
						local y = list[k]
						if not inRun[y] then
							for _, e in y.defs do
								if #e.web.defs ~= 1 or #e.useList ~= 1 or e.useList[1] > lastIdx
									or e.forceLocal or e.web.debugName then
									ok = false
								end
							end
						end
					end
					if ok then
						break
					end
					run[#run] = nil
				end

				if #run > 0 then
					for _, s in run do
						s.folded = true
						s.foldOwner = d
						for k, u in d.useList do
							if u == s.idx then
								table.remove(d.useList, k)
								break
							end
						end
					end
					d.fold = { sets = run, endIdx = run[#run].idx }
					d.pos = d.fold.endIdx
				end
			end
		end
	end

	local function isStmtIns(x)
		return STMT_OPS[x.name] and not x.folded
	end

	local order = {}
	for _, d in defs do
		order[#order + 1] = d
	end
	table.sort(order, function(a, b)
		if a.pos ~= b.pos then
			return a.pos < b.pos
		end
		return a.id < b.id
	end)

	local demoted = {}

	local function feeds(j, consumer, depth)
		local x = list[j]
		if #x.defs == 0 or depth > 12 then
			return false
		end
		for _, e in x.defs do
			if #e.useList ~= 1 then
				return false
			end
			local u = e.useList[1]
			if u ~= consumer then
				if u <= j or u > consumer or not feeds(u, consumer, depth + 1) then
					return false
				end
			end
		end
		return true
	end

	local function decide(d)
		local ins = d.ins
		if demoted[d] or not ins or d.forceLocal or d.web.debugName or LOOP_OPS[ins.name] then
			return
		end
		if #d.web.defs ~= 1 or #d.useList == 0 then
			return
		end
		local nm = ins.name
		if (nm == "CALL" and ins.C >= 3 and not ins.forGen) or (nm == "GETVARARGS" and ins.B > 2) then
			return
		end
		if nm == "LOADB" and ins.C ~= 0 then
			return
		end

		local origin = d.pos
		local tree = { [ins.idx] = true }
		local readWebs = {}
		for _, e in depsOf(d) do
			if e.inline then
				if e.origin and e.origin < origin then
					origin = e.origin
				end
				for k in e.tree do
					tree[k] = true
				end
				for rw in e.readWebs do
					readWebs[rw] = true
				end
			else
				readWebs[e.web] = true
			end
		end
		d.origin, d.tree, d.readWebs = origin, tree, readWebs

		if nm == "NEWCLOSURE" or nm == "DUPCLOSURE" then
			local childId
			if nm == "NEWCLOSURE" then
				childId = p.children[ins.D + 1]
			else
				local k = p.constants[ins.D + 1]
				childId = k and k.protoId
			end
			local child = childId and chunk.protos[childId + 1]
			if child and child.debugName then
				return
			end
		end

		local always = TRIVIAL_OPS[nm] or nm == "LOADB" or nm == "GETUPVAL" or nm == "NAMECALL" or nm == "GETIMPORT"
			or (nm == "CALL" and (ins.C == 0 or ins.forGen)) or (nm == "GETVARARGS" and ins.B == 0)
		if always then
			d.inline = true
			return
		end
		if nm == "MOVE" then
			local src = singleDef(ins, ins.B)
			if src and src.ins then
				local sn = src.ins.name
				if src.inline and (TRIVIAL_OPS[sn] or sn == "GETUPVAL") then
					d.inline = true
					return
				end
				if not src.inline and #src.web.defs == 1 and not LOOP_OPS[sn] then
					d.inline = true
					return
				end
			elseif src and (src.kind == "param") and #src.web.defs == 1 then
				d.inline = true
				return
			end
		end

		if #d.useList ~= 1 then
			return
		end
		local useIdx = d.useList[1]
		if blockOf[useIdx] ~= blockOf[d.idx] or useIdx < d.pos then
			return
		end
		for j = origin + 1, useIdx - 1 do
			if not tree[j] then
				local x = list[j]
				if isStmtIns(x) then
					if x.defs[1] and x.defs[1].reg > d.reg and feeds(j, useIdx, 0) then
						d.exempt = d.exempt or {}
						d.exempt[#d.exempt + 1] = j
					else
						return
					end
				end
				for _, e in x.defs do
					if readWebs[e.web] then
						return
					end
				end
			end
		end
		d.inline = true
	end

	local changed
	repeat
		for _, d in defs do
			d.inline, d.exempt, d.origin, d.tree, d.readWebs = false, nil, nil, nil, nil
		end
		for _, d in order do
			decide(d)
		end
		changed = false
		for _, d in defs do
			if d.inline and d.exempt then
				for _, j in d.exempt do
					for _, e in list[j].defs do
						if not e.inline and not demoted[d] then
							demoted[d] = true
							changed = true
						end
					end
				end
			end
		end
	until not changed

	fn.isStmtIns = isStmtIns
	fn.depsOf = depsOf
	return fn
end

local function emitFunction(chunk, p, upvalNames, flat, forceTable)
	local fn = analyze(chunk, p, upvalNames)
	local list, defs, blockOf = fn.list, fn.defs, fn.blockOf
	local singleDef, isStmtIns = fn.singleDef, fn.isStmtIns

	local used = {}
	for name in fn.globals do
		used[name] = true
	end
	for name in fn.debugNames do
		used[name] = true
	end
	for _, name in fn.paramNames do
		used[name] = true
	end
	for _, name in upvalNames do
		used[name] = true
	end
	for word in LUA_KEYWORDS do
		used[word] = true
	end

	local counter = 0
	local activeLoop = {}
	local hoisted = {}
	local tableName
	local rootList = {}
	local curList = rootList
	local regions = { { start = 1, stop = #list + 1 } }
	local loopStack = {}
	local skip = {}
	local skipJump = {}
	local emitRange
	local buildExpr

	local function statement(text)
		curList[#curList + 1] = { k = "line", s = text }
	end

	local function uniqueName(base)
		if base and isIdentifier(base) then
			if not used[base] and not activeLoop[base] then
				used[base] = true
				return base
			end
			local n = 2
			while used[base .. n] do
				n += 1
			end
			used[base .. n] = true
			return base .. n
		end
		repeat
			counter += 1
		until not used["v" .. counter]
		used["v" .. counter] = true
		return "v" .. counter
	end

	local function willHoist(w)
		if w.fixed or w.min < 1 then
			return false
		end
		if blockOf[w.min] ~= blockOf[math.min(w.max, #list)] then
			return true
		end
		for _, d in w.defs do
			if d.idx == w.min then
				return false
			end
		end
		return true
	end

	local debugClaims = {}
	for _, w in fn.webs do
		if w.fixed and w.name then
			debugClaims[w.name] = debugClaims[w.name] or {}
			table.insert(debugClaims[w.name], w)
		end
	end

	local function webName(w, hint)
		if w.name then
			return w.name
		end
		if w.debugName then
			local name = w.debugName
			local claims = debugClaims[name]
			if not claims then
				claims = {}
				debugClaims[name] = claims
			end
			for _, other in claims do
				if w.min <= other.max and other.min <= w.max then
					name = uniqueName(w.debugName)
					break
				end
			end
			table.insert(claims, w)
			w.name = name
		else
			w.name = uniqueName(w.hintName or (hint and suggestName(hint)))
		end
		if tableName and willHoist(w) then
			w.name = tableName .. "." .. w.name
		end
		return w.name
	end

	local function readExpr(ins, reg)
		local set = ins.readSet[reg]
		local first = defs[set[1]]
		if #set == 1 and first.inline then
			return buildExpr(first)
		end
		return atom(webName(first.web))
	end

	local function explicitText(e, isLast, open)
		if isLast and not open and e.isCall then
			return "(" .. e.s .. ")"
		end
		return e.s
	end

	local function callExpr(ins)
		local A, B = ins.A, ins.B
		local fd = singleDef(ins, A)
		local method = fd and fd.ins and fd.ins.name == "NAMECALL" and fd.reg == fd.ins.A
		local first = if method then A + 2 else A + 1
		local argCount
		if B == 0 then
			argCount = ins.openFrom - first
		else
			argCount = B - 1 - (if method then 1 else 0)
		end
		if argCount < 0 then
			error("call has fewer arguments than its method receiver", 0)
		end
		local texts = {}
		for r = 0, argCount - 1 do
			texts[#texts + 1] = explicitText(readExpr(ins, first + r), r == argCount - 1, B == 0)
		end
		if B == 0 then
			texts[#texts + 1] = readExpr(ins, ins.openFrom).s
		end
		local args = table.concat(texts, ", ")
		if method then
			local nc = fd.ins
			local base = wrap(readExpr(nc, nc.B), PREC_ATOM)
			local name = constString(p, nc.aux)
			local result
			if isIdentifier(name) then
				result = atom(base .. ":" .. name .. "(" .. args .. ")")
			else
				result = atom(("%s[%s](%s%s)"):format(base, quote(name), base, if args ~= "" then ", " .. args else ""))
			end
			result.isCall = true
			return result
		end
		local result = atom(wrap(readExpr(ins, A), PREC_ATOM) .. "(" .. args .. ")")
		result.isCall = true
		return result
	end

	local function tableExpr(d)
		local parts = {}
		local ins = d.ins
		if ins.name == "DUPTABLE" then
			local template = p.constants[ins.D + 1]
			if template and template.values then
				for q, keyIndex in template.keys do
					local valueIndex = template.values[q]
					if valueIndex and valueIndex >= 0 then
						local key = p.constants[keyIndex + 1]
						local value = constExpr(p, p.constants[valueIndex + 1]).s
						if key and key.type == "string" and isIdentifier(key.value) then
							parts[#parts + 1] = key.value .. " = " .. value
						else
							parts[#parts + 1] = ("[%s] = %s"):format(constText(p, key), value)
						end
					end
				end
			end
		end
		local foldedSets = if d.fold then d.fold.sets else {}
		for _, s in foldedSets do
			local nm = s.name
			if nm == "SETTABLEKS" then
				local key = constString(p, s.aux)
				local value = readExpr(s, s.A).s
				if isIdentifier(key) then
					parts[#parts + 1] = key .. " = " .. value
				else
					parts[#parts + 1] = ("[%s] = %s"):format(quote(key), value)
				end
			elseif nm == "SETTABLEN" then
				parts[#parts + 1] = ("[%d] = %s"):format(s.C + 1, readExpr(s, s.A).s)
			elseif nm == "SETTABLE" then
				local suffix = exprKeySuffix(readExpr(s, s.C))
				local key = if suffix:sub(1, 1) == "." then suffix:sub(2) else suffix
				parts[#parts + 1] = key .. " = " .. readExpr(s, s.A).s
			else
				local count = if s.C == 0 then s.openFrom - s.B else s.C - 1
				for r = 0, count - 1 do
					parts[#parts + 1] = explicitText(readExpr(s, s.B + r), r == count - 1, s.C == 0)
				end
				if s.C == 0 then
					parts[#parts + 1] = readExpr(s, s.openFrom).s
				end
			end
		end
		if #parts == 0 then
			return { s = "{}", p = PREC_LITERAL }
		end
		local oneLine = "{ " .. table.concat(parts, ", ") .. " }"
		if #oneLine <= 100 and not oneLine:find("\n", 1, true) then
			return { s = oneLine, p = PREC_LITERAL }
		end
		local rows = {}
		for index, part in parts do
			rows[index] = indentText(part)
		end
		return { s = "{\n" .. table.concat(rows, ",\n") .. "\n}", p = PREC_LITERAL }
	end

	local function closureExpr(d)
		local ins = d.ins
		local childId
		if ins.name == "NEWCLOSURE" then
			childId = p.children[ins.D + 1]
		else
			local k = p.constants[ins.D + 1]
			childId = k and k.protoId
		end
		local child = childId and chunk.protos[childId + 1]
		if not child then
			error("closure refers to a missing function", 0)
		end
		if child.debugName and isIdentifier(child.debugName) then
			d.web.hintName = child.debugName
		end
		local names = {}
		for ci, cap in ins.captures do
			if cap.kind == 2 then
				names[ci] = upvalNames[cap.index + 1] or ("upval" .. cap.index)
			elseif cap.index == ins.A then
				names[ci] = webName(d.web)
			else
				names[ci] = webName(defs[ins.readSet[cap.index][1]].web)
			end
		end
		return { s = Moon._renderFunction(chunk, child, names), p = PREC_LITERAL, isFunction = true }
	end

	buildExpr = function(d)
		local ins = d.ins
		if not ins then
			return atom(webName(d.web))
		end
		local nm, A, B, C, D = ins.name, ins.A, ins.B, ins.C, ins.D

		if nm == "LOADNIL" then
			return { s = "nil", p = PREC_LITERAL, lit = true }
		elseif nm == "LOADB" then
			return { s = tostring(B ~= 0), p = PREC_LITERAL, lit = true }
		elseif nm == "LOADN" then
			return constExpr(p, { type = "number", value = D })
		elseif nm == "LOADK" then
			return constExpr(p, p.constants[D + 1])
		elseif nm == "LOADKX" then
			return constExpr(p, p.constants[ins.aux + 1])
		elseif nm == "MOVE" then
			return readExpr(ins, B)
		elseif nm == "GETGLOBAL" then
			local key = constString(p, ins.aux)
			return atom(if isIdentifier(key) then key else ("_G[%s]"):format(quote(key)))
		elseif nm == "GETUPVAL" then
			return atom(upvalNames[B + 1] or ("upval" .. B))
		elseif nm == "GETIMPORT" then
			return atom(importExpr(p, ins.aux))
		elseif nm == "GETTABLE" then
			return atom(wrap(readExpr(ins, B), PREC_ATOM) .. exprKeySuffix(readExpr(ins, C)))
		elseif nm == "GETTABLEKS" then
			return atom(wrap(readExpr(ins, B), PREC_ATOM) .. indexSuffix(constString(p, ins.aux)))
		elseif nm == "GETTABLEN" then
			return atom(wrap(readExpr(ins, B), PREC_ATOM) .. "[" .. (C + 1) .. "]")
		elseif nm == "NEWTABLE" or nm == "DUPTABLE" then
			return tableExpr(d)
		elseif nm == "NEWCLOSURE" or nm == "DUPCLOSURE" then
			return closureExpr(d)
		elseif nm == "NAMECALL" then
			return atom(wrap(readExpr(ins, B), PREC_ATOM) .. ":" .. constString(p, ins.aux))
		elseif nm == "CALL" then
			return callExpr(ins)
		elseif BINARY[nm] or BINARY_K[nm] then
			local base, l, r = nm, nil, nil
			if BINARY_K[nm] then
				base = BINARY_K[nm][1]
				if BINARY_K[nm][2] then
					l, r = readExpr(ins, B), constExpr(p, p.constants[C + 1])
				else
					l, r = constExpr(p, p.constants[B + 1]), readExpr(ins, C)
				end
			else
				l, r = readExpr(ins, B), readExpr(ins, C)
			end
			local opText, prec = BINARY[base][1], BINARY[base][2]
			local rightAssoc = base == "POW"
			local lText = wrap(l, if rightAssoc then prec + 1 else prec)
			local rText = wrap(r, if rightAssoc then prec else prec + 1)
			return { s = lText .. " " .. opText .. " " .. rText, p = prec }
		elseif nm == "CONCAT" then
			local texts = {}
			for r = B, C do
				texts[#texts + 1] = wrap(readExpr(ins, r), 5)
			end
			return { s = table.concat(texts, " .. "), p = 4 }
		elseif nm == "NOT" or nm == "MINUS" or nm == "LENGTH" then
			local operand = readExpr(ins, B)
			local text = wrap(operand, PREC_UNARY)
			if nm == "NOT" then
				return { s = "not " .. text, p = PREC_UNARY }
			elseif nm == "LENGTH" then
				return { s = "#" .. text, p = PREC_UNARY }
			end
			if text:sub(1, 1) == "-" then
				text = "(" .. text .. ")"
			end
			return { s = "-" .. text, p = PREC_UNARY }
		elseif nm == "GETVARARGS" then
			return atom(if B == 0 then "..." else "(...)")
		end
		error("cannot build an expression for " .. nm, 0)
	end

	local function declarable(w, d)
		local r = regions[#regions]
		return w.min >= r.start and w.max < r.stop and w.min == d.idx
	end

	local function assign(d, e)
		local w = d.web
		local name = webName(w, e.s)
		if w.declared then
			statement(name .. " = " .. e.s)
			return
		end
		w.declared = true
		if declarable(w, d) then
			if e.isFunction then
				statement("local function " .. name .. e.s:sub(9))
			else
				statement("local " .. name .. " = " .. e.s)
			end
		else
			if not name:find(".", 1, true) then
				hoisted[#hoisted + 1] = name
			end
			statement(name .. " = " .. e.s)
		end
	end

	local function assignGroup(group, exprText)
		local localForm = true
		for _, d in group do
			local w = d.web
			local dead = #d.useList == 0 and #w.defs == 1 and not w.debugName
			if not dead and (w.declared or not declarable(w, d)) then
				localForm = false
			end
		end
		local names = {}
		for k, d in group do
			local w = d.web
			local dead = #d.useList == 0 and #w.defs == 1 and not w.debugName
			if localForm and dead then
				names[k] = "_"
			else
				names[k] = webName(w)
				if not w.declared then
					w.declared = true
					if not localForm and not names[k]:find(".", 1, true) then
						hoisted[#hoisted + 1] = names[k]
					end
				end
			end
		end
		statement((if localForm then "local " else "") .. table.concat(names, ", ") .. " = " .. exprText)
	end

	local function emitFieldAssign(lhs, key, value)
		if value.isFunction and key and key:sub(1, 1) == "." and lhs:match("^[%a_][%w_%.]*$") then
			local params, rest = value.s:match("^function%((.-)%)(.*)$")
			if params then
				local selfParams = params:match("^self[^,]*, (.*)$") or (params:match("^self[^,]*$") and "")
				if selfParams then
					statement("function " .. lhs .. ":" .. key:sub(2) .. "(" .. selfParams .. ")" .. rest)
				else
					statement("function " .. lhs .. key .. "(" .. params .. ")" .. rest)
				end
				return
			end
		end
		statement(lhs .. (key or "") .. " = " .. value.s)
	end

	local function materialize(d, defer)
		if d.inline or (defer and defer[d]) then
			return
		end
		local ins = d.ins
		if #d.useList == 0 and not d.forceLocal and not d.web.debugName then
			if ins.name == "CALL" and ins.C == 2 then
				local text = callExpr(ins).s
				statement(if text:sub(1, 1) == "(" then ";" .. text else text)
			end
			return
		end
		assign(d, buildExpr(d))
	end

	local function compileRange(from, to, defer)
		for i = from, to - 1 do
			local ins = list[i]
			if ins.folded and ins.foldOwner.fold.endIdx == i then
				materialize(ins.foldOwner, defer)
			end
			if not ins.folded and not skip[i] then
				local nm, A, B, C = ins.name, ins.A, ins.B, ins.C
				if nm == "CALL" then
					if C == 1 then
						local text = callExpr(ins).s
						statement(if text:sub(1, 1) == "(" then ";" .. text else text)
					elseif C == 2 then
						materialize(ins.defs[1], defer)
					elseif C >= 3 and not ins.forGen then
						assignGroup(ins.defs, callExpr(ins).s)
					end
				elseif nm == "GETVARARGS" and B > 2 then
					assignGroup(ins.defs, "...")
				elseif nm == "SETGLOBAL" then
					local key = constString(p, ins.aux)
					local target = if isIdentifier(key) then key else ("_G[%s]"):format(quote(key))
					statement(target .. " = " .. readExpr(ins, A).s)
				elseif nm == "SETUPVAL" then
					statement((upvalNames[B + 1] or ("upval" .. B)) .. " = " .. readExpr(ins, A).s)
				elseif nm == "SETTABLEKS" then
					emitFieldAssign(
						wrap(readExpr(ins, B), PREC_ATOM),
						indexSuffix(constString(p, ins.aux)),
						readExpr(ins, A)
					)
				elseif nm == "SETTABLEN" then
					emitFieldAssign(wrap(readExpr(ins, B), PREC_ATOM), "[" .. (C + 1) .. "]", readExpr(ins, A))
				elseif nm == "SETTABLE" then
					local base = wrap(readExpr(ins, B), PREC_ATOM)
					emitFieldAssign(base, exprKeySuffix(readExpr(ins, C)), readExpr(ins, A))
				elseif nm == "SETLIST" then
					local base = wrap(readExpr(ins, A), PREC_ATOM)
					local count = if C == 0 then ins.openFrom - B else C - 1
					for r = 0, count - 1 do
						statement(("%s[%d] = %s"):format(base, ins.aux + r, readExpr(ins, B + r).s))
					end
					if C == 0 then
						statement(("for i, v in { %s } do %s[%d + i] = v end"):format(
							readExpr(ins, ins.openFrom).s,
							base,
							ins.aux + count - 1
						))
					end
				else
					for _, d in ins.defs do
						if not d.fold then
							materialize(d, defer)
						end
					end
				end
			end
		end
	end

	local function blockPure(blk)
		for i = blk.start, blk.stop - 1 do
			local ins = list[i]
			if isStmtIns(ins) and not (ins.name == "CALL" and ins.C ~= 1) then
				return false
			end
			for _, d in ins.defs do
				if not d.inline then
					local dead = #d.useList == 0 and not d.forceLocal and not d.web.debugName
					if not dead or ins.name == "CALL" then
						return false
					end
				end
			end
		end
		return true
	end

	local function isPureTestBlock(blk)
		return COND[list[blk.stop].name] and blockPure(blk)
	end

	local function testBase(J)
		local nm = J.name
		if nm == "JUMPIF" or nm == "JUMPIFNOT" then
			return readExpr(J, J.A)
		elseif nm == "JUMPIFEQ" or nm == "JUMPIFNOTEQ" then
			return compare("==", readExpr(J, J.A), readExpr(J, J.aux))
		elseif nm == "JUMPIFLE" or nm == "JUMPIFNOTLE" then
			return compare("<=", readExpr(J, J.A), readExpr(J, J.aux))
		elseif nm == "JUMPIFLT" or nm == "JUMPIFNOTLT" then
			return compare("<", readExpr(J, J.A), readExpr(J, J.aux))
		elseif nm == "JUMPXEQKNIL" then
			return compare("==", readExpr(J, J.A), constExpr(p, nil))
		elseif nm == "JUMPXEQKB" then
			return compare("==", readExpr(J, J.A), constExpr(p, { type = "boolean", value = bit32.band(J.aux, 1) == 1 }))
		end
		local k = p.constants[bit32.band(J.aux, 0xffffff) + 1]
		return compare("==", readExpr(J, J.A), constExpr(p, k))
	end

	local function makeTest(blk)
		local J = list[blk.stop]
		local t = { blk = blk, ins = J, idx = blk.stop, start = blk.start, T = J.target, F = blk.stop + 1 }
		local jw = JUMPS_WHEN_TRUE[J.name]
		if J.name:sub(1, 7) == "JUMPXEQ" then
			jw = bit32.rshift(J.aux, 31) == 0
		end
		local base
		local function cond()
			if not base then
				base = testBase(J)
			end
			return base
		end
		t.jt = function()
			return if jw then cond() else negate(cond())
		end
		t.jf = function()
			return if jw then negate(cond()) else cond()
		end
		return t
	end

	local function collectTests(blk)
		local tests = { makeTest(blk) }
		while #tests < 16 do
			local last = tests[#tests]
			local nb = blockOf[last.F]
			if nb and nb.start == last.F and isPureTestBlock(nb) then
				tests[#tests + 1] = makeTest(nb)
			else
				break
			end
		end
		return tests
	end

	local function chainPredsOk(tests, count)
		local members = {}
		for k = 1, count do
			members[tests[k].idx] = true
		end
		for k = 2, count do
			for _, pred in tests[k].blk.preds do
				if not members[pred.stop] then
					return false
				end
			end
		end
		return true
	end

	local function chainExpr(tests, i, j, X, Y)
		local t = tests[i]
		local T, F = t.T, t.F
		if i == j then
			if T == X and F == Y then
				return t.jt()
			elseif T == Y and F == X then
				return t.jf()
			end
			return nil
		end
		local function rest()
			return chainExpr(tests, i + 1, j, X, Y)
		end
		if T == X then
			local r = rest()
			return r and logicOr(t.jt(), r)
		elseif T == Y then
			local r = rest()
			return r and logicAnd(t.jf(), r)
		end
		local m
		for k = i + 2, j do
			if tests[k].start == T then
				m = k
				break
			end
		end
		if not m then
			return nil
		end
		local g = tests[m - 1]
		local label = tests[m].start
		if g.T == Y then
			local head = chainExpr(tests, i, m - 1, label, Y)
			local tail = chainExpr(tests, m, j, X, Y)
			return head and tail and logicAnd(head, tail)
		elseif g.T == X then
			local head = chainExpr(tests, i, m - 1, X, label)
			local tail = chainExpr(tests, m, j, X, Y)
			return head and tail and logicOr(head, tail)
		end
		return nil
	end

	local function resolveChain(tests, trueIsFall, requireT)
		for count = #tests, 1, -1 do
			local last = tests[count]
			if (not requireT or requireT(last)) and chainPredsOk(tests, count) then
				local expr
				if trueIsFall then
					expr = chainExpr(tests, 1, count, last.F, last.T)
				else
					expr = chainExpr(tests, 1, count, last.T, last.F)
				end
				if expr then
					return count, expr
				end
			end
		end
		return nil
	end

	local function emitBody(a, b, loopCtx, exitTarget)
		local saved = curList
		local body = {}
		curList = body
		local parent = regions[#regions]
		if not exitTarget and parent and parent.stop == b then
			exitTarget = parent.exitTarget
		end
		regions[#regions + 1] = { start = a, stop = b, exitTarget = exitTarget }
		if loopCtx then
			loopStack[#loopStack + 1] = loopCtx
		end
		emitRange(a, b)
		if loopCtx then
			loopStack[#loopStack] = nil
		end
		regions[#regions] = nil
		curList = saved
		return body
	end

	local function nameLoopVar(w, candidates)
		w.declared = true
		if w.debugName then
			w.name = w.debugName
			return w.name
		end
		local anyUse = false
		for _, d in w.defs do
			if #d.useList > 0 then
				anyUse = true
			end
		end
		if not anyUse then
			w.name = "_"
			return w.name
		end
		for _, c in candidates do
			if not activeLoop[c] and not used[c] then
				w.name = c
				return c
			end
		end
		w.name = uniqueName(candidates[1])
		return w.name
	end

	local function emitNumericFor(prep)
		local A = prep.A
		local exit = prep.target
		local q = exit - 1
		local back = list[q]
		if not back or back.name ~= "FORNLOOP" or back.target ~= prep.idx + 1 then
			error("unrecognised numeric for loop", 0)
		end
		local initE, limitE, stepE = readExpr(prep, A + 2), readExpr(prep, A), readExpr(prep, A + 1)
		local name = nameLoopVar(back.defs[1].web, { "i", "j", "k", "l", "m", "n" })
		activeLoop[name] = true
		local body = emitBody(prep.idx + 1, q, { kind = "for", head = prep.idx, exit = exit, continue = q, back = q })
		activeLoop[name] = nil
		local header = name .. " = " .. initE.s .. ", " .. limitE.s
		if stepE.s ~= "1" then
			header ..= ", " .. stepE.s
		end
		curList[#curList + 1] = { k = "for", header = header, body = body }
		return exit
	end

	local function emitGenericFor(prep)
		local A = prep.A
		local q = prep.target
		local loopIns = list[q]
		if not loopIns or loopIns.name ~= "FORGLOOP" or loopIns.target ~= prep.idx + 1 then
			error("unrecognised generic for loop", 0)
		end

		local iter
		local first = singleDef(prep, A)
		if first and first.ins and first.ins.forGen then
			iter = callExpr(first.ins).s
		else
			local g, s, i = readExpr(prep, A), readExpr(prep, A + 1), readExpr(prep, A + 2)
			if s.s == "nil" and i.s == "nil" then
				iter = g.s
			else
				iter = g.s .. ", " .. s.s .. ", " .. i.s
			end
		end

		local firstName = if iter:match("^ipairs%(") then "i" else "k"
		local names = {}
		for k = 1, prep.nvars do
			local choices
			if k == 1 then
				choices = { firstName }
			elseif k == 2 then
				choices = { "v" }
			else
				choices = { "v" .. k }
			end
			names[k] = nameLoopVar(loopIns.defs[k].web, choices)
		end
		for _, name in names do
			activeLoop[name] = true
		end
		local body = emitBody(prep.idx + 1, q, { kind = "for", head = prep.idx, exit = q + 1, continue = q, back = q })
		for _, name in names do
			activeLoop[name] = nil
		end
		curList[#curList + 1] = { k = "for", header = table.concat(names, ", ") .. " in " .. iter, body = body }
		return q + 1
	end

	local function emitWhile(lp)
		local H, B = lp.head, lp.back
		local exit = B + 1
		local tail = list[B]
		if tail.target ~= H then
			error("loop does not return to its head", 0)
		end
		local blk = blockOf[H]
		local cond = "true"
		local bodyStart = H
		if COND[list[blk.stop].name] and isPureTestBlock(blk) then
			local tests = collectTests(blk)
			local count, expr = resolveChain(tests, true, function(t)
				return t.T == exit
			end)
			if count then
				cond = expr.s
				bodyStart = tests[count].F
			end
		end
		local body = emitBody(bodyStart, B, { kind = "while", head = H, exit = exit, continue = H, back = B })
		curList[#curList + 1] = { k = "while", cond = cond, body = body }
		return exit
	end

	local function emitRepeat(lp)
		local H, B = lp.head, lp.back
		local lastBlk = blockOf[B]
		if lastBlk.stop ~= B or not isPureTestBlock(lastBlk) then
			error("repeat loop condition needs statements", 0)
		end
		local chain = { lastBlk }
		while #chain < 16 do
			local prev = blockOf[chain[1].start - 1]
			if prev and prev.start >= H and isPureTestBlock(prev) then
				table.insert(chain, 1, prev)
			else
				break
			end
		end
		for startAt = 1, #chain do
			local tests = {}
			for k = startAt, #chain do
				tests[#tests + 1] = makeTest(chain[k])
			end
			local last = tests[#tests]
			if last.T == H and chainPredsOk(tests, #tests) then
				local expr = chainExpr(tests, 1, #tests, last.F, last.T)
				if expr then
					local untilStart = tests[1].start
					local body = emitBody(H, untilStart, { kind = "repeat", head = H, exit = B + 1, continue = untilStart, back = B })
					curList[#curList + 1] = { k = "repeat", cond = expr.s, body = body }
					return B + 1
				end
			end
		end
		error("could not recover the repeat condition", 0)
	end

	local function emitLoop(lp)
		if lp.uncond then
			return emitWhile(lp)
		end
		return emitRepeat(lp)
	end

	local function lastDefOf(blk, reg, upTo)
		for i = upTo, blk.start, -1 do
			for _, d in list[i].defs do
				if d.reg == reg then
					return d
				end
			end
		end
		return nil
	end

	local function foldPlan(blk)
		local J = list[blk.stop]
		if J.name ~= "JUMPIF" and J.name ~= "JUMPIFNOT" then
			return nil
		end
		local r, T = J.A, J.target
		local steps = {}
		local members = { [blk] = true }
		local curBlk, curJ = blk, J
		local final
		while true do
			local dl = lastDefOf(curBlk, r, curJ.idx - 1)
			if not dl or singleDef(curJ, r) ~= dl or dl.web.debugName then
				return nil
			end
			steps[#steps + 1] = { blk = curBlk, J = curJ, d = dl, op = if curJ.name == "JUMPIFNOT" then "and" else "or" }
			local rb = blockOf[curJ.idx + 1]
			if not rb or rb.start ~= curJ.idx + 1 or #rb.preds ~= 1 then
				return nil
			end
			members[rb] = true
			local rl = list[rb.stop]
			if rb.stop + 1 == T and not isTerminator(rl) then
				local dr = lastDefOf(rb, r, rb.stop)
				if not dr or dr.web.debugName then
					return nil
				end
				final = { blk = rb, d = dr }
				break
			elseif (rl.name == "JUMPIF" or rl.name == "JUMPIFNOT") and rl.A == r and rl.target == T then
				curBlk, curJ = rb, rl
			else
				return nil
			end
		end

		local web = final.d.web
		for _, s in steps do
			if s.d.web ~= web then
				return nil
			end
		end
		local tb = blockOf[T]
		if tb then
			for _, pred in tb.preds do
				if not members[pred] then
					return nil
				end
			end
		end
		return { steps = steps, final = final, T = T }
	end

	local function emitIf(cond, thenStart, elseLabel, limit)
		local region = regions[#regions]
		if elseLabel > limit and region.exitTarget and elseLabel == region.exitTarget then
			elseLabel = limit
		end
		if elseLabel > limit then
			error("if statement runs past its region", 0)
		end
		local lp = loopStack[#loopStack]
		local trailing
		if elseLabel - 1 >= thenStart then
			local li = list[elseLabel - 1]
			if UNCOND[li.name] or (li.name == "LOADB" and li.C ~= 0) then
				trailing = li
			end
		end

		local thenB, elseB
		local nextIdx = elseLabel
		if not trailing then
			thenB = emitBody(thenStart, elseLabel)
		else
			local X, ji = trailing.target, trailing.idx
			local isLoadb = trailing.name == "LOADB"
			local function thenBody()
				if isLoadb then
					skipJump[ji] = true
					return emitBody(thenStart, elseLabel, nil, X)
				end
				return emitBody(thenStart, ji, nil, X)
			end
			if not isLoadb and lp and X == lp.exit then
				thenB = emitBody(thenStart, ji)
				thenB[#thenB + 1] = { k = "line", s = "break" }
			elseif not isLoadb and lp and lp.kind == "while" and X == lp.head and X <= ji then
				thenB = emitBody(thenStart, ji)
				thenB[#thenB + 1] = { k = "line", s = "continue" }
			elseif X == elseLabel then
				thenB = thenBody()
			elseif X > elseLabel and X <= limit then
				thenB = thenBody()
				elseB = emitBody(elseLabel, X)
				nextIdx = X
			elseif X > limit and region.exitTarget == X then
				thenB = thenBody()
				elseB = emitBody(elseLabel, limit)
				nextIdx = limit
			else
				error("unsupported jump out of an if body", 0)
			end
		end
		curList[#curList + 1] = { k = "if", cond = cond.s, thenB = thenB, elseB = elseB }
		return nextIdx
	end

	local function pureExcept(from, to, except)
		for i = from, to - 1 do
			local ins = list[i]
			if isStmtIns(ins) and not (ins.name == "CALL" and ins.C ~= 1) then
				return false
			end
			for _, d in ins.defs do
				if not d.inline and d ~= except then
					local dead = #d.useList == 0 and not d.forceLocal and not d.web.debugName
					if not dead or ins.name == "CALL" then
						return false
					end
				end
			end
		end
		return true
	end

	local function valueChain(blk, r, joinAt, members, defers)
		local last = list[blk.stop]
		local terminal = isTerminator(last)
		local d = lastDefOf(blk, r, if terminal then blk.stop - 1 else blk.stop)
		if not d or d.web.debugName or not pureExcept(blk.start, if terminal then blk.stop else blk.stop + 1, d) then
			return nil
		end
		members[#members + 1] = { blk = blk, def = d, stop = if terminal then blk.stop else blk.stop + 1 }
		defers[d] = true
		if not terminal and blk.stop + 1 == joinAt then
			return function()
				return buildExpr(d)
			end
		end
		if (last.name == "JUMPIF" or last.name == "JUMPIFNOT") and last.A == r and last.target == joinAt
			and singleDef(last, r) == d then
			local nextBlk = blockOf[blk.stop + 1]
			if not nextBlk or nextBlk.start ~= blk.stop + 1 or #nextBlk.preds ~= 1 then
				return nil
			end
			local rest = valueChain(nextBlk, r, joinAt, members, defers)
			if not rest then
				return nil
			end
			local isOr = last.name == "JUMPIF"
			return function()
				local left, right = buildExpr(d), rest()
				return if isOr then logicOr(left, right) else logicAnd(left, right)
			end
		end
		return nil
	end

	local function emitAndOrValue(lastTest, cond)
		local thenStart, elseLabel = lastTest.F, lastTest.T
		local rb = blockOf[thenStart]
		local eb = blockOf[elseLabel]
		if not rb or not eb or rb.start ~= thenStart or eb.start ~= elseLabel or #rb.preds ~= 1 then
			return nil
		end
		local J2 = list[rb.stop]
		if J2.name ~= "JUMPIF" or rb.stop + 1 ~= elseLabel then
			return nil
		end
		local joinAt = J2.target
		local r = J2.A
		local dA = lastDefOf(rb, r, rb.stop - 1)
		if not dA or dA.web.debugName or singleDef(J2, r) ~= dA or not pureExcept(rb.start, rb.stop, dA) then
			return nil
		end
		local members, defers = {}, { [dA] = true }
		local rest = valueChain(eb, r, joinAt, members, defers)
		if not rest then
			return nil
		end
		local web = dA.web
		local allowed = { [rb] = true }
		for _, m in members do
			if m.def.web ~= web then
				return nil
			end
			allowed[m.blk] = true
		end
		local joinBlock = blockOf[joinAt]
		if joinBlock then
			for _, pred in joinBlock.preds do
				if not allowed[pred] then
					return nil
				end
			end
		end
		compileRange(rb.start, J2.idx, defers)
		for _, m in members do
			compileRange(m.blk.start, m.stop, defers)
		end
		assign(dA, logicOr(logicAnd(cond, buildExpr(dA)), rest()))
		return joinAt
	end

	local function trivialReturn(idx)
		local blk = blockOf[idx]
		local ins = list[idx]
		return blk and blk.start == idx and blk.stop == idx and ins and ins.name == "RETURN" and ins.B == 1
	end

	local function emitConditional(blk, limit)
		local t = blk.stop
		local J = list[t]

		local a, b = list[t + 1], list[t + 2]
		if a and b and a.name == "LOADB" and a.C == 1 and b.name == "LOADB" and b.C == 0
			and a.A == b.A and J.target == t + 2 then
			local test = makeTest(blk)
			local value
			if a.B == 1 and b.B == 0 then
				value = test.jf()
			elseif a.B == 0 and b.B == 1 then
				value = test.jt()
			end
			if value then
				compileRange(blk.start, t)
				assign(a.defs[1], value)
				return t + 3
			end
		end

		local plan = foldPlan(blk)
		if plan then
			local defer = { [plan.final.d] = true }
			for _, s in plan.steps do
				defer[s.d] = true
			end
			for _, s in plan.steps do
				compileRange(s.blk.start, s.J.idx, defer)
			end
			compileRange(plan.final.blk.start, plan.final.blk.stop + 1, defer)
			local e = buildExpr(plan.final.d)
			for k = #plan.steps, 1, -1 do
				local s = plan.steps[k]
				local left = buildExpr(s.d)
				e = if s.op == "and" then logicAnd(left, e) else logicOr(left, e)
			end
			assign(plan.steps[1].d, e)
			return plan.T
		end

		compileRange(blk.start, t)
		local tests = collectTests(blk)

		local lp = loopStack[#loopStack]
		if lp then
			local count, expr = resolveChain(tests, false, function(test)
				return test.T == lp.exit or (lp.kind == "while" and test.T == lp.head and test.T <= test.idx)
			end)
			if count then
				local word = if tests[count].T == lp.exit then "break" else "continue"
				curList[#curList + 1] = { k = "if", cond = expr.s, thenB = { { k = "line", s = word } } }
				return tests[count].F
			end
		end

		local count, expr = resolveChain(tests, true)
		if not count then
			error("could not recover an if condition", 0)
		end
		local joined = emitAndOrValue(tests[count], expr)
		if joined then
			return joined
		end
		if tests[count].T > limit and trivialReturn(tests[count].T) then
			local returnTarget = tests[count].T
			local taken, takenExpr = resolveChain(tests, false, function(t)
				return t.T == returnTarget
			end)
			if taken then
				curList[#curList + 1] = { k = "if", cond = takenExpr.s, thenB = { { k = "line", s = "return" } } }
				return tests[taken].F
			end
		end
		return emitIf(expr, tests[count].F, tests[count].T, limit)
	end

	local function jumpStatement(last)
		local lp = loopStack[#loopStack]
		if trivialReturn(last.target) then
			statement("return")
		elseif lp and last.target == lp.exit then
			statement("break")
		elseif lp and last.target == lp.continue then
			statement("continue")
		else
			error("unsupported jump (needs goto)", 0)
		end
	end

	local function emitBlock(blk, limit)
		local lastIdx = blk.stop
		local last = list[lastIdx]
		local nm = last.name

		if skipJump[lastIdx] then
			compileRange(blk.start, lastIdx)
			if nm == "LOADB" then
				materialize(last.defs[1])
			end
			return lastIdx + 1
		end

		if nm == "RETURN" then
			compileRange(blk.start, lastIdx)
			local values = {}
			local count = if last.B == 0 then last.openFrom - last.A else last.B - 1
			for r = 0, count - 1 do
				values[#values + 1] = explicitText(readExpr(last, last.A + r), r == count - 1, last.B == 0)
			end
			if last.B == 0 then
				values[#values + 1] = readExpr(last, last.openFrom).s
			end
			if #values == 0 then
				if lastIdx ~= #list then
					statement("return")
				end
			else
				statement("return " .. table.concat(values, ", "))
			end
			return lastIdx + 1
		elseif UNCOND[nm] then
			compileRange(blk.start, lastIdx)
			jumpStatement(last)
			return lastIdx + 1
		elseif nm == "LOADB" and last.C ~= 0 then
			compileRange(blk.start, lastIdx)
			materialize(last.defs[1])
			jumpStatement(last)
			return lastIdx + 1
		elseif COND[nm] then
			return emitConditional(blk, limit)
		elseif nm == "FORNPREP" then
			compileRange(blk.start, lastIdx)
			return emitNumericFor(last)
		elseif nm == "FORGPREP" then
			compileRange(blk.start, lastIdx)
			return emitGenericFor(last)
		elseif LOOP_OPS[nm] then
			error("stray loop instruction " .. nm, 0)
		end
		compileRange(blk.start, lastIdx + 1)
		return lastIdx + 1
	end

	emitRange = function(a, b)
		local i = a
		while i < b do
			local blk = blockOf[i]
			if not blk or blk.start ~= i then
				error("jump into the middle of a block", 0)
			end
			local lp = fn.loopsAt[i]
			if lp and not lp.started then
				lp.started = true
				i = emitLoop(lp)
			elseif #blk.preds == 0 and blk.index ~= 1 then
				i = blk.stop + 1
			elseif blk.stop >= b then
				if blk.stop == b and isTerminator(list[b]) then
					compileRange(blk.start, b)
					i = b
				else
					error("block runs past its region", 0)
				end
			else
				i = emitBlock(blk, b)
			end
		end
		if i ~= b then
			error("region overran its end", 0)
		end
	end

	local function declareHoisted(w)
		local name = webName(w)
		if not w.declared then
			w.declared = true
			if not name:find(".", 1, true) then
				hoisted[#hoisted + 1] = name
			end
		end
		return name
	end

	local function hiddenVar(base)
		local name = uniqueName(base)
		if tableName then
			return tableName .. "." .. name
		end
		hoisted[#hoisted + 1] = name
		return name
	end

	local function emitFlat()
		local pcName = uniqueName("pc")
		local hidden = {}
		local cases = {}

		local function setPc(idx)
			statement(pcName .. " = " .. idx)
		end

		local function runsAgain(st)
			return ("(%s > 0 and %s <= %s) or (%s <= 0 and %s >= %s)"):format(
				st.step, st.index, st.limit, st.step, st.index, st.limit
			)
		end

		for _, blk in fn.blocks do
			if #blk.preds > 0 or blk.index == 1 then
				local body = {}
				curList = body
				regions[#regions + 1] = { start = blk.start, stop = blk.stop + 1 }
				local last = list[blk.stop]
				local nm = last.name
				local terminal = isTerminator(last)
				compileRange(blk.start, if terminal then blk.stop else blk.stop + 1)

				if not terminal then
					setPc(blk.stop + 1)
				elseif nm == "RETURN" then
					local values = {}
					local count = if last.B == 0 then last.openFrom - last.A else last.B - 1
					for r = 0, count - 1 do
						values[#values + 1] = explicitText(readExpr(last, last.A + r), r == count - 1, last.B == 0)
					end
					if last.B == 0 then
						values[#values + 1] = readExpr(last, last.openFrom).s
					end
					statement(if #values == 0 then "return" else "return " .. table.concat(values, ", "))
				elseif UNCOND[nm] then
					setPc(last.target)
				elseif nm == "LOADB" then
					materialize(last.defs[1])
					setPc(last.target)
				elseif COND[nm] then
					local test = makeTest(blk)
					statement(("if %s then %s = %d else %s = %d end"):format(
						test.jt().s, pcName, test.T, pcName, test.F
					))
				elseif nm == "FORNPREP" then
					local back = list[last.target - 1]
					if not back or back.name ~= "FORNLOOP" then
						error("numeric for prep without a loop instruction", 0)
					end
					local st = { index = hiddenVar("index"), limit = hiddenVar("limit"), step = hiddenVar("step") }
					hidden[last.idx] = st
					local var = declareHoisted(back.defs[1].web)
					statement(("%s, %s, %s = %s, %s, %s"):format(
						st.index, st.limit, st.step,
						readExpr(last, last.A + 2).s, readExpr(last, last.A).s, readExpr(last, last.A + 1).s
					))
					statement(("if %s then %s = %s; %s = %d else %s = %d end"):format(
						runsAgain(st), var, st.index, pcName, blk.stop + 1, pcName, last.target
					))
				elseif nm == "FORNLOOP" then
					local st = hidden[last.target - 1]
					if not st then
						error("numeric for loop without a prep", 0)
					end
					local var = declareHoisted(last.defs[1].web)
					statement(("%s = %s + %s"):format(st.index, st.index, st.step))
					statement(("if %s then %s = %s; %s = %d else %s = %d end"):format(
						runsAgain(st), var, st.index, pcName, last.target, pcName, blk.stop + 1
					))
				elseif nm == "FORGPREP" then
					local st = { gen = hiddenVar("iter"), state = hiddenVar("state"), control = hiddenVar("control") }
					hidden[last.idx] = st
					local first = singleDef(last, last.A)
					if first and first.ins and first.ins.forGen then
						statement(("%s, %s, %s = %s"):format(st.gen, st.state, st.control, callExpr(first.ins).s))
					else
						statement(("%s, %s, %s = %s, %s, %s"):format(
							st.gen, st.state, st.control,
							readExpr(last, last.A).s, readExpr(last, last.A + 1).s, readExpr(last, last.A + 2).s
						))
					end
					setPc(last.target)
				elseif nm == "FORGLOOP" then
					local st = hidden[last.target - 1]
					if not st then
						error("generic for loop without a prep", 0)
					end
					local names = {}
					for k = 1, last.nvars do
						names[k] = declareHoisted(last.defs[k].web)
					end
					statement(("%s = %s(%s, %s)"):format(table.concat(names, ", "), st.gen, st.state, st.control))
					statement(("if %s ~= nil then %s = %s; %s = %d else %s = %d end"):format(
						names[1], st.control, names[1], pcName, last.target, pcName, blk.stop + 1
					))
				else
					error("cannot flatten " .. nm, 0)
				end
				regions[#regions] = nil
				cases[#cases + 1] = { id = blk.start, body = body }
			end
		end

		curList = rootList
		if tableName then
			statement("local " .. tableName .. " = {}")
		end
		statement("local " .. pcName .. " = 1")
		rootList[#rootList + 1] = { k = "flat", pc = pcName, cases = cases }
	end

	if flat then
		local crossing = 0
		for _, w in fn.webs do
			if willHoist(w) then
				crossing += 1
			end
		end
		if forceTable or crossing > (Moon.flatTableThreshold or 150) then
			tableName = uniqueName("vars")
		end
		emitFlat()
	else
		emitRange(1, #list + 1)
	end
	return rootList, hoisted, fn.paramNames
end

local function renderStatements(stmts, depth, out)
	local pad = string.rep("\t", depth)
	local function indented(text)
		return (text:gsub("\n", "\n" .. pad))
	end
	local renderIf
	function renderIf(node, keyword)
		out[#out + 1] = pad .. keyword .. " " .. node.cond .. " then"
		renderStatements(node.thenB, depth + 1, out)
		local e = node.elseB
		if e and #e > 0 then
			if #e == 1 and e[1].k == "if" then
				local sub = e[1]
				out[#out + 1] = pad .. "elseif " .. sub.cond .. " then"
				renderStatements(sub.thenB, depth + 1, out)
				local rest = sub.elseB
				while rest and #rest == 1 and rest[1].k == "if" do
					sub = rest[1]
					out[#out + 1] = pad .. "elseif " .. sub.cond .. " then"
					renderStatements(sub.thenB, depth + 1, out)
					rest = sub.elseB
				end
				if rest and #rest > 0 then
					out[#out + 1] = pad .. "else"
					renderStatements(rest, depth + 1, out)
				end
			else
				out[#out + 1] = pad .. "else"
				renderStatements(e, depth + 1, out)
			end
		end
		out[#out + 1] = pad .. "end"
	end

	for _, node in stmts do
		local k = node.k
		if k == "line" then
			out[#out + 1] = pad .. indented(node.s)
		elseif k == "if" then
			renderIf(node, "if")
		elseif k == "while" then
			out[#out + 1] = pad .. "while " .. node.cond .. " do"
			renderStatements(node.body, depth + 1, out)
			out[#out + 1] = pad .. "end"
		elseif k == "repeat" then
			out[#out + 1] = pad .. "repeat"
			renderStatements(node.body, depth + 1, out)
			out[#out + 1] = pad .. "until " .. node.cond
		elseif k == "for" then
			out[#out + 1] = pad .. "for " .. node.header .. " do"
			renderStatements(node.body, depth + 1, out)
			out[#out + 1] = pad .. "end"
		elseif k == "do" then
			out[#out + 1] = pad .. "do"
			renderStatements(node.body, depth + 1, out)
			out[#out + 1] = pad .. "end"
		elseif k == "flat" then
			out[#out + 1] = pad .. "while true do"
			for n, case in node.cases do
				out[#out + 1] = pad .. "\t" .. (if n == 1 then "if " else "elseif ") .. node.pc .. " == " .. case.id .. " then"
				renderStatements(case.body, depth + 2, out)
			end
			if #node.cases > 0 then
				out[#out + 1] = pad .. "\telse"
				out[#out + 1] = pad .. "\t\treturn"
				out[#out + 1] = pad .. "\tend"
			end
			out[#out + 1] = pad .. "end"
		end
	end
end

local function nodeText(node)
	local out = {}
	renderStatements({ node }, 0, out)
	return table.concat(out, "\n")
end

local function declaredNames(node)
	if node.k ~= "line" then
		return nil
	end
	local fnName = node.s:match("^local function ([%a_][%w_]*)")
	if fnName then
		return { fnName }
	end
	local list = node.s:match("^local ([%a_][%w_, ]*) =") or node.s:match("^local ([%a_][%w_]*)$")
	if not list then
		return nil
	end
	local names = {}
	for name in list:gmatch("[%a_][%w_]*") do
		if name ~= "_" then
			names[#names + 1] = name
		end
	end
	return names
end

local LOCAL_SOFT_LIMIT = 170
local SHORT_LIFETIME = 40

local function asAssignment(node)
	local text = node.s
	if text:match("^local function ") then
		text = text:gsub("^local function ([%a_][%w_]*)", "%1 = function", 1)
	elseif text:match("^local [%a_][%w_]*$") then
		return nil
	else
		text = text:gsub("^local ", "", 1)
	end
	return { k = "line", s = text }
end

local function scopeLocals(stmts)
	for _, node in stmts do
		for _, key in { "thenB", "elseB", "body" } do
			if node[key] then
				node[key] = scopeLocals(node[key])
			end
		end
	end

	local declarations = 0
	for _, node in stmts do
		if declaredNames(node) then
			declarations += 1
		end
	end
	if declarations <= (Moon.localSoftLimit or LOCAL_SOFT_LIMIT) then
		return stmts
	end

	local texts = {}
	for index, node in stmts do
		texts[index] = nodeText(node)
	end
	local function lastUse(name, from)
		local pattern = "%f[%w_]" .. name .. "%f[^%w_]"
		for index = #stmts, from + 1, -1 do
			if texts[index]:find(pattern) then
				return index
			end
		end
		return from
	end

	local result = {}
	local i = 1
	while i <= #stmts do
		local names = declaredNames(stmts[i])
		local last = i
		if names then
			for _, name in names do
				last = math.max(last, lastUse(name, i))
			end
		end
		if not names or last == i or last >= #stmts or last - i > SHORT_LIFETIME then
			result[#result + 1] = stmts[i]
			i += 1
		else
			local group = { stmts[i] }
			local forward = {}
			for k = i + 1, last do
				local node = stmts[k]
				local inner = declaredNames(node)
				local escapes = false
				if inner then
					for _, name in inner do
						if lastUse(name, k) > last then
							escapes = true
						end
					end
				end
				if escapes then
					for _, name in inner do
						forward[#forward + 1] = name
					end
					local converted = asAssignment(node)
					if converted then
						group[#group + 1] = converted
					end
				else
					group[#group + 1] = node
				end
			end
			if #forward > 0 then
				result[#result + 1] = { k = "line", s = "local " .. table.concat(forward, ", ") }
			end
			result[#result + 1] = { k = "do", body = group }
			i = last + 1
		end
	end
	return result
end

local function renderBody(stmts, hoisted)
	stmts = scopeLocals(stmts)
	local out = {}
	if #hoisted > 0 then
		out[1] = "local " .. table.concat(hoisted, ", ")
	end
	renderStatements(stmts, 0, out)
	return out
end

local function emitWithFallback(chunk, p, upvalNames)
	local ok, stmts, hoisted, params
	if Moon.forceFlat then
		ok, stmts = false, "forced"
	else
		ok, stmts, hoisted, params = pcall(emitFunction, chunk, p, upvalNames, false)
	end
	if ok then
		return true, stmts, hoisted, params, nil
	end
	local reason = tostring(stmts)
	local okFlat, flatStmts, flatHoisted, flatParams = pcall(emitFunction, chunk, p, upvalNames, true, false)
	if okFlat and #flatHoisted > (Moon.flatTableThreshold or 150) then
		local okTable, tableStmts, tableHoisted, tableParams = pcall(emitFunction, chunk, p, upvalNames, true, true)
		if okTable then
			flatStmts, flatHoisted, flatParams = tableStmts, tableHoisted, tableParams
		end
	end
	if okFlat then
		local note = ("-- control flow could not be structured (%s); rebuilt as a state machine"):format(reason)
		return true, flatStmts, flatHoisted, flatParams, note
	end
	return false, reason, nil, nil, nil
end

local TYPE_NAMES = {
	[0] = "nil", "boolean", "number", "string", "table", "function", "thread", "userdata", "vector", "buffer",
}

local function typeName(byte)
	local base = bit32.band(byte, 127)
	if base == 15 then
		return nil
	end
	local name = TYPE_NAMES[base]
	if not name then
		if base < 64 then
			return nil
		end
		name = "userdata"
	end
	if bit32.band(byte, 128) ~= 0 and name ~= "nil" then
		name ..= "?"
	end
	return name
end

local function paramTypes(chunk, p)
	local blob = p.typeBlob
	if not blob or #blob == 0 then
		return {}
	end
	local pos = 1
	if chunk.typesVersion >= 2 then
		repeat
			local b = blob:byte(pos)
			if not b then
				return {}
			end
			pos += 1
		until b < 128
		pos += 2
	end
	if blob:byte(pos) ~= 5 or blob:byte(pos + 1) ~= p.numParams then
		return {}
	end
	local out = {}
	for i = 1, p.numParams do
		local byte = blob:byte(pos + 1 + i)
		out[i] = byte and typeName(byte) or nil
	end
	return out
end

function Moon._renderFunction(chunk, p, upvalNames)
	local ok, stmts, hoisted, params, note = emitWithFallback(chunk, p, upvalNames)
	local names = {}
	local lines
	if ok then
		names = params
		lines = renderBody(stmts, hoisted)
		if note then
			table.insert(lines, 1, note)
		end
	else
		for i = 1, p.numParams do
			names[i] = "arg" .. i
		end
		lines = { ("-- could not decompile this function (%s); disassembly follows"):format(tostring(stmts)) }
		for _, line in disassembleProto(chunk, p, p.index) do
			lines[#lines + 1] = "-- " .. line
		end
	end
	local types = paramTypes(chunk, p)
	local header = {}
	for i, name in names do
		header[i] = if types[i] then name .. ": " .. types[i] else name
	end
	if p.isVararg then
		header[#header + 1] = "..."
	end
	local head = "function(" .. table.concat(header, ", ") .. ")"
	if #lines == 0 then
		return head .. " end"
	end
	return head .. "\n" .. indentText(table.concat(lines, "\n")) .. "\nend"
end

local function toBytecode(input)
	if type(input) == "string" then
		return input
	end
	assert(getscriptbytecode, "getscriptbytecode is not available in this environment")
	return getscriptbytecode(input)
end

local function headerLine(chunk)
	return ("-- Luau bytecode v%d, %s opcode encoding, %d function(s)"):format(
		chunk.version,
		chunk.opEncoding,
		#chunk.protos
	)
end

function Moon.disassemble(input)
	local ok, result = pcall(function()
		local chunk, err = Moon.parse(toBytecode(input))
		if not chunk then
			return "-- could not load bytecode: " .. tostring(err)
		end
		local out = { headerLine(chunk) }
		if chunk.decodeErrors > 0 then
			out[#out + 1] = ("-- warning: %d undecodable instruction(s)"):format(chunk.decodeErrors)
		end
		for index, p in chunk.protos do
			out[#out + 1] = ""
			for _, line in disassembleProto(chunk, p, index) do
				out[#out + 1] = line
			end
		end
		return table.concat(out, "\n")
	end)
	return if ok then result else "-- disassembler error: " .. tostring(result)
end

function Moon.decompile(input)
	local ok, result = pcall(function()
		local chunk, err = Moon.parse(toBytecode(input))
		if not chunk then
			return "-- could not load bytecode: " .. tostring(err)
		end
		local okMain, stmts, hoisted, _, note = emitWithFallback(chunk, chunk.main, {})
		local out = { "-- Decompiled with MoonDecompiler" }
		if okMain then
			if note then
				out[#out + 1] = note
			end
			for _, line in renderBody(stmts, hoisted) do
				out[#out + 1] = line
			end
		else
			out[#out + 1] = ("-- main chunk not recovered (%s); full disassembly follows"):format(tostring(stmts))
			for index, p in chunk.protos do
				out[#out + 1] = "--"
				for _, line in disassembleProto(chunk, p, index) do
					out[#out + 1] = "-- " .. line
				end
			end
		end
		return table.concat(out, "\n")
	end)
	return if ok then result else "-- decompiler error: " .. tostring(result)
end

return Moon
