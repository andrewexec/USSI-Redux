---
sidebar_position: 1
title: Getting Started
---

# Getting Started

USSI Redux is a `saveinstance` for Roblox executors, written in Luau. It revives the `saveinstance` function from Synapse X and can also be edited and used as a Roblox-format-file writer.

:::caution Disclaimer
This project is provided for development, debugging, archival and research purposes within the Roblox platform. It is not intended for misuse, including violating platform rules, unauthorized access, or redistribution of content without permission. You are responsible for following Roblox's Terms of Use.

This is an independent, unofficial project. It is not affiliated with, endorsed by, or officially connected to Roblox Corporation.
:::

## Load it

```lua
local Params = {
	RepoURL = "https://raw.githubusercontent.com/andrewexec/USSI-Redux/main/",
	SSI = "saveinstance",
}

local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()

synsaveinstance({}) -- saves with the default options
```

Pass a table of options to change what is saved and how:

```lua
synsaveinstance({
	mode = "full",
	SafeMode = true,
	DecompileTimeout = 15,
})
```

Option names are not case-sensitive, and many have aliases. Every option is listed on the [API Reference](/docs/api) page, and the generated [type page](/api/UniversalSynSaveInstance) documents the `SaveInstanceOptions` type.

## Output

By default the save is a binary place file (`.rbxl`, or `.rbxm` for a model). It is much smaller and faster to load than XML. Set `XML = true` for `.rbxlx` / `.rbxmx`.

| Option | Default | Meaning |
| --- | --- | --- |
| `Binary` | `true` | Save as binary instead of XML. |
| `CompressionMode` | `"zstd"` | How binary chunks are compressed: `"zstd"`, `"lz4"` or `false` for none. |
| `CompressionLevel` | `9` | Compression strength from -7 to 22. Higher is smaller but slower. |
| `Callback` | `false` | Send the data to a function instead of writing a file. |
| `CopyToClipboard` | `false` | Put the output on the clipboard. Only suits small saves. |
| `MaxDepth` | `1000` | Objects nested deeper than this are moved up under their ancestor at that depth, so nothing is dropped. This stops very deep hierarchies from overflowing the stack when Roblox Studio opens the file. |

## Modes

`mode` chooses what gets saved.

| Mode | What it saves |
| --- | --- |
| `"optimized"` (default) | The most important services: Workspace, Players, Lighting, ReplicatedStorage, StarterGui and others. |
| `"full"` | Everything under `game`. It also sets `IgnoreDefaultProperties` to `false`, unless you set that option yourself. |
| `"scripts"` | Only the objects that are, or contain, a script, plus the parents that lead to them. |
| any other value | Only `ExtraInstances` (and `Object`, if set). |

If you set `Object`, `"optimized"` becomes `"full"`. Saving `game` as the `Object` is the same as `"full"`.

`IgnoreDefaultProperties` only affects XML output. Binary saves do not use it.

```lua
-- keep every property
synsaveinstance({ mode = "full" })

-- "full" mode, but still skip default values
synsaveinstance({ mode = "full", IgnoreDefaultProperties = true })
```

## Decompiling scripts

Scripts are decompiled automatically. `saveinstance` uses your executor's `decompile`, and falls back to [MoonDecompiler](https://github.com/andrewexec/USSI-Redux/blob/main/Tools/MoonDecompiler/README.md), a decompiler written in Luau that is downloaded from this repository the first time it is needed. The fallback is used when the executor has no `decompile`, it errors, or it returns nothing.

| Option | Default | Meaning |
| --- | --- | --- |
| `Decompile` | `true` | Turn decompiling on or off. |
| `Decompiler` | `"auto"` | `"auto"`, `"executor"` (only the executor's decompiler) or `"moon"` (only MoonDecompiler). |
| `CustomDecompiler` | `false` | Your own decompiler: a function `(script, bytecode) -> string`, or a table with a `decompile` method. It is tried first. |
| `DecompileTimeout` | `10` | Seconds one decompile call may take. `-1` disables the timeout. |
| `DecompileThreads` | `1` | How many scripts to decompile at once. Only helps if your executor's `decompile` yields. |
| `scriptcache` | `true` | Reuse decompiled output for identical scripts. |
| `SaveBytecode` | `false` | Add each script's bytecode to its `Source` as a comment. |

```lua
synsaveinstance({
	CustomDecompiler = function(script, bytecode)
		return decompileWithMedal(bytecode) -- return the source text
	end,
})
```

Functions MoonDecompiler can't rebuild with normal structure are saved as a loop, or as a commented disassembly, and start with a comment saying why.

## Recovering from a crash

Some executors crash on particular scripts during decompile. USSI Redux remembers which script was being decompiled, so you can run the save again.

1. Before each decompile, the script is recorded in `EXEC_STATE.json`. The record is removed when the decompile finishes.
2. If the executor crashes, the record is still there on the next run. That script is marked as crashed.
3. The next run skips it. Its `Source` starts with `-- Skipped:` and says how to retry with `RetryCrashedScripts`, and the rest of the save carries on.

| Option | Default | Meaning |
| --- | --- | --- |
| `SkipCrashedScripts` | `true` | Turn this protection on or off. It needs `writefile`. |
| `RetryCrashedScripts` | `false` | Forget the remembered scripts and try them again. |

Closing the game in the middle of a decompile looks the same as a crash, so that script is skipped on the next run. If a script was skipped by mistake, run once with `RetryCrashedScripts = true`.

The same state file remembers which `gethiddenproperty` types crashed or failed on your executor, so those types are skipped on later runs.

## Staying safe

| Option | Default | Meaning |
| --- | --- | --- |
| `SafeMode` | `false` | Disconnects you from the game when saving starts, and turns on `KillAllScripts` and `BoostFPS` unless you set them. Highly recommended. |
| `KillAllScripts` | `false` | Kills all scripts to protect you further. `SafeMode` also turns it on. |
| `BoostFPS` | `false` | Turns off 3D rendering while saving. `SafeMode` also turns it on. |
| `Anonymous` | `false` | Risky. Removes your name and user ID from the file. |
| `IgnoreSpecialProperties` | `false` | Don't use `gethiddenproperty`. Helps if your executor crashes or the file is corrupted. |
| `SaveSpecialProperties` | `false` | Save only the special properties you list, for example `{"Color3uint8"}`. An empty list skips them all. |

`saveinstance` does not modify game state.

## Known limits

Some executors can't read every kind of hidden property. USSI Redux tests each type once, remembers the result in `EXEC_STATE.json`, and lists the types it had to skip at the top of the save.

Other executors may fail on different types. The list in the save header shows what yours skipped.

## Using the options type

`saveinstance.luau` is written for Luau's `--!strict` mode and exports a `SaveInstanceOptions` type. If you type-check your own scripts, you can use it to get autocomplete and errors for misspelled options:

```lua
local options: SaveInstanceOptions = {
	mode = "full",
	DecompileTimeout = 15,
}
```

## Where to go next

- The [API Reference](/docs/api) lists every option with its type, default and description.
- The [type page](/api/UniversalSynSaveInstance) documents the `SaveInstanceOptions` type and the `synsaveinstance` function.
- The [source on GitHub](https://github.com/andrewexec/USSI-Redux) has the entire codebase for this project.
- This project is based on [luau's UniversalSynSaveInstance](https://github.com/luau/UniversalSynSaveInstance) and the Roblox file format specifications. See the README for the full list of credits.
