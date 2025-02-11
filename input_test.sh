DTstep() {
  echo "!!!!!!!!!!!!!!!!!!!!! $1 !!!!!!!!!!!!!!!!!!!!"
}

detect_os() {
  case "$(uname -s)" in
  Linux*) OS="Linux" ;;
  Darwin*) OS="Mac" ;;                      # macOS basiert auf Darwin
  CYGWIN* | MINGW* | MSYS*) OS="Windows" ;; # Windows-Git Bash, Cygwin oder WSL
  *) OS="Unknown" ;;
  esac
  DTstep "OS"
  echo $OS
}

# Funktion zur Fehlerbenachrichtigung
notify_error() {
  local message="❌ Push fehlgeschlagen: $1"

  DTstep "remote"
  echo "$1"
  if [[ "$OS" == "Linux" ]]; then
    notify-send "Git Push Fehler" "$message"
  elif [[ "$OS" == "Mac" ]]; then
    osascript -e "display notification \"$message\" with title \"Git Push Fehler\""
  elif [[ "$OS" == "Windows" ]]; then
    powershell -Command "msg * '$message'"
  else
    echo "🚨 Unbekanntes Betriebssystem – keine Benachrichtigung möglich!"
  fi
}

remote="Bambi"
branch_name="main"

# detect_os
# notify_error "$remote"

while true; do
  echo "❌ '$branch_name:main' ist mit '$remote' nicht kompatibel!"
  echo "(0) 🚫 Push abbrechen"
  echo "(1) 🔄 Manuelles Mergen durchführen"
  echo "(2) ⚠️ Force-Push trotzdem durchführen"
  echo "(3)  Normal Push"

  # Warten auf Benutzereingabe
  read -r -p "Warte auf Eingabe: " user_choice </dev/tty

  # Prüfen, ob eine gültige Eingabe gemacht wurde
  case "$user_choice" in
  0)
    echo "🚫 Push abgebrochen..."
    break
    ;;
  1)
    echo "🔄 Manuelles Merging..."
    # git pull --rebase "$remote" main
    # git push -u "$remote" "$branch_name:main"
    break
    ;;
  2)
    echo "⚠️ Force-Push wird durchgeführt!"
    # git push -u "$remote" "$branch_name:main" --force
    break
    ;;
  3)
    echo "⚠️ normaler Push wird durchgeführt!"
    # git push -u "$remote" "$branch_name:main"
    break
    ;;
  -r)
    echo "⚠️ normaler Push wird durchgeführt!"
    # git push -u "$remote" "$branch_name:main"
    break
    ;;
  *)
    echo "❌ Ungültige Eingabe! Bitte 1 oder 2 eingeben."
    ;;
  esac
done
