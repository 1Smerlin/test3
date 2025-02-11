Set-Location -Path $PSScriptRoot
cd ../

# >> first Commit
# $commit_name = "first version"
$commit_name = "Seconde version"
git add .
git commit -m "$commit_name"
