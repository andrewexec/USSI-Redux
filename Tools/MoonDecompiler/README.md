# MoonDecompiler

A Luau decompiler written in Luau.

```lua
local Moon = loadstring(game:HttpGet("https://raw.githubusercontent.com/andrewexec/USSI-Redux/main/Tools/MoonDecompiler/MoonDecompiler.luau"))()

print(Moon.decompile(script))
print(Moon.disassemble(script))
local chunk = Moon.parse(bytecode)
```
## What MoonDecompiler Supports

- Bytecode versions 3 to 14.
- `if` / `elseif` / `else`, `while`, `repeat ... until`, numbers and `for`, `break`, `continue`.
- Variable names from debug leftovers if they're left over.

## What DOESN'T Work

- The experimental Luau class opcodes and `CMPPROTO`.
- Anything that needs a real `goto`.