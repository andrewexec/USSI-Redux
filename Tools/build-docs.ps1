$ErrorActionPreference = "Stop"
$root = (Resolve-Path "$PSScriptRoot\..").Path
$stage = Join-Path $env:TEMP "ussi-docs-stage"
$site = Join-Path $root "docs-site"


if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory $stage | Out-Null
Copy-Item "$root\saveinstance.luau", "$root\moonwave.toml" $stage
Copy-Item "$root\.moonwave", "$root\docs" $stage -Recurse

Push-Location $stage
try {
	git init -q
	git remote add origin (git -C $root remote get-url origin)
	npx --yes moonwave@latest build --code . --out-dir build
	if ($LASTEXITCODE -ne 0) { throw "moonwave build failed" }
}
finally {
	Pop-Location
}

Get-ChildItem $site -Force | Remove-Item -Recurse -Force
Copy-Item "$stage\build\*" $site -Recurse
if (-not (Test-Path "$site\.nojekyll")) { New-Item -ItemType File "$site\.nojekyll" | Out-Null }

Remove-Item "$site\lunr-index.json", "$site\search-doc.json" -ErrorAction SilentlyContinue

npx --yes prettier@3 --no-config --write "$site/assets/js/*.js" "$site/*.json"
if ($LASTEXITCODE -ne 0) { throw "prettier failed" }

Write-Host "docs-site rebuilt."
