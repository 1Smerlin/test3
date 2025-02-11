Set-Location -Path $PSScriptRoot
cd ../

devpi login root --password=""
devpi remove mydevtools -y
devpi upload --from-dir ./dist

# pipenv update mydevtools
pipenv uninstall mydevtools
pipenv install mydevtools