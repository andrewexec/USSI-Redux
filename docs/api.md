---
sidebar_position: 2
title: API Reference
---

# API Reference

## Options

Every option is optional. Pass them in one table: `synsaveinstance({ mode = "full" })`. Option names are not case-sensitive: `NilInstances`, `nilinstances`, and `nilInStaNces` are the same option. Unknown names are ignored.

### `mode`

Type: `string`. Default: `optimized`.

What to save. `optimized` saves the most important services (Workspace, Players, Lighting, ReplicatedStorage, StarterGui, and others). `full` saves everything under `game` and also turns `IgnoreDefaultProperties` off, unless you set it yourself. `scripts` saves only the objects that are, or contain, a [LuaSourceContainer] (a script object), along with the path of parents that lead to them. Objects that don't lead to a script are left out. Any other value saves only `ExtraInstances` (and `Object`, if set). If `Object` is set, `optimized` becomes `full`.

### `Binary`

Type: `boolean`. Default: `true`.

Save a binary file (`.rbxl`/`.rbxm`) instead of an XML file (`.rbxlx`/`.rbxmx`). Binary files are smaller and load faster. If the executor cannot write binary data correctly, the script uses XML. Set the old option `XML = true` to force XML.

### `CompressionMode`

Type: `string | boolean`. Default: `"zstd"`.

How to compress (make smaller) the binary file: `"zstd"`, `"lz4"`, or `false` for no compression. `true` means `"zstd"`. The old option `DisableCompression = true` means `false`.

### `CompressionLevel`

Type: `number`. Default: `9`.

Compression level for zstd, from -7 to 22. A higher level makes a smaller file but takes longer. This is ignored for lz4 and when compression is off.

### `FilePath`

Type: `string | false`. Default: `false`.

File name to save to. You can include a folder. If the name has no extension, the script adds one based on `Binary` and `IsModel`. If you set this, the script overwrites an existing file and ignores `AvoidFileOverwrite`.

### `SafeMode`

Type: `boolean`. Default: `false`.

Disconnect the LocalPlayer from the game when saving starts. This turns on `KillAllScripts` and `BoostFPS` unless you set them yourself. **HIGHLY RECOMMENDED.**

### `KillAllScripts`

Type: `boolean`. Default: `false`.

Close or disable other running scripts before saving. `SafeMode` turns this on. Some games stop responding to input after this. That is normal. **HIGHLY RECOMMENDED.**

### `BoostFPS`

Type: `boolean`. Default: `false`.

Turn off 3D rendering while saving, then turn it back on. `SafeMode` turns this on.

### `Object`

Type: `Instance | false`. Default: `false`.

Save this [Instance] instead of the whole place. The script saves a model if you do not set `IsModel = false`. If you pass `game`, it saves the place and uses `full` mode. You must pass an [Instance], not a name.

### `IsModel`

Type: `boolean`. Default: `false`.

Save a model (`.rbxm`/`.rbxmx`) instead of a place (`.rbxl`/`.rbxlx`). `Object` turns this on unless you set it yourself. Passing a list of Instances as an argument also turns it on.

### `ShowStatus`

Type: `boolean`. Default: `true`.

Show a status label on the screen. It shows the size while saving, then the final size and time.

### `ReadMe`

Type: `boolean`. Default: `true`.

Add a README script to the save. It contains save details (place ID, date, time, platform, executor, recovered scripts, warnings) and tips.

### `Decompile`

Type: `boolean`. Default: `true`.

Turn the compiled script back into source code (decompile). This replaces the `Source` of each [LuaSourceContainer] with decompiled code. If this is off, `Source` says decompiling is disabled.

### `SaveBytecode`

Type: `boolean`. Default: `false`.

If the executor supports `getscriptbytecode`, add the compiled script data (bytecode) to `Source` as a comment. You can decompile it later. This respects `DecompileIgnore`.

### `DecompileTimeout`

Type: `number`. Default: `10`.

How many seconds one decompile call can take. If it takes longer, the script stops waiting and writes a timeout message in `Source`. Set to -1 to disable the timeout.

### `DecompileThreads`

Type: `number`. Default: `1`.

How many scripts to decompile at the same time before saving. 1 decompiles one by one while saving. Higher values only help if your executor's `decompile` yields, and need `scriptcache` and `getscriptbytecode`.

### `Decompiler`

Type: `string`. Default: `"auto"`.

Which decompiler turns scripts back into source. `"auto"` uses the executor's `decompile`, and uses MoonDecompiler (a Luau decompiler downloaded from `BuiltinDecompilerURL`) when the executor has none or it fails. `"executor"` only uses the executor's `decompile`. `"moon"` only uses MoonDecompiler.

### `CustomDecompiler`

Type: `((script: Instance, bytecode: string?) -> string) | {decompile: (script: Instance, bytecode: string?) -> string} | false`. Default: `false`.

Your own decompiler, that can replace the default decompile function with a custom one.

### `BuiltinDecompilerURL`

Type: `string | false`. Default: `false`.

Optional. Where MoonDecompiler is downloaded from when it is needed. Leave it false and the USSI-Redux repository is used automatically (the `main` branch first, then `experimental`).

### `BytecodeTimeout`

Type: `number`. Default: `3`.

How many seconds a `getscriptbytecode` call can take. If it takes longer, the script stops waiting and skips the bytecode for that script. Set to -1 to disable the timeout.

### `DecompileIgnore`

Type: `{Instance | string} | {[Instance | string]: boolean | {[string]: boolean}}`. Default: `{TextChatService}`.

Skip decompiling matched [Instance]s and their children. `Source` becomes a short ignored message. You can pass an [Instance], a class name, or `ClassName = {Name1, Name2}`. Set an [Instance] to `false` to skip only that instance, not its children.

### `SourceCache`

Type: `{[Instance]: string} | false`. Default: `false`.

Source text to use for these scripts as-is instead of decompiling them.

### `DecompileJobless`

Type: `boolean`. Default: `false`.

Only use scripts that are already in the decompile cache. Missing scripts get a short not-found message. This turns on `scriptcache`.

### `SkipCrashedScripts`

Type: `boolean`. Default: `true`.

Remember which script was being decompiled. If the executor crashed or the game closed mid-decompile, the next run skips that script (its `Source` says so) instead of crashing again, so rerunning the save gets past the crash point. The list is kept in `EXEC_STATE.json`.

### `RetryCrashedScripts`

Type: `boolean`. Default: `false`.

Forget the scripts remembered by `SkipCrashedScripts` and try to decompile them again. Use this if a script was skipped by mistake, for example when you closed the game during a save.

### `scriptcache`

Type: `boolean`. Default: `true`.

If the executor supports `getscriptbytecode`, cache decompiled code. This avoids decompiling the same script twice. The cache stays after the script reloads.

### `RecoverScriptsFromAssets`

Type: `boolean`. Default: `true`.

Recover the original `Source` of scripts that were published as assets. Changes made after publishing are not included.

### `IsolatePlayers`

Type: `boolean`. Default: `false`.

Put every [Player] under a top-level `"Players"` Folder instead of inside the [Players] service. This turns on `SaveNotCreatable`. If both are on, this option is used instead of `IsolateLocalPlayer`.

### `IsolateLocalPlayer`

Type: `boolean`. Default: `false`.

Save the LocalPlayer as a Folder named `"LocalPlayer"` instead of a [Player] object. This is ignored if `IsolatePlayers` is on.

### `IsolateLocalPlayerCharacter`

Type: `boolean`. Default: `false`.

Save LocalPlayer.Character as a [Model] named `"LocalPlayer Character"`. This saves the character even when characters are normally skipped.

### `IsolateStarterPlayer`

Type: `boolean`. Default: `false`.

Put [StarterPlayer]'s children under a top-level `"StarterPlayer"` Folder. The original service stays, but it is empty.

### `SavePlayerCharacters`

Type: `boolean`. Default: `false`.

Save player characters instead of skipping them. This also saves objects with `Archivable = false`, so `IgnoreNotArchivable` is forced on.

### `NilInstances`

Type: `boolean`. Default: `false`.

Include objects that have no parent (they are not under `game`). This needs the executor function `getnilinstances`. When that function exists, it also turns on `SaveNotCreatable`.

### `ExtraInstances`

Type: `{Instance}`. Default: `{}`.

A list of [Instance]s to add to the normal save. If `mode` is not a valid value, only these Instances (and `Object`, if set) are saved. Passing a list of Instances as an argument fills this list.

### `IgnoreList`

Type: `{Instance | string} | {[Instance | string]: boolean | {[string]: boolean}}`. Default: `{CoreGui, CorePackages, Packages = false}`.

Objects to skip. Use an [Instance] or a class name as a key to skip that object and its children. `ClassName = false` keeps the object but skips its children. `ClassName = {Name1, Name2}` skips objects with those names. You can also pass a list of Instances or class names.

### `MaxDepth`

Type: `number`. Default: `1000`.

Objects nested deeper than this are moved up under their ancestor at depth `MaxDepth`, so nothing is dropped, only the nesting is lost. This stops very deep hierarchies from overflowing the stack when Roblox Studio opens the file (binary saves opened at 1740 levels deep; XML saves crashed at 1750). Use `math.huge` to disable.

### `IgnoreSpecialProperties`

Type: `boolean`. Default: `false`.

Do not use the executor function `gethiddenproperty`. Other property reads still work. This can help if your executor crashes or the file is corrupted.

### `AlternativeWritefile`

Type: `boolean`. Default: `true`.

Write the file in smaller pieces with `appendfile` instead of one `writefile` call. For binary saves, if `appendfile` fails, it uses `writefile`; if both fail, it switches to XML.

### `Anonymous`

Type: `boolean | {Name: string?, UserId: number?}`. Default: `false`.

**RISKY:** Replace LocalPlayer.Name and UserId in the output. `true` replaces them with `"Roblox"` and `1`. You can also pass a table with `Name` and/or `UserId`. Name matching ignores case. This can also change other text or numbers that match.

### `RiskyServicesDisabled`

Type: `{UGC: boolean?, Encoding: boolean?, Reflection: boolean?}`. Default: `{UGC = true, Encoding = false, Reflection = false}`.

Turn off services that some games may detect. `UGC` skips [UGCValidationService] (used for some hidden properties). `Encoding` skips [EncodingService]. `Reflection` skips [ReflectionService] (used for class data). Set a flag to `true` to skip that service. If you do not set `RiskyServicesDisabled` yourself, the UGC fallback turns on automatically when `gethiddenproperty` is missing.

### `AvoidFileOverwrite`

Type: `boolean`. Default: `true`.

If `FilePath` is not set, add (1), (2), ... to the file name instead of overwriting an existing file.

### `AntiIdle`

Type: `boolean`. Default: `true`.

Stop Roblox from kicking you for being idle (not moving) for 20 minutes.

### `CopyToClipboard`

Type: `boolean`. Default: `false`.

Copy the result to the clipboard (the copy/paste buffer) instead of writing a file. Your executor must support `setrbxclipboard`. Use this only for small saves.

### `Callback`

Type: `((data: string, chunks: {string}) -> ()) | false`. Default: `false`.

Call this function with the result instead of writing a file. It receives the full text and a list of chunks. If `CopyToClipboard` is also on, the clipboard is used instead.

### `IgnoreProperties`

Type: `{string}`. Default: `{}`.

A list of property names to skip on every object. For example: `{"Tags", "AttributesSerialize"}`.

### `IgnoreNotArchivable`

Type: `boolean`. Default: `true`.

Save objects even when their `Archivable` property is `false`. If this is off, the script skips those objects.

### `SaveNotCreatable`

Type: `boolean`. Default: `false`.

Save classes that Roblox says are not creatable. The script replaces them with a class it can create, using `NotCreatableFixes` (usually `Folder`). This turns on automatically with `IsolatePlayers`, `IsolateLocalPlayer`, and `NilInstances` (when `getnilinstances` exists).

### `NotCreatableFixes`

Type: `{string} | {[string]: string | false}`. Default: `built-in replacements`.

Replace a class with a class that can be created. The default replacement is `"Folder"`. A list of class names also becomes `Folder`. Built-in changes: [Player], [PlayerGui], [PlayerScripts], [TouchTransmitter], and others become `Folder`; [CloudLocalizationTable] becomes [LocalizationTable]; `Platform` becomes [Part]; `Status` becomes [Model]. Set a class to `false` to skip its replacement.

### `NilInstancesFixes`

Type: `{[string]: ((instance: Instance, overrides: table) -> Instance?) | false}`. Default: `built-in Animator/AdPortal/Attachment/BaseWrap/PackageLink fixes`.

Where to put objects that have no parent. For example, it puts [Animator] under an [AnimationController]. Built-in fixes exist for [Animator], [AdPortal], [Attachment], [BaseWrap], [PackageLink], [DebuggerWatch], and [PluginAction] (the last two have no valid parent, so they are skipped). Child classes use the parent fix ([Bone]s use the Attachment fix). Set a class to `false` to turn off its fix.

### `IgnoreDefaultProperties`

Type: `boolean`. Default: `true`.

Skip properties that already have the default value for their class. This only affects XML output. Binary output does not use this option.

### `IgnorePropertiesOfNotScriptsOnScriptsMode`

Type: `boolean`. Default: `false`.

Only in `scripts` mode: save properties for [LuaSourceContainer]s and skip properties for all other objects. This does nothing in other modes.

### `IgnoreDefaultPlayerScripts`

Type: `boolean`. Default: `false`.

Skip Roblox's default player scripts (`PlayerModule`, `BubbleChat`, `ChatScript`, `PlayerScriptsLoader`, `RbxCharacterSounds`). This can stop some executors from crashing during decompile.

### `SaveCacheInterval`

Type: `number`. Default: `0x1600 * 10`.

How much XML data the script holds in memory while saving. Lower values update the status more often but are slower. This does not write to disk. When `KillAllScripts` is on, this also sets the script timeout between 20 and 30 seconds.

### `SharedBinaryStrings`

Type: `boolean`. Default: `false`.

Store the same binary data (meshes, images, ...) only once in the file. This makes saves with repeated data smaller. Files with all unique data can get slightly bigger. This is not an official Roblox format, but Studio can still open the file.

### `TreatUnionsAsParts`

Type: `boolean`. Default: `false`.

Change all [PartOperation]s (unions and intersections) into [Part]s. **RISKY:** you lose the merged shape, but executors that cannot read unions will still show visible parts.

### `ShutdownWhenDone`

Type: `boolean`. Default: `false`.

Close the game after a successful save.

### `__DEBUG_MODE`

Type: `boolean | ((...any) -> ())`. Default: `false`.

Print debug warnings for unusual cases. If you pass a function, the script uses it instead of `warn`.

## Aliases

Old option names that still work. Each one sets the option shown beside it.

| Alias | Option |
| --- | --- |
| `AnonymousMode` | `Anonymous` |
| `Blacklist` | `IgnoreList` |
| `ClassIgnoreList` | `IgnoreList` |
| `Clipboard` | `CopyToClipboard` |
| `Compress` | `CompressionMode` |
| `Compression` | `CompressionMode` |
| `Debug` | `__DEBUG_MODE` |
| `DecompileScripts` | `Decompile` |
| `Decompiler` | `Decompile` |
| `DecompilerTimeout` | `DecompileTimeout` |
| `EmbedBytecode` | `SaveBytecode` |
| `FileName` | `FilePath` |
| `IgnoreArchivable` | `IgnoreNotArchivable` |
| `IgnoreClasses` | `IgnoreList` |
| `IgnoreDefaultProps` | `IgnoreDefaultProperties` |
| `IgnoreInstances` | `IgnoreList` |
| `IgnoreProperty` | `IgnoreProperties` |
| `IgnoreRobloxPlayerScripts` | `IgnoreDefaultPlayerScripts` |
| `InstanceIgnoreList` | `IgnoreList` |
| `InstancesBlacklist` | `IgnoreList` |
| `IsolatePlayerGui` | `IsolateLocalPlayer` |
| `LocalPlayer` | `IsolateLocalPlayer` |
| `Model` | `Object` |
| `NoXML` | `Binary` |
| `Path` | `FilePath` |
| `Players` | `IsolatePlayers` |
| `Progress` | `ShowStatus` |
| `Root` | `Object` |
| `SaveAsBinary` | `Binary` |
| `SaveCharacters` | `SavePlayerCharacters` |
| `SaveLocalPlayer` | `IsolateLocalPlayer` |
| `SaveModel` | `Object` |
| `SaveNil` | `NilInstances` |
| `SaveNilInstances` | `NilInstances` |
| `SaveNonCreatable` | `SaveNotCreatable` |
| `SavePlayerGui` | `IsolateLocalPlayer` |
| `SavePlayers` | `IsolatePlayers` |
| `SavePlayersData` | `IsolatePlayers` |
| `SaveScripts` | `Decompile` |
| `SaveStarterPlayer` | `IsolateStarterPlayer` |
| `ScriptDecompile` | `Decompile` |
| `ShowProgress` | `ShowStatus` |
| `Status` | `ShowStatus` |
| `StatusText` | `ShowStatus` |
| `UseDecompiler` | `Decompile` |
| `Verbose` | `__DEBUG_MODE` |
| `timeout` | `DecompileTimeout` |

## Inverted aliases

Old option names that set the option shown beside them to the opposite value. For example `noscripts = true` sets `Decompile = false`.

| Alias | Option |
| --- | --- |
| `DisableCompression` | `CompressionMode` |
| `NoDecompile` | `Decompile` |
| `noscripts` | `Decompile` |
| `NullifyScripts` | `Decompile` |
| `Overwrite` | `AvoidFileOverwrite` |
| `RemovePlayerCharacters` | `SavePlayerCharacters` |
| `RemovePlayers` | `IsolatePlayers` |
| `SkipScripts` | `Decompile` |
| `XML` | `Binary` |
