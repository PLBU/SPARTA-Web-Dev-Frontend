git clone https://github.com/flutter/flutter.git
FLUTTER=flutter/bin/flutter
FLUTTER_CHANNEL=stable
$FLUTTER channel $FLUTTER_CHANNEL
$FLUTTER downgrade
$FLUTTER doctor
$FLUTTER config --enable-web
$FLUTTER build web --web-renderer html --release