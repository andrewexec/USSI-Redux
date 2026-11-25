declare function getgenv(): { [any]: any }

declare function identifyexecutor(): (string, string?)
declare function getexecutorname(): (string, string?)
declare function whatexecutor(): (string, string?)

declare function lz4compress(data: string): string
declare function zstdcompress(data: string, level: number?): string

declare function appendfile(path: string, contents: string): ()
declare function delfile(path: string): ()
declare function isfile(path: string): boolean
declare function readfile(path: string): string
declare function writefile(path: string, contents: string): ()
declare function makefolder(path: string): ()

declare function decompile(script: Instance, ...: any): string

declare function islclosure(func: (...any) -> ...any): boolean
declare function isexecutorclosure(func: (...any) -> ...any): boolean
declare function checkclosure(func: (...any) -> ...any): boolean
declare function isourclosure(func: (...any) -> ...any): boolean
declare function hookfunction(func: (...any) -> ...any, hook: (...any) -> ...any): (...any) -> ...any

declare function getreg(): { [any]: any }
declare function getregistry(): { [any]: any }
declare function getallthreads(): { thread }
declare function getgc(includeTables: boolean?): { any }

declare function loadstring(source: string, chunkname: string?): (...any) -> ...any
