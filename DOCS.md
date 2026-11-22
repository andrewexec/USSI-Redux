# SynSaveInstance
Represents the options for saving instances with custom settings using the `synsaveinstance` function.

> **Source:** `saveinstance.luau` (line 2202)

## Table of Contents

- [Functions](#functions)
  - [saveinstance](#saveinstance)
- [Types](#types)
  - [CustomOptions](#customoptions)
  - [OptionsAliases](#optionsaliases)
  - [OptionsAliasesInverse](#optionsaliasesinverse)

---

## Functions

### `saveinstance`

> **Yields:** Yes | **Source:** `saveinstance.luau` (line 2298)

```lua
SynSaveInstance.saveinstance(
    Parameter_1: variant<table, table<Instance>>,
    Parameter_2: table?
) -> ()
```

Saves instances with specified options.

#### Parameters

| Name | Type | Description |
| :--- | :--- | :--- |
| `Parameter_1` | `variant<table, table<Instance>>` | Can either be a `CustomOptions` table or an array of instances (`{Instance}`), in which case it is treated as `ExtraInstances` with an invalid mode and `IsModel = true`. |
| `Parameter_2` | `table` *(optional)* | If present, treated as `CustomOptions`. If `Parameter_1` is an `Instance`, it is treated as `CustomOptions.Object`. If `Parameter_1` is `{Instance}`, it is treated as `CustomOptions.ExtraInstances` with `IsModel = true`. Exists for backwards compatibility with `saveinstance(game, {})`. |

#### Example

```lua
local Params = {
	RepoURL = "[https://raw.githubusercontent.com/andrewexec/USSI-Redux/main/](https://raw.githubusercontent.com/andrewexec/USSI-Redux/main/)",
	SSI = "saveinstance",
}

local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()

local CustomOptions = { SafeMode = true, DecompileTimeout = 15, SaveBytecode = true }

synsaveinstance(CustomOptions)
```

---

## Types

### `CustomOptions`

> **Source:** `saveinstance.luau` (line 2250)

Structure of the main `CustomOptions` table.

> **Note:** Option keys are case-insensitive (for example, `nilInStaNces` is treated identically to `NilInstances`).

| Field | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `__DEBUG_MODE` | `boolean` | `false` | Prints debug logs to the console for unusual scenarios. Recommended when reporting bugs or issues. |
| `ReadMe` | `boolean` | `true` | Includes a readme note in the saved output. |
| `SafeMode` | `boolean` | `true` | Kicks you before saving to keep your session safe. **Highly recommended to keep enabled.** |
| `KillAllScripts` | `boolean` | `true` | Kills all scripts for added protection (also enabled by default via `SafeMode`). **Highly recommended to keep enabled.** |
| `BoostFPS` | `boolean` | `false` | Greatly increases FPS by disabling 3D rendering (also enabled by options such as `SafeMode`). |
| `ShutdownWhenDone` | `boolean` | `false` | Shuts down the game after `saveinstance` finishes. |
| `AntiIdle` | `boolean` | `true` | Prevents the 20-minute idle kick. |
| `Anonymous` | `{boolean \| table{UserId = string, Name = string}}` | `false` | **Risky:** Strips account details (`Name`, `UserId`) from the output (useful when games store them in GUIs or instances). Can corrupt substrings or number sequences that match your name or ID. Accepts a table with `UserId` and `Name` keys. |
| `ShowStatus` | `boolean` | `true` | Displays save progress/status information. |
| `Callback` | `function` | `false` | Sends serialized data to the provided callback function instead of writing to a file. |
| `mode` | `string` | `"optimized"` | Valid modes: `"full"`, `"optimized"`, `"scripts"`. Use an invalid mode (such as `"invalid"`) to save only `ExtraInstances`. `"optimized"` is **not** supported with `Object`. |
| `Decompile` | `boolean` | `true` | Enables or disables script decompilation. |
| `scriptcache` | `boolean` | `true` | Reuses decompiled script cache to skip decompiling duplicate scripts. |
| `DecompileTimeout` | `number` | `10` | Cancels decompilation if runtime exceeds this value (in seconds). Set to `-1` to disable timeout (unreliable). |
| `DecompileJobless` | `boolean` | `false` | Includes already-decompiled code in the output without decompiling new scripts. |
| `SaveBytecode` | `boolean` | `false` | Includes script bytecode in the output for later decompilation. |
| `DecompileIgnore` | `{Instance \| Instance.ClassName \| [Instance.ClassName] = {Instance.Name}}` | `{TextChatService}` | Ignores matching instances and their descendants by default; set `= false` to ignore only the instance itself. Examples: `"Chat"` (by class), `Players = {"MyPlayerName"}` (by class and name), `workspace` (by reference), `[workspace] = false` (by reference without descendants). |
| `IgnoreList` | `{Instance \| Instance.ClassName \| [Instance.ClassName] = {Instance.Name}}` | `{CoreGui, CorePackages}` | Similar to `DecompileIgnore`, except `= false` means ignoring an instance automatically ignores its descendants. |
| `ExtraInstances` | `{Instance}` | `{}` | Additional instances to save; when paired with an invalid `mode` (e.g., `"invalidmode"`), only these instances are saved. |
| `IgnoreProperties` | `table` | `{}` | Ignores properties by name. |
| `SaveCacheInterval` | `number` | `0x1600 * 10` | Controls how frequently save cache flushes; lower values save more often at the cost of performance. |
| `FilePath` | `string` | `false` | File name (optionally including a path) **without** a file extension. |
| `AvoidFileOverwrite` | `boolean` | `true` | Prevents overwriting an existing place file. |
| `Object` | `Instance` | `false` | Saves as `.rbxmx` (model), or `.rbxl` if `Object` is `game`. Must be an `Instance` reference (e.g., `game.Workspace`). `"optimized"` mode is **not** supported. Setting `IsModel = false` saves the specified object as a place file instead. |
| `IsModel` | `boolean` | `false` | Automatically becomes `true` when `Object` is set unless explicitly set to `false`. |
| `NilInstances` | `boolean` | `false` | Saves unparented instances (`Parent == nil`). |
| `NilInstancesFixes` | `{[Instance.ClassName] = function}` | `{Animator = function, AdPortal = function, BaseWrap = function, Attachment = function}` | Custom fix functions for nil instances. Inherited classes (such as `Bone` inheriting from `Attachment`) may be caught unless explicitly excluded with `{ClassName = false}`. |
| `IgnoreDefaultProperties` | `boolean` | `true` | Omits properties still set to their default values. |
| `IgnoreNotArchivable` | `boolean` | `true` | Saves instances even when `Archivable` is `false`. |
| `IgnorePropertiesOfNotScriptsOnScriptsMode` | `boolean` | `false` | Ignores properties on non-script instances when `mode` is `"scripts"`. |
| `IgnoreSpecialProperties` | `boolean` | `false` | Avoids `gethiddenproperty` calls in favor of fallbacks; helps prevent crashes or file corruption. |
| `IsolateStarterPlayer` | `boolean` | `false` | Saves `StarterPlayer` into a separate folder and skips children of the original instance. |
| `IsolatePlayers` | `boolean` | `false` | Saves all players into a separate folder and skips children of the original instance. |
| `IsolateLocalPlayer` | `boolean` | `false` | Saves `LocalPlayer` into a separate folder and ignores the original instance. |
| `IsolateLocalPlayerCharacter` | `boolean` | `false` | Saves `LocalPlayer.Character` into a separate folder and ignores the original instance. |
| `SavePlayerCharacters` | `boolean` | `false` | Ignores player characters while saving. |
| `SaveNotCreatable` | `boolean` | `false` | Saves non-serializable instances as `Folder` objects (primarily a nil-instance fix; also enabled by options like `IsolatePlayers` and `IsolateLocalPlayer`). |
| `NotCreatableFixes` | `table<Instance.ClassName>` | `{"", "Player", "PlayerScripts", "PlayerGui", "TouchTransmitter"}` | Maps non-creatable classes to fallback classes (e.g., `{"Player"}` equals `{Player = "Folder"}`). Only use `{SpawnLocation = "Part"}` when `SpawnLocation` inherits from `Part` and `Part` is creatable. |
| `AlternativeWritefile` | `boolean` | `true` | Splits output into chunks written via `appendfile` to reduce write crashes, though `appendfile` behavior varies across executors. |
| `IgnoreDefaultPlayerScripts` | `boolean` | `true` | **Risky:** Ignores default player scripts (`PlayerModule`, `RbxCharacterSounds`) to prevent crashes on certain executors. |
| `IgnoreSharedStrings` | `boolean` | `true` | **Risky:** Temporary crash workaround tested on RoExec; can be disabled to test compatibility on your executor. |
| `SharedStringOverwrite` | `boolean` | `false` | **Risky:** Reuses shared strings across compatible base64-encoded types to potentially shrink file size (can also increase it). If the process crashes before completion, affected values are lost and type mismatches can occur. |
| `TreatUnionsAsParts` | `boolean` | `false` *(except Solara)* | **Risky:** Converts `UnionOperation` instances into `Part`s so they remain visible if your executor cannot read/save unions properly. |

---

### `OptionsAliases`

> **Source:** `saveinstance.luau` (line 2267)

Maps alias keys to canonical `CustomOptions` fields (`{ [Alias]: CanonicalOption }`). Resolved before user options are processed and cannot be modified at runtime.

| Alias | Canonical Option |
| :--- | :--- |
| `timeout` | `DecompileTimeout` |
| `FileName` | `FilePath` |
| `IgnoreArchivable` | `IgnoreNotArchivable` |
| `IgnoreDefaultProps` | `IgnoreDefaultProperties` |
| `InstancesBlacklist` | `IgnoreList` |
| `SaveLocalPlayer` | `IsolateLocalPlayer` |
| `IsolatePlayerGui` | `IsolateLocalPlayer` |
| `SavePlayerGui` | `IsolateLocalPlayer` |
| `SavePlayers` | `IsolatePlayers` |
| `SaveNonCreatable` | `SaveNotCreatable` |
| `SaveCharacters` | `SavePlayerCharacters` |

---

### `OptionsAliasesInverse`

> **Source:** `saveinstance.luau` (line 2277)

Maps alias keys to canonical `CustomOptions` boolean fields with **inverted** values (`{ [Alias]: CanonicalOption }`). For example, `noscripts = true` sets `Decompile = false`.

| Alias | Canonical Option (Inverted) |
| :--- | :--- |
| `noscripts` | `Decompile` |
| `RemovePlayers` | `IsolatePlayers` |
| `RemovePlayerCharacters` | `SavePlayerCharacters` |
