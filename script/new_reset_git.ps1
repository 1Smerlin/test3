#
# >>> >S Module
# >> Default Module

# >> External Module

# >> My Module

# >>> !>S Module
# >>> >S variable
$filepath = ".git\tmp\commit_status.tmp"
$line = "prepare-commit-msg: 0"
$line2 = "post-commit: 0"


# >> Path
Set-Location -Path $PSScriptRoot
cd ../

# >> Data
$remote_list = @(
  @{ "remote_name" = "origin"; "path" = "https://github.com/1Smerlin/test.git" },
  @{ "remote_name" = "origin2"; "path" = "https://github.com/1Smerlin/test2.git" },
  @{ "remote_name" = "origin4"; "path" = "https://github.com/1Smerlin/test3.git" }
)

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

# >> Restart Repository
if ($remote_list.Count -ge 2) {


  # Exist_Path $filepath

  # # !!! Add Line
  # add_line $filepath $line
  # add_line $filepath $line2

  # $commit_name = "Restart"
  # git commit --allow-empty -m $commit_name
  # git branch -M main

  # # !!! Delete Line
  # delete_line $filepath $line
  # delete_line $filepath $line2

  # Remove-Item -Recurse -Force "./.git/tmp"

  foreach ($remote in $remote_list) {
    git remote add $remote.remote_name $remote.path
    # git push -u $remote.remote_name main --force
  }
}


# >> Restart Build
# Remove-Item -Recurse -Force "./dist"



# >> first Commit
$commit_name = "first version"
git add .
git commit -m "$commit_name"


# >> reinstall mydevtools
# pipenv update mydevtools
# pipenv upgrade mydevtools
# pipenv uninstall mydevtools
# pipenv install mydevtools

# >>> !>S main


