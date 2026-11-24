# TO-DOs

- [x] Look into adding support for Binary Format Output (rbxl/rbxm)
- [x] Add table.clone instead {} in some cases if possible
- [x] Support for Model files:
  - [x] rbxmx (xml)
  - [x] rbxm (binary)
- [x] Implement [Luau Syntax] (important for performance!):
  - [x] Compound Operators
  - [x] Avoid using `next`, `ipairs` & `pairs`
  - [x] ~~Interpolated strings instead of concat~~ Slower
  - [ ] Type-checking (😩🙀)
  - [ ] ~~`if-then-else` expressions~~ No reason to
  - [x] Floor division

- [x] Speed things up as much as possible
  - Requires benchmarks
- [x] Support for as many [KRNL-like saveinstance Options] & [UNC]:
  - Change mode to invalid mode like "custom" if you only want to save ExtraInstances
  * [x] Decompile (! This takes priority over OPTIONS.noscripts if set !)
  * [x] DecompileIgnore
  * [x] DecompileTimeout (! This takes priority over OPTIONS.timeout if set !)
  * [x] ExtraInstances
  * [x] FilePath
  * [x] IgnoreDefaultProps
  * [x] IsolateStarterPlayer
  * [x] NilInstances
  * [x] Object (for .rbxmx files)
  * [x] RemovePlayerCharacters
  * [x] SavePlayers
  * [x] ShowStatus
    - [x] ~~Add Drawing Library support for ShowStatus~~ Can't reliably test if it's working on a tool
  * [x] IsolatePlayerGui (same as IsolateLocalPlayer)
  * [x] Callback
  * [x] CopyToClipboard/Clipboard
  * [x] Binary (rbxl/rbxm)
- [x] ~~Remove buffersize, savebuffer & so on for sake of performance by concatenating <Item> strings to total string then writing it to file (no extra steps like table.concat)~~ table.concat proved faster in the case of huge amount of concatenations
  - Test table.concat vs string ..= with a full buffer (this benchmark differs per usecase)
- [ ] Add Option to restart saveinstance from the point that it crashed on (perhaps by skipping)
- [ ] Maybe modes should do more than just determining the list of instances to save, like changing IgnoreDefaultProperties to false if mode is "full" for example
- [x] Add Lua & Luau versions instead of merged (WARNING: LUAU MIGHT BE MORE UPDATED THAN LUA VERSION, lua version exists just for the sake of old & bad tools, ask devs of your tools to support luau as its latest & greatest)
- [x] ~~Add Support for multiple Instances to be saved as a model~~ IsModel = true & ExtraInstances
- [x] ~~Force disable ParticleEmitters in case something like IgnorePropertiesOfNotScriptsOnScriptsMode is enabled (they stack in one place and create huge lag)~~ Not needed anymore it seems as empty FlipbookLayout breaks them which also results in no particles
- [ ] Be able to specify which special properties you want saved (to avoid saving all))