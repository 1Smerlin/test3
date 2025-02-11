#
# >>> >S Module
# >> Default Module

# >> External Module

# >> My Module

# >>> !>S Module
# >>> >S variable
$filepath = ".git\tmp\commit_status.tmp"
$line = "script: 0"
$line2 = "commit: 0"


# >> Path
Set-Location -Path $PSScriptRoot
cd ../

# >>> !>S variable
# >>> >S logic

# >>> !>S logic
# >>> >S function


function Exist_Path {
  param (
    [string]$filepath
  )
  $folder = Split-Path -Path $filepath -Parent
  if (-not (Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
  }

  if (-not (Test-Path $filepath)) {
    New-Item -ItemType File -Path $filepath -Force | Out-Null
  }
}

function add_line {
  param (
    [string]$filepath,
    [string]$line
  )
  if (-not (Select-String -Path $filepath -Pattern "^$line$" -Quiet)) {
    Add-Content -Path $filepath -Value $line
    Write-Host "Zeile hinzugefugt: $line"
  }
  else {
    Write-Host "Zeile existiert bereits: $line"
  }
}

function delete_line {
  param (
    [string]$filepath,
    [string]$line
  )
  if (Test-Path $filepath) {
    (Get-Content $filepath -Raw) -replace "(?m)^$line`r?`n?", "" | Set-Content $filepath -NoNewline
    Write-Host "Zeile entfernt: $line"
  }
  else {
    Write-Host "Datei existiert nicht: $filepath"
  }
}






# >>> !>S function
# >>> >S main

# >> Restart Git
Remove-Item -Recurse -Force "./.git"
git init

# >> Restart Build
# Remove-Item -Recurse -Force "./dist"

# >> Start Build
# ! first Commit
$commit_name = "first version"
git add .
git commit -m "$commit_name"


# >> reinstall mydevtools
# pipenv update mydevtools
# pipenv upgrade mydevtools
# pipenv uninstall mydevtools
# pipenv install mydevtools

# >>> !>S main


