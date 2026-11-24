"use strict";
(self.webpackChunkdocs = self.webpackChunkdocs || []).push([
  [624],
  {
    6439: (e, s, d) => {
      (d.r(s),
        d.d(s, {
          assets: () => t,
          contentTitle: () => l,
          default: () => a,
          frontMatter: () => n,
          metadata: () => c,
          toc: () => o,
        }));
      const c = JSON.parse(
        '{"id":"api","title":"API Reference","description":"Options","source":"@site/docs/api.md","sourceDirName":".","slug":"/api","permalink":"/USSI-Redux/docs/api","draft":false,"unlisted":false,"editUrl":"https://github.com/andrewexec/USSI-Redux/edit/main/docs/api.md","tags":[],"version":"current","sidebarPosition":2,"frontMatter":{"sidebar_position":2,"title":"API Reference"},"sidebar":"defaultSidebar","previous":{"title":"Getting Started","permalink":"/USSI-Redux/docs/intro"}}',
      );
      var r = d(4848),
        i = d(8453);
      const n = { sidebar_position: 2, title: "API Reference" },
        l = "API Reference",
        t = {},
        o = [
          { value: "Options", id: "options", level: 2 },
          { value: "Aliases", id: "aliases", level: 2 },
          { value: "Inverted aliases", id: "inverted-aliases", level: 2 },
        ];
      function h(e) {
        const s = {
          code: "code",
          h1: "h1",
          h2: "h2",
          header: "header",
          p: "p",
          strong: "strong",
          table: "table",
          tbody: "tbody",
          td: "td",
          th: "th",
          thead: "thead",
          tr: "tr",
          ...(0, i.R)(),
          ...e.components,
        };
        return (0, r.jsxs)(r.Fragment, {
          children: [
            (0, r.jsx)(s.header, {
              children: (0, r.jsx)(s.h1, {
                id: "api-reference",
                children: "API Reference",
              }),
            }),
            "\n",
            (0, r.jsx)(s.h2, { id: "options", children: "Options" }),
            "\n",
            (0, r.jsxs)(s.p, {
              children: [
                "Every option is optional. Pass them in one table: ",
                (0, r.jsx)(s.code, {
                  children: 'synsaveinstance({ mode = "full" })',
                }),
                ". Option names are not case-sensitive: ",
                (0, r.jsx)(s.code, { children: "NilInstances" }),
                ", ",
                (0, r.jsx)(s.code, { children: "nilinstances" }),
                ", and ",
                (0, r.jsx)(s.code, { children: "nilInStaNces" }),
                " are the same option. Unknown names are ignored.",
              ],
            }),
            "\n",
            (0, r.jsxs)(s.table, {
              children: [
                (0, r.jsx)(s.thead, {
                  children: (0, r.jsxs)(s.tr, {
                    children: [
                      (0, r.jsx)(s.th, { children: "Option" }),
                      (0, r.jsx)(s.th, { children: "Type" }),
                      (0, r.jsx)(s.th, { children: "Default" }),
                      (0, r.jsx)(s.th, { children: "Description" }),
                    ],
                  }),
                }),
                (0, r.jsxs)(s.tbody, {
                  children: [
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "mode" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "string" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "optimized",
                          }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "What to save. ",
                            (0, r.jsx)(s.code, { children: "optimized" }),
                            " saves the most important services (Workspace, Players, Lighting, ReplicatedStorage, StarterGui, and others). ",
                            (0, r.jsx)(s.code, { children: "full" }),
                            " saves everything under ",
                            (0, r.jsx)(s.code, { children: "game" }),
                            " and also turns ",
                            (0, r.jsx)(s.code, {
                              children: "IgnoreDefaultProperties",
                            }),
                            " off, unless you set it yourself. ",
                            (0, r.jsx)(s.code, { children: "scripts" }),
                            " saves only the objects that are, or contain, a [LuaSourceContainer] (a script object), along with the path of parents that lead to them. Objects that don't lead to a script are left out. Any other value saves only ",
                            (0, r.jsx)(s.code, { children: "ExtraInstances" }),
                            " (and ",
                            (0, r.jsx)(s.code, { children: "Object" }),
                            ", if set). If ",
                            (0, r.jsx)(s.code, { children: "Object" }),
                            " is set, ",
                            (0, r.jsx)(s.code, { children: "optimized" }),
                            " becomes ",
                            (0, r.jsx)(s.code, { children: "full" }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Binary" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Save a binary file (",
                            (0, r.jsx)(s.code, { children: ".rbxl" }),
                            "/",
                            (0, r.jsx)(s.code, { children: ".rbxm" }),
                            ") instead of an XML file (",
                            (0, r.jsx)(s.code, { children: ".rbxlx" }),
                            "/",
                            (0, r.jsx)(s.code, { children: ".rbxmx" }),
                            "). Binary files are smaller and load faster. If the executor cannot write binary data correctly, the script uses XML. Set the old option ",
                            (0, r.jsx)(s.code, { children: "XML = true" }),
                            " to force XML.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "CompressionMode",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "string | boolean",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: '"zstd"' }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "How to compress (make smaller) the binary file: ",
                            (0, r.jsx)(s.code, { children: '"zstd"' }),
                            ", ",
                            (0, r.jsx)(s.code, { children: '"lz4"' }),
                            ", or ",
                            (0, r.jsx)(s.code, { children: "false" }),
                            " for no compression. ",
                            (0, r.jsx)(s.code, { children: "true" }),
                            " means ",
                            (0, r.jsx)(s.code, { children: '"zstd"' }),
                            ". The old option ",
                            (0, r.jsx)(s.code, {
                              children: "DisableCompression = true",
                            }),
                            " means ",
                            (0, r.jsx)(s.code, { children: "false" }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "CompressionLevel",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "number" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "9" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children:
                            "Compression level for zstd, from -7 to 22. A higher level makes a smaller file but takes longer. This is ignored for lz4 and when compression is off.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "FilePath",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "string | false",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "File name to save to. You can include a folder. If the name has no extension, the script adds one based on ",
                            (0, r.jsx)(s.code, { children: "Binary" }),
                            " and ",
                            (0, r.jsx)(s.code, { children: "IsModel" }),
                            ". If you set this, the script overwrites an existing file and ignores ",
                            (0, r.jsx)(s.code, {
                              children: "AvoidFileOverwrite",
                            }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SafeMode",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Disconnect the LocalPlayer from the game when saving starts. This turns on ",
                            (0, r.jsx)(s.code, { children: "KillAllScripts" }),
                            " and ",
                            (0, r.jsx)(s.code, { children: "BoostFPS" }),
                            " unless you set them yourself. ",
                            (0, r.jsx)(s.strong, {
                              children: "HIGHLY RECOMMENDED.",
                            }),
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "KillAllScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Close or disable other running scripts before saving. ",
                            (0, r.jsx)(s.code, { children: "SafeMode" }),
                            " turns this on. Some games stop responding to input after this. That is normal. ",
                            (0, r.jsx)(s.strong, {
                              children: "HIGHLY RECOMMENDED.",
                            }),
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "BoostFPS",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Turn off 3D rendering while saving, then turn it back on. ",
                            (0, r.jsx)(s.code, { children: "SafeMode" }),
                            " turns this on.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Object" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Instance | false",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Save this [Instance] instead of the whole place. The script saves a model if you do not set ",
                            (0, r.jsx)(s.code, { children: "IsModel = false" }),
                            ". If you pass ",
                            (0, r.jsx)(s.code, { children: "game" }),
                            ", it saves the place and uses ",
                            (0, r.jsx)(s.code, { children: "full" }),
                            " mode. You must pass an [Instance], not a name.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "IsModel" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Save a model (",
                            (0, r.jsx)(s.code, { children: ".rbxm" }),
                            "/",
                            (0, r.jsx)(s.code, { children: ".rbxmx" }),
                            ") instead of a place (",
                            (0, r.jsx)(s.code, { children: ".rbxl" }),
                            "/",
                            (0, r.jsx)(s.code, { children: ".rbxlx" }),
                            "). ",
                            (0, r.jsx)(s.code, { children: "Object" }),
                            " turns this on unless you set it yourself. Passing a list of Instances as an argument also turns it on.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ShowStatus",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children:
                            "Show a status label on the screen. It shows the size while saving, then the final size and time.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "ReadMe" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children:
                            "Add a README script to the save. It contains save details (place ID, date, time, platform, executor, recovered scripts, warnings) and tips.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Turn the compiled script back into source code (decompile). This replaces the ",
                            (0, r.jsx)(s.code, { children: "Source" }),
                            " of each [LuaSourceContainer] with decompiled code. If this is off, ",
                            (0, r.jsx)(s.code, { children: "Source" }),
                            " says decompiling is disabled.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveBytecode",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "If the executor supports ",
                            (0, r.jsx)(s.code, {
                              children: "getscriptbytecode",
                            }),
                            ", add the compiled script data (bytecode) to ",
                            (0, r.jsx)(s.code, { children: "Source" }),
                            " as a comment. You can decompile it later. This respects ",
                            (0, r.jsx)(s.code, { children: "DecompileIgnore" }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DecompileTimeout",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "number" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "10" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "How many seconds one decompile call can take. If it takes longer, the script stops waiting and writes a timeout message in ",
                            (0, r.jsx)(s.code, { children: "Source" }),
                            ". Set to -1 to disable the timeout.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DecompileThreads",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "number" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "1" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "How many scripts to decompile at the same time before saving. 1 decompiles one by one while saving. Higher values only help if your executor's ",
                            (0, r.jsx)(s.code, { children: "decompile" }),
                            " yields, and need ",
                            (0, r.jsx)(s.code, { children: "scriptcache" }),
                            " and ",
                            (0, r.jsx)(s.code, {
                              children: "getscriptbytecode",
                            }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompiler",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "string" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: '"auto"' }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Which decompiler turns scripts back into source. ",
                            (0, r.jsx)(s.code, { children: '"auto"' }),
                            " uses the executor's ",
                            (0, r.jsx)(s.code, { children: "decompile" }),
                            ", and uses MoonDecompiler (a LuaU decompiler downloaded from ",
                            (0, r.jsx)(s.code, {
                              children: "BuiltinDecompilerURL",
                            }),
                            ") when the executor has none or it fails. ",
                            (0, r.jsx)(s.code, { children: '"executor"' }),
                            " only uses the executor's ",
                            (0, r.jsx)(s.code, { children: "decompile" }),
                            ". ",
                            (0, r.jsx)(s.code, { children: '"moon"' }),
                            " only uses MoonDecompiler.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "CustomDecompiler",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "((script: Instance, bytecode: string?) -> string) | {decompile: (script: Instance, bytecode: string?) -> string} | false",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children:
                            "Your own decompiler, that can replace the default decompile function with a custom one.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "BuiltinDecompilerURL",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "string | false",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Optional. Where MoonDecompiler is downloaded from when it is needed. Leave it false and the USSI-Redux repository is used automatically (the ",
                            (0, r.jsx)(s.code, { children: "main" }),
                            " branch first, then ",
                            (0, r.jsx)(s.code, { children: "experimental" }),
                            ").",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "BytecodeTimeout",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "number" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "3" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "How many seconds a ",
                            (0, r.jsx)(s.code, {
                              children: "getscriptbytecode",
                            }),
                            " call can take. If it takes longer, the script stops waiting and skips the bytecode for that script. Set to -1 to disable the timeout.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DecompileIgnore",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "{Instance | string} | {[Instance | string]: boolean | {[string]: boolean}}",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "{TextChatService}",
                          }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Skip decompiling matched [Instance]s and their children. ",
                            (0, r.jsx)(s.code, { children: "Source" }),
                            " becomes a short ignored message. You can pass an [Instance], a class name, or ",
                            (0, r.jsx)(s.code, {
                              children: "ClassName = {Name1, Name2}",
                            }),
                            ". Set an [Instance] to ",
                            (0, r.jsx)(s.code, { children: "false" }),
                            " to skip only that instance, not its children.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SourceCache",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "{[Instance]: string} | false",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children:
                            "Source text to use for these scripts as-is instead of decompiling them.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DecompileJobless",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Only use scripts that are already in the decompile cache. Missing scripts get a short not-found message. This turns on ",
                            (0, r.jsx)(s.code, { children: "scriptcache" }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SkipCrashedScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Remember which script was being decompiled. If the executor crashed or the game closed mid-decompile, the next run skips that script (its ",
                            (0, r.jsx)(s.code, { children: "Source" }),
                            " says so) instead of crashing again, so rerunning the save gets past the crash point. The list is kept in ",
                            (0, r.jsx)(s.code, { children: "EXEC_STATE.json" }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "RetryCrashedScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Forget the scripts remembered by ",
                            (0, r.jsx)(s.code, {
                              children: "SkipCrashedScripts",
                            }),
                            " and try to decompile them again. Use this if a script was skipped by mistake, for example when you closed the game during a save.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "scriptcache",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "If the executor supports ",
                            (0, r.jsx)(s.code, {
                              children: "getscriptbytecode",
                            }),
                            ", cache decompiled code. This avoids decompiling the same script twice. The cache stays after the script reloads.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "RecoverScriptsFromAssets",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Recover the original ",
                            (0, r.jsx)(s.code, { children: "Source" }),
                            " of scripts that were published as assets. Changes made after publishing are not included.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolatePlayers",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Put every [Player] under a top-level ",
                            (0, r.jsx)(s.code, { children: '"Players"' }),
                            " Folder instead of inside the [Players] service. This turns on ",
                            (0, r.jsx)(s.code, {
                              children: "SaveNotCreatable",
                            }),
                            ". If both are on, this option is used instead of ",
                            (0, r.jsx)(s.code, {
                              children: "IsolateLocalPlayer",
                            }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolateLocalPlayer",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Save the LocalPlayer as a Folder named ",
                            (0, r.jsx)(s.code, { children: '"LocalPlayer"' }),
                            " instead of a [Player] object. This is ignored if ",
                            (0, r.jsx)(s.code, { children: "IsolatePlayers" }),
                            " is on.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolateLocalPlayerCharacter",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Save LocalPlayer.Character as a [Model] named ",
                            (0, r.jsx)(s.code, {
                              children: '"LocalPlayer Character"',
                            }),
                            ". This saves the character even when characters are normally skipped.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolateStarterPlayer",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Put [StarterPlayer]'s children under a top-level ",
                            (0, r.jsx)(s.code, { children: '"StarterPlayer"' }),
                            " Folder. The original service stays, but it is empty.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SavePlayerCharacters",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Save player characters instead of skipping them. This also saves objects with ",
                            (0, r.jsx)(s.code, {
                              children: "Archivable = false",
                            }),
                            ", so ",
                            (0, r.jsx)(s.code, {
                              children: "IgnoreNotArchivable",
                            }),
                            " is forced on.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "NilInstances",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Include objects that have no parent (they are not under ",
                            (0, r.jsx)(s.code, { children: "game" }),
                            "). This needs the executor function ",
                            (0, r.jsx)(s.code, { children: "getnilinstances" }),
                            ". When that function exists, it also turns on ",
                            (0, r.jsx)(s.code, {
                              children: "SaveNotCreatable",
                            }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ExtraInstances",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "{Instance}",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "{}" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "A list of [Instance]s to add to the normal save. If ",
                            (0, r.jsx)(s.code, { children: "mode" }),
                            " is not a valid value, only these Instances (and ",
                            (0, r.jsx)(s.code, { children: "Object" }),
                            ", if set) are saved. Passing a list of Instances as an argument fills this list.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreList",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "{Instance | string} | {[Instance | string]: boolean | {[string]: boolean}}",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "{CoreGui, CorePackages, Packages = false}",
                          }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Objects to skip. Use an [Instance] or a class name as a key to skip that object and its children. ",
                            (0, r.jsx)(s.code, {
                              children: "ClassName = false",
                            }),
                            " keeps the object but skips its children. ",
                            (0, r.jsx)(s.code, {
                              children: "ClassName = {Name1, Name2}",
                            }),
                            " skips objects with those names. You can also pass a list of Instances or class names.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "MaxDepth",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "number" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "1000" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Objects nested deeper than this are moved up under their ancestor at depth ",
                            (0, r.jsx)(s.code, { children: "MaxDepth" }),
                            ", so nothing is dropped, only the nesting is lost. This stops very deep hierarchies from overflowing the stack when Roblox Studio opens the file (binary saves opened at 1740 levels deep; XML saves crashed at 1750). Use ",
                            (0, r.jsx)(s.code, { children: "math.huge" }),
                            " to disable.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreSpecialProperties",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Do not use the executor function ",
                            (0, r.jsx)(s.code, {
                              children: "gethiddenproperty",
                            }),
                            ". Other property reads still work. This can help if your executor crashes or the file is corrupted.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "AlternativeWritefile",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Write the file in smaller pieces with ",
                            (0, r.jsx)(s.code, { children: "appendfile" }),
                            " instead of one ",
                            (0, r.jsx)(s.code, { children: "writefile" }),
                            " call. For binary saves, if ",
                            (0, r.jsx)(s.code, { children: "appendfile" }),
                            " fails, it uses ",
                            (0, r.jsx)(s.code, { children: "writefile" }),
                            "; if both fail, it switches to XML.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Anonymous",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "boolean | {Name: string?, UserId: number?}",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            (0, r.jsx)(s.strong, { children: "RISKY:" }),
                            " Replace LocalPlayer.Name and UserId in the output. ",
                            (0, r.jsx)(s.code, { children: "true" }),
                            " replaces them with ",
                            (0, r.jsx)(s.code, { children: '"Roblox"' }),
                            " and ",
                            (0, r.jsx)(s.code, { children: "1" }),
                            ". You can also pass a table with ",
                            (0, r.jsx)(s.code, { children: "Name" }),
                            " and/or ",
                            (0, r.jsx)(s.code, { children: "UserId" }),
                            ". Name matching ignores case. This can also change other text or numbers that match.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "RiskyServicesDisabled",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "{UGC: boolean?, Encoding: boolean?, Reflection: boolean?}",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "{UGC = true, Encoding = false, Reflection = false}",
                          }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Turn off services that some games may detect. ",
                            (0, r.jsx)(s.code, { children: "UGC" }),
                            " skips [UGCValidationService] (used for some hidden properties). ",
                            (0, r.jsx)(s.code, { children: "Encoding" }),
                            " skips [EncodingService]. ",
                            (0, r.jsx)(s.code, { children: "Reflection" }),
                            " skips [ReflectionService] (used for class data). Set a flag to ",
                            (0, r.jsx)(s.code, { children: "true" }),
                            " to skip that service. If you do not set ",
                            (0, r.jsx)(s.code, {
                              children: "RiskyServicesDisabled",
                            }),
                            " yourself, the UGC fallback turns on automatically when ",
                            (0, r.jsx)(s.code, {
                              children: "gethiddenproperty",
                            }),
                            " is missing.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "AvoidFileOverwrite",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "If ",
                            (0, r.jsx)(s.code, { children: "FilePath" }),
                            " is not set, add (1), (2), ... to the file name instead of overwriting an existing file.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "AntiIdle",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children:
                            "Stop Roblox from kicking you for being idle (not moving) for 20 minutes.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "CopyToClipboard",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Copy the result to the clipboard (the copy/paste buffer) instead of writing a file. Your executor must support ",
                            (0, r.jsx)(s.code, { children: "setrbxclipboard" }),
                            ". Use this only for small saves.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Callback",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "((data: string, chunks: {string}) -> ()) | false",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Call this function with the result instead of writing a file. It receives the full text and a list of chunks. If ",
                            (0, r.jsx)(s.code, { children: "CopyToClipboard" }),
                            " is also on, the clipboard is used instead.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreProperties",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "{string}",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "{}" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "A list of property names to skip on every object. For example: ",
                            (0, r.jsx)(s.code, {
                              children: '{"Tags", "AttributesSerialize"}',
                            }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreNotArchivable",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Save objects even when their ",
                            (0, r.jsx)(s.code, { children: "Archivable" }),
                            " property is ",
                            (0, r.jsx)(s.code, { children: "false" }),
                            ". If this is off, the script skips those objects.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveNotCreatable",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Save classes that Roblox says are not creatable. The script replaces them with a class it can create, using ",
                            (0, r.jsx)(s.code, {
                              children: "NotCreatableFixes",
                            }),
                            " (usually ",
                            (0, r.jsx)(s.code, { children: "Folder" }),
                            "). This turns on automatically with ",
                            (0, r.jsx)(s.code, { children: "IsolatePlayers" }),
                            ", ",
                            (0, r.jsx)(s.code, {
                              children: "IsolateLocalPlayer",
                            }),
                            ", and ",
                            (0, r.jsx)(s.code, { children: "NilInstances" }),
                            " (when ",
                            (0, r.jsx)(s.code, { children: "getnilinstances" }),
                            " exists).",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "NotCreatableFixes",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "{string} | {[string]: string | false}",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "built-in replacements",
                          }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Replace a class with a class that can be created. The default replacement is ",
                            (0, r.jsx)(s.code, { children: '"Folder"' }),
                            ". A list of class names also becomes ",
                            (0, r.jsx)(s.code, { children: "Folder" }),
                            ". Built-in changes: [Player], [PlayerGui], [PlayerScripts], [TouchTransmitter], and others become ",
                            (0, r.jsx)(s.code, { children: "Folder" }),
                            "; [CloudLocalizationTable] becomes [LocalizationTable]; ",
                            (0, r.jsx)(s.code, { children: "Platform" }),
                            " becomes [Part]; ",
                            (0, r.jsx)(s.code, { children: "Status" }),
                            " becomes [Model]. Set a class to ",
                            (0, r.jsx)(s.code, { children: "false" }),
                            " to skip its replacement.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "NilInstancesFixes",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "{[string]: ((instance: Instance, overrides: table) -> Instance?) | false}",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "built-in Animator/AdPortal/Attachment/BaseWrap/PackageLink fixes",
                          }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Where to put objects that have no parent. For example, it puts [Animator] under an [AnimationController]. Built-in fixes exist for [Animator], [AdPortal], [Attachment], [BaseWrap], [PackageLink], [DebuggerWatch], and [PluginAction] (the last two have no valid parent, so they are skipped). Child classes use the parent fix ([Bone]s use the Attachment fix). Set a class to ",
                            (0, r.jsx)(s.code, { children: "false" }),
                            " to turn off its fix.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreDefaultProperties",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "true" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children:
                            "Skip properties that already have the default value for their class. This only affects XML output. Binary output does not use this option.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children:
                              "IgnorePropertiesOfNotScriptsOnScriptsMode",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Only in ",
                            (0, r.jsx)(s.code, { children: "scripts" }),
                            " mode: save properties for [LuaSourceContainer]s and skip properties for all other objects. This does nothing in other modes.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreDefaultPlayerScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Skip Roblox's default player scripts (",
                            (0, r.jsx)(s.code, { children: "PlayerModule" }),
                            ", ",
                            (0, r.jsx)(s.code, { children: "BubbleChat" }),
                            ", ",
                            (0, r.jsx)(s.code, { children: "ChatScript" }),
                            ", ",
                            (0, r.jsx)(s.code, {
                              children: "PlayerScriptsLoader",
                            }),
                            ", ",
                            (0, r.jsx)(s.code, {
                              children: "RbxCharacterSounds",
                            }),
                            "). This can stop some executors from crashing during decompile.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveCacheInterval",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "number" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "0x1600 * 10",
                          }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "How much XML data the script holds in memory while saving. Lower values update the status more often but are slower. This does not write to disk. When ",
                            (0, r.jsx)(s.code, { children: "KillAllScripts" }),
                            " is on, this also sets the script timeout between 20 and 30 seconds.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SharedBinaryStrings",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children:
                            "Store the same binary data (meshes, images, ...) only once in the file. This makes saves with repeated data smaller. Files with all unique data can get slightly bigger. This is not an official Roblox format, but Studio can still open the file.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "TreatUnionsAsParts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Change all [PartOperation]s (unions and intersections) into [Part]s. ",
                            (0, r.jsx)(s.strong, { children: "RISKY:" }),
                            " you lose the merged shape, but executors that cannot read unions will still show visible parts.",
                          ],
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ShutdownWhenDone",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "boolean" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: "Close the game after a successful save.",
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "__DEBUG_MODE",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "boolean | ((...any) -> ())",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "false" }),
                        }),
                        (0, r.jsxs)(s.td, {
                          children: [
                            "Print debug warnings for unusual cases. If you pass a function, the script uses it instead of ",
                            (0, r.jsx)(s.code, { children: "warn" }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                  ],
                }),
              ],
            }),
            "\n",
            (0, r.jsx)(s.h2, { id: "aliases", children: "Aliases" }),
            "\n",
            (0, r.jsx)(s.p, {
              children:
                "Old option names that still work. Each one sets the option shown beside it.",
            }),
            "\n",
            (0, r.jsxs)(s.table, {
              children: [
                (0, r.jsx)(s.thead, {
                  children: (0, r.jsxs)(s.tr, {
                    children: [
                      (0, r.jsx)(s.th, { children: "Alias" }),
                      (0, r.jsx)(s.th, { children: "Option" }),
                    ],
                  }),
                }),
                (0, r.jsxs)(s.tbody, {
                  children: [
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "AnonymousMode",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Anonymous",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Blacklist",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreList",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ClassIgnoreList",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreList",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Clipboard",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "CopyToClipboard",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Compress",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "CompressionMode",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Compression",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "CompressionMode",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Debug" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "__DEBUG_MODE",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DecompileScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompiler",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DecompilerTimeout",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DecompileTimeout",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "EmbedBytecode",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveBytecode",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "FileName",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "FilePath",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreArchivable",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreNotArchivable",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreClasses",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreList",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreDefaultProps",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreDefaultProperties",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreInstances",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreList",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreProperty",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreProperties",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreRobloxPlayerScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreDefaultPlayerScripts",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "InstanceIgnoreList",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreList",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "InstancesBlacklist",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IgnoreList",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolatePlayerGui",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolateLocalPlayer",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "LocalPlayer",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolateLocalPlayer",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Model" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Object" }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "NoXML" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Binary" }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Path" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "FilePath",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Players" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolatePlayers",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Progress",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ShowStatus",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Root" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Object" }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveAsBinary",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Binary" }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveCharacters",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SavePlayerCharacters",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveLocalPlayer",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolateLocalPlayer",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveModel",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Object" }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "SaveNil" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "NilInstances",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveNilInstances",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "NilInstances",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveNonCreatable",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveNotCreatable",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SavePlayerGui",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolateLocalPlayer",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SavePlayers",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolatePlayers",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SavePlayersData",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolatePlayers",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SaveStarterPlayer",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolateStarterPlayer",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ScriptDecompile",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ShowProgress",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ShowStatus",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Status" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ShowStatus",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "StatusText",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "ShowStatus",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "UseDecompiler",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Verbose" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "__DEBUG_MODE",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "timeout" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DecompileTimeout",
                          }),
                        }),
                      ],
                    }),
                  ],
                }),
              ],
            }),
            "\n",
            (0, r.jsx)(s.h2, {
              id: "inverted-aliases",
              children: "Inverted aliases",
            }),
            "\n",
            (0, r.jsxs)(s.p, {
              children: [
                "Old option names that set the option shown beside them to the opposite value. For example ",
                (0, r.jsx)(s.code, { children: "noscripts = true" }),
                " sets ",
                (0, r.jsx)(s.code, { children: "Decompile = false" }),
                ".",
              ],
            }),
            "\n",
            (0, r.jsxs)(s.table, {
              children: [
                (0, r.jsx)(s.thead, {
                  children: (0, r.jsxs)(s.tr, {
                    children: [
                      (0, r.jsx)(s.th, { children: "Alias" }),
                      (0, r.jsx)(s.th, { children: "Option" }),
                    ],
                  }),
                }),
                (0, r.jsxs)(s.tbody, {
                  children: [
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "DisableCompression",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "CompressionMode",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "NoDecompile",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "noscripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "NullifyScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Overwrite",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "AvoidFileOverwrite",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "RemovePlayerCharacters",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SavePlayerCharacters",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "RemovePlayers",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "IsolatePlayers",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "SkipScripts",
                          }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                      ],
                    }),
                    (0, r.jsxs)(s.tr, {
                      children: [
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "XML" }),
                        }),
                        (0, r.jsx)(s.td, {
                          children: (0, r.jsx)(s.code, { children: "Binary" }),
                        }),
                      ],
                    }),
                  ],
                }),
              ],
            }),
          ],
        });
      }
      function a(e = {}) {
        const { wrapper: s } = { ...(0, i.R)(), ...e.components };
        return s
          ? (0, r.jsx)(s, { ...e, children: (0, r.jsx)(h, { ...e }) })
          : h(e);
      }
    },
    8453: (e, s, d) => {
      d.d(s, { R: () => n, x: () => l });
      var c = d(6540);
      const r = {},
        i = c.createContext(r);
      function n(e) {
        const s = c.useContext(i);
        return c.useMemo(
          function () {
            return "function" == typeof e ? e(s) : { ...s, ...e };
          },
          [s, e],
        );
      }
      function l(e) {
        let s;
        return (
          (s = e.disableParentContext
            ? "function" == typeof e.components
              ? e.components(r)
              : e.components || r
            : n(e.components)),
          c.createElement(i.Provider, { value: s }, e.children)
        );
      }
    },
  },
]);
