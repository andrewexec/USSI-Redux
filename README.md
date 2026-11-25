> [!IMPORTANT]
> Independent, unofficial project. Not affiliated with, endorsed by, or officially connected to Roblox Corporation. "Luau" is a trademark of Roblox Corporation.

# USSI Redux (Universal Syn Save Instance)
An archive of [github@luau's project](https://web.archive.org/web/20260426045357/https://github.com/luau/UniversalSynSaveInstance) aimed at resurrecting the `saveinstance` function from the long discontinued Synapse X.

## Loadstring - [Documentation](https://andrewexec.github.io/USSI-Redux/)
```lua
local Params = {
 RepoURL = "https://raw.githubusercontent.com/andrewexec/USSI-Redux/main/",
 SSI = "saveinstance",
}

local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
local Options = {}
synsaveinstance(Options)
```
# Universal Syn Save Instance
Or shortly USSI, a project aimed at resurrecting saveinstance function from Synapse X.<br />
Reason: Many tools fail miserably at providing a good user experience when it comes to tinkering with save instances.

> [!TIP]
> `saveinstance` does not modify game state, which helps maintain stability and compatibility. You can also enable `SafeMode` to improve compatibility and ensure more reliable saving across a wide range of experiences.

> [!CAUTION]
> **Disclaimer**
>
> This project is provided for development, debugging, archival, and research purposes within the Roblox platform. It is not intended for misuse, including violating platform rules, unauthorized access, or redistribution of content without permission.
>
> Users are responsible for ensuring their usage complies with all applicable rules, including Roblox's Terms of Use. The maintainers do not support or condone misuse of this software and are not responsible for how it is used.

# Documentation

- The [documentation site](https://andrewexec.github.io/USSI-Redux/) has a [Getting Started](https://andrewexec.github.io/USSI-Redux/docs/intro) guide and an [API reference](https://andrewexec.github.io/USSI-Redux/docs/api) that lists every option.
- [DOCS.md](DOCS.md) links to the same pages.

# Decompiling scripts

Scripts are decompiled automatically. `saveinstance` uses your executor's `decompile` and falls back to [MoonDecompiler](Tools/MoonDecompiler/README.md), a decompiler written in Luau that is downloaded from this repository the first time it is needed. The fallback is used when the executor has no `decompile`, it errors, or it returns nothing.

| Option | Default | Meaning |
| --- | --- | --- |
| `Decompiler` | `"auto"` | `"auto"`, `"executor"` (only the executor's decompiler) or `"moon"` (only MoonDecompiler) |
| `CustomDecompiler` | `false` | Your own decompiler: a function `(script, bytecode) -> string`, or a table with a `decompile` method. It is tried first, and the normal choice is used if it errors or returns nothing. |
| `BuiltinDecompilerURL` | `false` | Optional. Where MoonDecompiler is downloaded from. Leave it alone to use this repository. |

```lua
synsaveinstance({
	CustomDecompiler = function(script, bytecode)
		return decompileWithMedal(bytecode) -- return the source text
	end,
})
```

Functions MoonDecompiler can't rebuild with normal structure are saved as a loop over a program counter, or as a commented disassembly, and start with a comment saying why.

# TO-DOs

The list lives in [TODO.md](TODO.md).

# Acknowledgments
> [!IMPORTANT]
> This document is based largely on the efforts of [@Anaminus] & [@Dekkonot], authors of the [Roblox Format Specifications]. Additional
resources include:
> 
> - [Syngp Synapse X Source code 2019][Synapse X Source 2019] for base saveinstance code (extended by [@mblouka] & [@Acrillis])
> - [Moon/LorekeeperZinnia][@LorekeeperZinnia] for being the original creator of saveinstance that was used in Synapse X, Elysian and many others. As well as being an inspiration for this project.
> - [Rojo Rbx Dom Xml] for being a fallback documentation in case something wasn't clear in the [Roblox Format Specifications]
> - [Roblox File Format] for a list of redirects of old/deprecated xml properties that still use the old tag values
> - [Roblox Client Tracker] for an extended & close to full JSON Api Dump (with hidden properties & default values)
> - [Luau] for the open source bytecode format (`Bytecode.h`) that MoonDecompiler is written against

*** View source code of this file for more credits

[Documentation]: https://luau.github.io/UniversalSynSaveInstance/api/SynSaveInstance
[@Acrillis]: https://github.com/Acrillis
[@Anaminus]: https://github.com/Anaminus
[@Dekkonot]: https://github.com/Dekkonot
[@mblouka]: https://github.com/mblouka
[@LorekeeperZinnia]: https://github.com/LorekeeperZinnia
[saveinstance Options]: https://app.archbee.com/public/PREVIEW-2Jp4SDaAD4P1COFfx1p_t/PREVIEW-EtjA4sQe5zYUxIHwA6CqJ#mDB9D
[Rojo Rbx Dom Xml]: https://github.com/rojo-rbx/rbx-dom/blob/master/docs/xml.md
[Rojo Rbx Dom Binary]: https://github.com/rojo-rbx/rbx-dom/blob/master/docs/binary.md
[Luau Syntax]: https://luau-lang.org/syntax
[Luau]: https://github.com/luau-lang/luau
[Rbx-Binary-Format]: https://github.com/Dekkonot/rbx-binary-format/blob/master/src/writer.lua
[Roblox Client Tracker]: https://github.com/MaximumADHD/Roblox-Client-Tracker
[Roblox File Format]: https://github.com/MaximumADHD/Roblox-File-Format
[Roblox Format Specifications]: https://github.com/RobloxAPI/spec/
[Roblox Format Specifications Binary]: https://github.com/RobloxAPI/spec/blob/master/formats/rbxl.md
[Synapse X Source 2019]: https://github.com/Acrillis/SynapseX
[UNC]: https://github.com/unified-naming-convention/NamingStandard/commit/613c1956b801ace54ba141dfc60842a16608b54f