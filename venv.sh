venv() {
if [[ $1 == 'new' ]]; then
  echo "Creating new venv"
  python3 -m venv .venv
  source .venv/bin/activate
  
  return
fi
if [[ $1 == 'delete' ]] && test -f .venv/bin/activate; then
  if $VIRTUAL_ENV != ''; then
    deactivate
    echo "Leaving venv"
  fi
  rm -rf .venv 
  return
fi
 if test -f .venv/bin/activate; then
  source .venv/bin/activate
 else
  echo "No .venv here!"
 fi
}


v() {
    echo $VIRTUAL_ENV
}