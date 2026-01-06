#!/bin/zsh
# Run Flutter web on Chrome at port 8080 with custom user data dir

flutter run -t lib/main.dart -d chrome --web-port=8080 --web-browser-flag="--user-data-dir=/tmp/flutter_web_data"

