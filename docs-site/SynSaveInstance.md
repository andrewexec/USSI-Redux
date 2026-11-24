# SynSaveInstance

Represents the options for saving instances with custom settings using the synsaveinstance function.

## Types

### `CustomOptions table`

`interface CustomOptions table {`

- `__DEBUG_MODE: boolean` — This will print debug logs to console about unusual scenarios. Recommended to enable if you wish to help us improve our products and find bugs / issues with it! _**Default:**_ false
- `ReadMe: boolean` — _**Default:**_ true
- `Binary: boolean` — Saves as a binary file (.rbxl/.rbxm) instead of XML (.rbxlx/.rbxmx). Much smaller and faster to load. Pass `XML = true` for the opposite. _**Default:**_ true
- `CompressionMode: string` — How chunks are compressed in binary mode: "zstd", "lz4", or false for none. _**Default:**_ "zstd"
- `CompressionLevel: number` — Compression strength, higher is smaller but slower. Range is -7 to 22 inclusive. _**Default:**_ 9
- `CopyToClipboard: boolean` — Puts the finished output on the clipboard instead of writing a file, so you can paste it straight into Studio. Best for small saves -- a full place is usually far too big for the clipboard to handle. _**Default:**_ false
- `RiskyServicesDisabled: {` `UGC,` `Encoding,` `Reflection=boolean` `}` — Per-service kill switches for services games might detect. `UGC` skips UGCValidationService (GHP fallback reads, `MeshPart.VertexCount`). `Encoding` skips EncodingService (base64 encode/decode, zstd compression falls back to other funcs). `Reflection` skips ReflectionService (one of several API dump fallbacks, `Content` property lookups -- falls back to the other API dump sources). Examples: `{UGC = true}` disables only UGCValidationService; `{Encoding = true, Reflection = true}` disables both, leaving UGC untouched. _**Default:**_ {UGC = true, Encoding = false, Reflection = false}
- `SafeMode: boolean` — Kicks you before Saving, which keeps you safe. **HIGHLY RECOMMENDED TO KEEP ENABLED**. _**Default:**_ false
- `KillAllScripts: boolean` — Kills all scripts to further protect you. SafeMode also enables this by default. If you can't move after saving then this is the reason. **HIGHLY RECOMMENDED TO KEEP ENABLED**. _**Default:**_ false
- `BoostFPS: boolean` — Massively boosts FPS by disabling 3D rendering. Other options also enable it, like: SafeMode. _**Default:**_ false
- `ShutdownWhenDone: boolean` — Shuts the game down after saveinstance is finished. _**Default:**_ false
- `AntiIdle: boolean` — Prevents the 20-minute-Idle Kick. _**Default:**_ true
- `Anonymous: {boolean | table{` `UserId=string?,` `Name=string?` `}}` — - **RISKY:** Removes your Name and UserId from the file -- useful for games that store them in GUIs or other Instances. Can also be a table with UserId and/or Name keys to pick the replacements. May mess up unrelated text or numbers that happen to match. Inside attributes and tags the replacement is padded to the same length, so a name shorter than yours comes out as for example `Roblox____`. _**Default:**_ false
- `ShowStatus: boolean` — _**Default:**_ true
- `Callback: function` — If set, the serialized data will be sent to the callback function instead of to file. _**Default:**_ false
- `mode: string` — Valid modes: full, optimized, scripts. Change this to invalid mode like "invalid" if you only want ExtraInstances. "optimized" mode is **NOT** supported with _@Object_ option. _**Default:**_ `"optimized"`
- `Decompile: boolean` — Script decompiling. _**Default:**_ true
- `scriptcache: boolean` — Use decompiled script cache to avoid decompiling duplicate scripts. _**Default:**_ true
- `DecompileTimeout: number` — If the decompilation run time exceeds this value it gets cancelled. Set to -1 to disable timeout. _**Default:**_ 10
- `BytecodeTimeout: number` — If the SaveBytecode run time exceeds this value it gets cancelled. Set to -1 to disable timeout. _**Default:**_ 3
- `DecompileJobless: boolean` — Includes already decompiled code in the output. No new scripts are decompiled. _**Default:**_ false
- `SaveBytecode: boolean` — Includes bytecode in the output. Useful if you wish to be able to decompile it yourself later. Respects **@DecompileIgnore**. _**Default:**_ false
- `DecompileIgnore: {Instance | Instance.ClassName | [Instance.ClassName]={Instance.Name}}` — Ignores matched instances and their descendants by default. To ignore only the instance itself, set the value to `false`. Examples: `"Chat"` matches any instance with ClassName "Chat"; `Players = {"MyPlayerName"}` matches class "Players" AND name "MyPlayerName" only; `workspace` matches a specific instance by reference; `[workspace] = false` matches a specific instance by reference, ignoring only itself and not its descendants. _**Default:**_ {TextChatService}
- `IgnoreList: {Instance | Instance.ClassName | [Instance.ClassName]={Instance.Name | false}}` — Structure mirrors **@DecompileIgnore**, except `false` means keep the instance but ignore its descendants. Supports both instance references and ClassName strings. Examples: `"CoreGui"` skips entirely; `CorePackages = false` keeps the instance but skips its descendants; `Players = {"SomePlayer"}` skips a specific named instance with specific ClassName. _**Default:**_ {CoreGui, CorePackages, Packages = false}
- `ExtraInstances: {Instance}` — If used with any invalid mode (like "invalidmode") it will only save these instances. _**Default:**_ {}
- `IgnoreProperties: table` — Ignores properties by Name. _**Default:**_ {}
- `SaveCacheInterval: number` — The less the value the more often it saves, but that would mean less performance due to constantly saving. XML Only. _**Default:**_ 0x1600 * 10
- `FilePath: string` — The name (can include a path) of the file to save to. If it has no extension, `.rbxmx/rbxm` (models) or `.rbxlx/rbxl` (places) is appended; an existing extension is left as-is. Ignores `OPTIONS.AvoidFileOverwrite`. _**Default:**_ false
- `AvoidFileOverwrite: boolean` — Prevents writing to place file that already exists. _**Default:**_ true
- `Object: Instance` —
- If provided, saves as .rbxmx (Model file) instead. If Object is game, it will be saved as a .rbxl file. **MUST BE AN INSTANCE REFERENCE, FOR EXAMPLE - _game.Workspace_**. `"optimized"` mode is **NOT** supported with this option. If IsModel is set to false then Object specified here will be saved as a place file. _**Default:**_ false   - `IsModel: boolean` — If Object is specified then sets to true automatically, unless you set it to false. _**Default:**_ false
- `NilInstances: boolean` — Save instances that aren't Parented (Parented to nil). _**Default:**_ false
- `NilInstancesFixes: {[Instance.ClassName]=function}` —
- This can cause some Classes to be fixed even though they might not need the fix (better be safe than sorry though). For example, Bones inherit from Attachment if we dont define them in the NilInstancesFixes then this will catch them anyways. **TO AVOID THIS BEHAVIOR USE THIS EXAMPLE:** {ClassName_That_Doesnt_Need_Fix = false}. _**Default:**_ {Animator = function, AdPortal = function, BaseWrap = function, Attachment = function}   - `IgnoreDefaultProperties: boolean` — Ignores default properties during saving. _**Default:**_ true
- `IgnoreNotArchivable: boolean` — Ignores the Archivable property and saves Non-Archivable instances. _**Default:**_ true
- `IgnorePropertiesOfNotScriptsOnScriptsMode: boolean` — Ignores property of every instance that is not a script in "scripts" mode. _**Default:**_ false
- `IgnoreSpecialProperties: boolean` — Prevents calls to `gethiddenproperty` and uses fallback methods instead. This also helps with crashes. If your file is corrupted after saving, you can try turning this on. _**Default:**_ false
- `IsolateStarterPlayer: boolean` — Saves StarterPlayer as separate folder, children of the original instance will be ignored. _**Default:**_ false
- `IsolatePlayers: boolean` — Saves All Players as separate folder, children of the original instance will be ignored. _**Default:**_ false
- `IsolateLocalPlayer: boolean` — Saves LocalPlayer as separate folder, original instance will be ignored. _**Default:**_ false
- `IsolateLocalPlayerCharacter: boolean` — Saves LocalPlayer.Character as separate folder, original instance will be ignored. _**Default:**_ false
- `SavePlayerCharacters: boolean` — Save player characters while saving. _**Default:**_ false
- `SaveNotCreatable: boolean` —
- Includes non-serializable instances as Folder objects (Name is misleading as this is mostly a fix for certain NilInstances and isn't always related to NotCreatable). Other options also enable it, like: IsolatePlayers, IsolateLocalPlayer, etc. _**Default:**_ false   - `NotCreatableFixes: table<Instance.ClassName>` —
- {"Player"} is the same as {Player = "Folder"}; Format like {SpawnLocation = "Part"} is only to be used when SpawnLocation inherits from "Part" AND "Part" is Creatable. _**Default:**_ { "", "Player", "PlayerScripts", "PlayerGui", "TouchTransmitter" }   - `AlternativeWritefile: boolean` —
- Splits file content string into segments and writes them using appendfile. This might help with crashes when it starts writing to file. Though there is a risk of appendfile working incorrectly on some execs. _**Default:**_ true   - `IgnoreDefaultPlayerScripts: boolean` —
- **RISKY**: Ignores Default PlayerScripts like PlayerModule & RbxCharacterSounds. Prevents crashes on some execs. _**Default:**_ true   - `SharedBinaryStrings: boolean` — Stores BinaryString values in a shared pool so identical ones are only written once, instead of repeating them for every instance. Good when many instances hold the same data (like copies of the same mesh) -- can make files noticeably smaller. Slightly bigger when everything is unique. Roblox doesn't officially support this, so there's a small chance it confuses Studio. _**Default:**_ false
- `TreatUnionsAsParts: boolean` —
- **RISKY:** Converts all UnionOperations to Parts. Useful if your Executor isn't able to save (read) Unions, because otherwise they will be invisible. _**Default:**_ false (except Solara)   `}` - Structure of the main CustomOptions table.
- Note: Options are case-insensitive, meaning you can type `NilInstances` option as `nilInStaNces` and it still will be valid.   ### `OptionsAliases` `interface OptionsAliases {` - `Clipboard: string` — CopyToClipboard
- `DecompileScripts: string` — Decompile
- `FileName: string` — FilePath
- `IgnoreArchivable: string` — IgnoreNotArchivable
- `IgnoreDefaultProps: string` — IgnoreDefaultProperties
- `InstancesBlacklist: string` — IgnoreList
- `IsolatePlayerGui: string` — IsolateLocalPlayer
- `SaveCharacters: string` — SavePlayerCharacters
- `SaveLocalPlayer: string` — IsolateLocalPlayer
- `SaveNilInstances: string` — NilInstances
- `SaveNonCreatable: string` — SaveNotCreatable
- `SavePlayerGui: string` — IsolateLocalPlayer
- `SavePlayers: string` — IsolatePlayers
- `StatusText: string` — ShowStatus
- `timeout: string` — DecompileTimeout
`}`

 Alias → Canonical option mapping for the SynSaveInstance.CustomOptions table. Format: { Alias = CanonicalOption } These are resolved before user options are processed and cannot be modified at runtime.

### `OptionsAliasesInverse`

`interface OptionsAliasesInverse {`

- `DisableCompression: string` — CompressionMode
- `noscripts: string` — Decompile
- `RemovePlayerCharacters: string` — SavePlayerCharacters
- `RemovePlayers: string` — IsolatePlayers
- `XML: string` — Binary
`}`

 Alias → Canonical option mapping with boolean inversion. Format: { Alias = CanonicalOption } These aliases invert the provided boolean value before applying it. Example: noscripts = true → Decompile = false These are resolved before user options are processed and cannot be modified at runtime.

## Functions

### `saveinstance`
This is a yielding function. When called, it will pause the Lua thread that called the function until a result is ready to be returned, without interrupting other scripts. Yields

`SynSaveInstance.saveinstance(`

- `Parameter_1: variant<table,table<Instance>>,` — Can either be SynSaveInstance.CustomOptions table or a filled with instances ({Instance}), (then it will be treated as ExtraInstances with an invalid mode and IsModel will be true).
- `Parameter_2: table` — [OPTIONAL] If present, then Parameter_2 will be assumed to be SynSaveInstance.CustomOptions table. And then if the Parameter_1 is an Instance, then it will be assumed to be SynSaveInstance.CustomOptions table.Object. If Parameter_1 is a table filled with instances ({Instance}), then it will be assumed to be SynSaveInstance.CustomOptions table.ExtraInstances and IsModel will be true). This exists for sake compatibility with `saveinstance(game, {})`
`) → ()`

Saves instances with specified options. Example:

```lua
local Params = {
	RepoURL = "https://raw.githubusercontent.com/andrewexec/USSI-Redux/main/",
	SSI = "saveinstance",
}

local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()

local CustomOptions = { SafeMode = true, DecompileTimeout = 15, SaveBytecode = true }

synsaveinstance(CustomOptions)

```
