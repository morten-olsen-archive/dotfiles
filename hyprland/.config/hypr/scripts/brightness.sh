down() {
  brightnessctl s '10%-'
}

up() {
  brightnessctl s +10%
}

case "$1" in
  up) up;;
  down) down;;
esac
