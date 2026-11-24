"use strict";
(self.webpackChunkdocs = self.webpackChunkdocs || []).push([
  [976],
  {
    2053: (e, s, n) => {
      (n.r(s),
        n.d(s, {
          assets: () => o,
          contentTitle: () => c,
          default: () => a,
          frontMatter: () => r,
          metadata: () => t,
          toc: () => l,
        }));
      const t = JSON.parse(
        '{"id":"intro","title":"Getting Started","description":"USSI Redux is a saveinstance for Roblox executors, written in Luau. It revives the saveinstance function from Synapse X and can also be edited and used as a Roblox-format-file writer.","source":"@site/docs/intro.md","sourceDirName":".","slug":"/intro","permalink":"/USSI-Redux/docs/intro","draft":false,"unlisted":false,"editUrl":"https://github.com/andrewexec/USSI-Redux/edit/main/docs/intro.md","tags":[],"version":"current","sidebarPosition":1,"frontMatter":{"sidebar_position":1,"title":"Getting Started"},"sidebar":"defaultSidebar","next":{"title":"API Reference","permalink":"/USSI-Redux/docs/api"}}',
      );
      var i = n(4848),
        d = n(8453);
      const r = { sidebar_position: 1, title: "Getting Started" },
        c = "Getting Started",
        o = {},
        l = [
          { value: "Load it", id: "load-it", level: 2 },
          { value: "Output", id: "output", level: 2 },
          { value: "Modes", id: "modes", level: 2 },
          { value: "Decompiling scripts", id: "decompiling-scripts", level: 2 },
          {
            value: "Recovering from a crash",
            id: "recovering-from-a-crash",
            level: 2,
          },
          { value: "Staying safe", id: "staying-safe", level: 2 },
          {
            value: "Using the options type",
            id: "using-the-options-type",
            level: 2,
          },
          { value: "Where to go next", id: "where-to-go-next", level: 2 },
        ];
      function h(e) {
        const s = {
          a: "a",
          admonition: "admonition",
          code: "code",
          h1: "h1",
          h2: "h2",
          header: "header",
          li: "li",
          ol: "ol",
          p: "p",
          pre: "pre",
          table: "table",
          tbody: "tbody",
          td: "td",
          th: "th",
          thead: "thead",
          tr: "tr",
          ul: "ul",
          ...(0, d.R)(),
          ...e.components,
        };
        return (0, i.jsxs)(i.Fragment, {
          children: [
            (0, i.jsx)(s.header, {
              children: (0, i.jsx)(s.h1, {
                id: "getting-started",
                children: "Getting Started",
              }),
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                "USSI Redux is a ",
                (0, i.jsx)(s.code, { children: "saveinstance" }),
                " for Roblox executors, written in Luau. It revives the ",
                (0, i.jsx)(s.code, { children: "saveinstance" }),
                " function from Synapse X and can also be edited and used as a Roblox-format-file writer.",
              ],
            }),
            "\n",
            (0, i.jsxs)(s.admonition, {
              title: "Disclaimer",
              type: "caution",
              children: [
                (0, i.jsx)(s.p, {
                  children:
                    "This project is provided for development, debugging, archival and research purposes within the Roblox platform. It is not intended for misuse, including violating platform rules, unauthorized access, or redistribution of content without permission. You are responsible for following Roblox's Terms of Use.",
                }),
                (0, i.jsx)(s.p, {
                  children:
                    "This is an independent, unofficial project. It is not affiliated with, endorsed by, or officially connected to Roblox Corporation.",
                }),
              ],
            }),
            "\n",
            (0, i.jsx)(s.h2, { id: "load-it", children: "Load it" }),
            "\n",
            (0, i.jsx)(s.pre, {
              children: (0, i.jsx)(s.code, {
                className: "language-lua",
                children:
                  'local Params = {\n\tRepoURL = "https://raw.githubusercontent.com/andrewexec/USSI-Redux/main/",\n\tSSI = "saveinstance",\n}\n\nlocal synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()\n\nsynsaveinstance({}) -- saves with the default options\n',
              }),
            }),
            "\n",
            (0, i.jsx)(s.p, {
              children:
                "Pass a table of options to change what is saved and how:",
            }),
            "\n",
            (0, i.jsx)(s.pre, {
              children: (0, i.jsx)(s.code, {
                className: "language-lua",
                children:
                  'synsaveinstance({\n\tmode = "full",\n\tSafeMode = true,\n\tDecompileTimeout = 15,\n})\n',
              }),
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                "Option names are not case-sensitive, and many have aliases. Every option is listed on the ",
                (0, i.jsx)(s.a, {
                  href: "/docs/api",
                  children: "API Reference",
                }),
                " page, and the generated ",
                (0, i.jsx)(s.a, {
                  href: "/api/UniversalSynSaveInstance",
                  children: "type page",
                }),
                " documents the ",
                (0, i.jsx)(s.code, { children: "SaveInstanceOptions" }),
                " type.",
              ],
            }),
            "\n",
            (0, i.jsx)(s.h2, { id: "output", children: "Output" }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                "By default the save is a binary place file (",
                (0, i.jsx)(s.code, { children: ".rbxl" }),
                ", or ",
                (0, i.jsx)(s.code, { children: ".rbxm" }),
                " for a model). It is much smaller and faster to load than XML. Set ",
                (0, i.jsx)(s.code, { children: "XML = true" }),
                " for ",
                (0, i.jsx)(s.code, { children: ".rbxlx" }),
                " / ",
                (0, i.jsx)(s.code, { children: ".rbxmx" }),
                ".",
              ],
            }),
            "\n",
            (0, i.jsxs)(s.table, {
              children: [
                (0, i.jsx)(s.thead, {
                  children: (0, i.jsxs)(s.tr, {
                    children: [
                      (0, i.jsx)(s.th, { children: "Option" }),
                      (0, i.jsx)(s.th, { children: "Default" }),
                      (0, i.jsx)(s.th, { children: "Meaning" }),
                    ],
                  }),
                }),
                (0, i.jsxs)(s.tbody, {
                  children: [
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "Binary" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "true" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: "Save as binary instead of XML.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "CompressionMode",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: '"zstd"' }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "How binary chunks are compressed: ",
                            (0, i.jsx)(s.code, { children: '"zstd"' }),
                            ", ",
                            (0, i.jsx)(s.code, { children: '"lz4"' }),
                            " or ",
                            (0, i.jsx)(s.code, { children: "false" }),
                            " for none.",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "CompressionLevel",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "9" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "Compression strength from -7 to 22. Higher is smaller but slower.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "Callback",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "Send the data to a function instead of writing a file.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "CopyToClipboard",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "Put the output on the clipboard. Only suits small saves.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "MaxDepth",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "1000" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "Objects nested deeper than this are moved up under their ancestor at that depth, so nothing is dropped. This stops very deep hierarchies from overflowing the stack when Roblox Studio opens the file.",
                        }),
                      ],
                    }),
                  ],
                }),
              ],
            }),
            "\n",
            (0, i.jsx)(s.h2, { id: "modes", children: "Modes" }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                (0, i.jsx)(s.code, { children: "mode" }),
                " chooses what gets saved.",
              ],
            }),
            "\n",
            (0, i.jsxs)(s.table, {
              children: [
                (0, i.jsx)(s.thead, {
                  children: (0, i.jsxs)(s.tr, {
                    children: [
                      (0, i.jsx)(s.th, { children: "Mode" }),
                      (0, i.jsx)(s.th, { children: "What it saves" }),
                    ],
                  }),
                }),
                (0, i.jsxs)(s.tbody, {
                  children: [
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsxs)(s.td, {
                          children: [
                            (0, i.jsx)(s.code, { children: '"optimized"' }),
                            " (default)",
                          ],
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "The most important services: Workspace, Players, Lighting, ReplicatedStorage, StarterGui and others.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: '"full"' }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Everything under ",
                            (0, i.jsx)(s.code, { children: "game" }),
                            ". It also sets ",
                            (0, i.jsx)(s.code, {
                              children: "IgnoreDefaultProperties",
                            }),
                            " to ",
                            (0, i.jsx)(s.code, { children: "false" }),
                            ", unless you set that option yourself.",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: '"scripts"',
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "Only the objects that are, or contain, a script, plus the parents that lead to them.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, { children: "any other value" }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Only ",
                            (0, i.jsx)(s.code, { children: "ExtraInstances" }),
                            " (and ",
                            (0, i.jsx)(s.code, { children: "Object" }),
                            ", if set).",
                          ],
                        }),
                      ],
                    }),
                  ],
                }),
              ],
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                "If you set ",
                (0, i.jsx)(s.code, { children: "Object" }),
                ", ",
                (0, i.jsx)(s.code, { children: '"optimized"' }),
                " becomes ",
                (0, i.jsx)(s.code, { children: '"full"' }),
                ". Saving ",
                (0, i.jsx)(s.code, { children: "game" }),
                " as the ",
                (0, i.jsx)(s.code, { children: "Object" }),
                " is the same as ",
                (0, i.jsx)(s.code, { children: '"full"' }),
                ".",
              ],
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                (0, i.jsx)(s.code, { children: "IgnoreDefaultProperties" }),
                " only affects XML output. Binary saves do not use it.",
              ],
            }),
            "\n",
            (0, i.jsx)(s.pre, {
              children: (0, i.jsx)(s.code, {
                className: "language-lua",
                children:
                  '-- keep every property\nsynsaveinstance({ mode = "full" })\n\n-- "full" mode, but still skip default values\nsynsaveinstance({ mode = "full", IgnoreDefaultProperties = true })\n',
              }),
            }),
            "\n",
            (0, i.jsx)(s.h2, {
              id: "decompiling-scripts",
              children: "Decompiling scripts",
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                "Scripts are decompiled automatically. ",
                (0, i.jsx)(s.code, { children: "saveinstance" }),
                " uses your executor's ",
                (0, i.jsx)(s.code, { children: "decompile" }),
                ", and falls back to ",
                (0, i.jsx)(s.a, {
                  href: "https://github.com/andrewexec/USSI-Redux/blob/main/Tools/MoonDecompiler/README.md",
                  children: "MoonDecompiler",
                }),
                ", a decompiler written in Luau that is downloaded from this repository the first time it is needed. The fallback is used when the executor has no ",
                (0, i.jsx)(s.code, { children: "decompile" }),
                ", it errors, or it returns nothing.",
              ],
            }),
            "\n",
            (0, i.jsxs)(s.table, {
              children: [
                (0, i.jsx)(s.thead, {
                  children: (0, i.jsxs)(s.tr, {
                    children: [
                      (0, i.jsx)(s.th, { children: "Option" }),
                      (0, i.jsx)(s.th, { children: "Default" }),
                      (0, i.jsx)(s.th, { children: "Meaning" }),
                    ],
                  }),
                }),
                (0, i.jsxs)(s.tbody, {
                  children: [
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "Decompile",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "true" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: "Turn decompiling on or off.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "Decompiler",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: '"auto"' }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            (0, i.jsx)(s.code, { children: '"auto"' }),
                            ", ",
                            (0, i.jsx)(s.code, { children: '"executor"' }),
                            " (only the executor's decompiler) or ",
                            (0, i.jsx)(s.code, { children: '"moon"' }),
                            " (only MoonDecompiler).",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "CustomDecompiler",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Your own decompiler: a function ",
                            (0, i.jsx)(s.code, {
                              children: "(script, bytecode) -> string",
                            }),
                            ", or a table with a ",
                            (0, i.jsx)(s.code, { children: "decompile" }),
                            " method. It is tried first.",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "DecompileTimeout",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "10" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Seconds one decompile call may take. ",
                            (0, i.jsx)(s.code, { children: "-1" }),
                            " disables the timeout.",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "DecompileThreads",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "1" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "How many scripts to decompile at once. Only helps if your executor's ",
                            (0, i.jsx)(s.code, { children: "decompile" }),
                            " yields.",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "scriptcache",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "true" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "Reuse decompiled output for identical scripts.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "SaveBytecode",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Add each script's bytecode to its ",
                            (0, i.jsx)(s.code, { children: "Source" }),
                            " as a comment.",
                          ],
                        }),
                      ],
                    }),
                  ],
                }),
              ],
            }),
            "\n",
            (0, i.jsx)(s.pre, {
              children: (0, i.jsx)(s.code, {
                className: "language-lua",
                children:
                  "synsaveinstance({\n\tCustomDecompiler = function(script, bytecode)\n\t\treturn decompileWithMedal(bytecode) -- return the source text\n\tend,\n})\n",
              }),
            }),
            "\n",
            (0, i.jsx)(s.p, {
              children:
                "Functions MoonDecompiler can't rebuild with normal structure are saved as a loop, or as a commented disassembly, and start with a comment saying why.",
            }),
            "\n",
            (0, i.jsx)(s.h2, {
              id: "recovering-from-a-crash",
              children: "Recovering from a crash",
            }),
            "\n",
            (0, i.jsx)(s.p, {
              children:
                "Some executors crash on particular scripts during decompile. USSI Redux remembers which script was being decompiled, so you can run the save again.",
            }),
            "\n",
            (0, i.jsxs)(s.ol, {
              children: [
                "\n",
                (0, i.jsxs)(s.li, {
                  children: [
                    "Before each decompile, the script is recorded in ",
                    (0, i.jsx)(s.code, { children: "EXEC_STATE.json" }),
                    ". The record is removed when the decompile finishes.",
                  ],
                }),
                "\n",
                (0, i.jsx)(s.li, {
                  children:
                    "If the executor crashes, the record is still there on the next run. That script is marked as crashed.",
                }),
                "\n",
                (0, i.jsxs)(s.li, {
                  children: [
                    "The next run skips it. Its ",
                    (0, i.jsx)(s.code, { children: "Source" }),
                    " says it crashed the executor on a previous run, and the rest of the save carries on.",
                  ],
                }),
                "\n",
              ],
            }),
            "\n",
            (0, i.jsxs)(s.table, {
              children: [
                (0, i.jsx)(s.thead, {
                  children: (0, i.jsxs)(s.tr, {
                    children: [
                      (0, i.jsx)(s.th, { children: "Option" }),
                      (0, i.jsx)(s.th, { children: "Default" }),
                      (0, i.jsx)(s.th, { children: "Meaning" }),
                    ],
                  }),
                }),
                (0, i.jsxs)(s.tbody, {
                  children: [
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "SkipCrashedScripts",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "true" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Turn this protection on or off. It needs ",
                            (0, i.jsx)(s.code, { children: "writefile" }),
                            ".",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "RetryCrashedScripts",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "Forget the remembered scripts and try them again.",
                        }),
                      ],
                    }),
                  ],
                }),
              ],
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                "Closing the game in the middle of a decompile looks the same as a crash, so that script is skipped on the next run. If a script was skipped by mistake, run once with ",
                (0, i.jsx)(s.code, { children: "RetryCrashedScripts = true" }),
                ".",
              ],
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                "The same state file remembers which ",
                (0, i.jsx)(s.code, { children: "gethiddenproperty" }),
                " types crashed or failed on your executor, so those types are skipped on later runs.",
              ],
            }),
            "\n",
            (0, i.jsx)(s.h2, { id: "staying-safe", children: "Staying safe" }),
            "\n",
            (0, i.jsxs)(s.table, {
              children: [
                (0, i.jsx)(s.thead, {
                  children: (0, i.jsxs)(s.tr, {
                    children: [
                      (0, i.jsx)(s.th, { children: "Option" }),
                      (0, i.jsx)(s.th, { children: "Default" }),
                      (0, i.jsx)(s.th, { children: "Meaning" }),
                    ],
                  }),
                }),
                (0, i.jsxs)(s.tbody, {
                  children: [
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "SafeMode",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Disconnects you from the game when saving starts, and turns on ",
                            (0, i.jsx)(s.code, { children: "KillAllScripts" }),
                            " and ",
                            (0, i.jsx)(s.code, { children: "BoostFPS" }),
                            " unless you set them. Highly recommended.",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "KillAllScripts",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Kills all scripts to protect you further. ",
                            (0, i.jsx)(s.code, { children: "SafeMode" }),
                            " also turns it on.",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "BoostFPS",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Turns off 3D rendering while saving. ",
                            (0, i.jsx)(s.code, { children: "SafeMode" }),
                            " also turns it on.",
                          ],
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "Anonymous",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsx)(s.td, {
                          children:
                            "Risky. Removes your name and user ID from the file.",
                        }),
                      ],
                    }),
                    (0, i.jsxs)(s.tr, {
                      children: [
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, {
                            children: "IgnoreSpecialProperties",
                          }),
                        }),
                        (0, i.jsx)(s.td, {
                          children: (0, i.jsx)(s.code, { children: "false" }),
                        }),
                        (0, i.jsxs)(s.td, {
                          children: [
                            "Don't use ",
                            (0, i.jsx)(s.code, {
                              children: "gethiddenproperty",
                            }),
                            ". Helps if your executor crashes or the file is corrupted.",
                          ],
                        }),
                      ],
                    }),
                  ],
                }),
              ],
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                (0, i.jsx)(s.code, { children: "saveinstance" }),
                " does not modify game state.",
              ],
            }),
            "\n",
            (0, i.jsx)(s.h2, {
              id: "using-the-options-type",
              children: "Using the options type",
            }),
            "\n",
            (0, i.jsxs)(s.p, {
              children: [
                (0, i.jsx)(s.code, { children: "saveinstance.luau" }),
                " is written for Luau's ",
                (0, i.jsx)(s.code, { children: "--!strict" }),
                " mode and exports a ",
                (0, i.jsx)(s.code, { children: "SaveInstanceOptions" }),
                " type. If you type-check your own scripts, you can use it to get autocomplete and errors for misspelled options:",
              ],
            }),
            "\n",
            (0, i.jsx)(s.pre, {
              children: (0, i.jsx)(s.code, {
                className: "language-lua",
                children:
                  'local options: SaveInstanceOptions = {\n\tmode = "full",\n\tDecompileTimeout = 15,\n}\n',
              }),
            }),
            "\n",
            (0, i.jsx)(s.h2, {
              id: "where-to-go-next",
              children: "Where to go next",
            }),
            "\n",
            (0, i.jsxs)(s.ul, {
              children: [
                "\n",
                (0, i.jsxs)(s.li, {
                  children: [
                    "The ",
                    (0, i.jsx)(s.a, {
                      href: "/docs/api",
                      children: "API Reference",
                    }),
                    " lists every option with its type, default and description.",
                  ],
                }),
                "\n",
                (0, i.jsxs)(s.li, {
                  children: [
                    "The ",
                    (0, i.jsx)(s.a, {
                      href: "/api/UniversalSynSaveInstance",
                      children: "type page",
                    }),
                    " documents the ",
                    (0, i.jsx)(s.code, { children: "SaveInstanceOptions" }),
                    " type and the ",
                    (0, i.jsx)(s.code, { children: "synsaveinstance" }),
                    " function.",
                  ],
                }),
                "\n",
                (0, i.jsxs)(s.li, {
                  children: [
                    "The ",
                    (0, i.jsx)(s.a, {
                      href: "https://github.com/andrewexec/USSI-Redux",
                      children: "source on GitHub",
                    }),
                    " has the entire codebase for this project.",
                  ],
                }),
                "\n",
                (0, i.jsxs)(s.li, {
                  children: [
                    "This project is based on ",
                    (0, i.jsx)(s.a, {
                      href: "https://github.com/luau/UniversalSynSaveInstance",
                      children: "luau's UniversalSynSaveInstance",
                    }),
                    " and the Roblox file format specifications. See the README for the full list of credits.",
                  ],
                }),
                "\n",
              ],
            }),
          ],
        });
      }
      function a(e = {}) {
        const { wrapper: s } = { ...(0, d.R)(), ...e.components };
        return s
          ? (0, i.jsx)(s, { ...e, children: (0, i.jsx)(h, { ...e }) })
          : h(e);
      }
    },
    8453: (e, s, n) => {
      n.d(s, { R: () => r, x: () => c });
      var t = n(6540);
      const i = {},
        d = t.createContext(i);
      function r(e) {
        const s = t.useContext(d);
        return t.useMemo(
          function () {
            return "function" == typeof e ? e(s) : { ...s, ...e };
          },
          [s, e],
        );
      }
      function c(e) {
        let s;
        return (
          (s = e.disableParentContext
            ? "function" == typeof e.components
              ? e.components(i)
              : e.components || i
            : r(e.components)),
          t.createElement(d.Provider, { value: s }, e.children)
        );
      }
    },
  },
]);
