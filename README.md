# USSI Redux (Universal Syn Save Instance)
An archive of [github@luau's project](https://web.archive.org/web/20260426045357/https://github.com/luau/UniversalSynSaveInstance) aimed at resurrecting the `saveinstance` function from the long discontinued Synapse X.

## Loadstring - [Documentation](https://github.com/andrewexec/USSI-Redux/blob/main/DOCS.md)
```lua
local Params = {
 RepoURL = "https://raw.githubusercontent.com/andrewexec/USSI-Redux/main/",
 SSI = "saveinstance",
}

local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
local Options = {}
synsaveinstance(Options)
```
> [!TIP]
> `saveinstance` does not modify game state, which helps maintain stability and compatibility. You can also enable `SafeMode` to improve compatibility and ensure more reliable saving across a wide range of experiences.

> [!CAUTION]
> **Disclaimer**
>
> This project is provided for development, debugging, archival, and research purposes within the Roblox platform. It is not intended for misuse, including violating platform rules, unauthorized access, or redistribution of content without permission.
>
> Users are responsible for ensuring their usage complies with all applicable rules, including Roblox's Terms of Use. The maintainers do not support or condone misuse of this software and are not responsible for how it is used.
