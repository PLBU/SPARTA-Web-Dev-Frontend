git clone https://github.com/flutter/flutter.git
FLUTTER=flutter/bin/flutter
FLUTTER_CHANNEL=stable
$FLUTTER channel $FLUTTER_CHANNEL
$FLUTTER upgrade
$FLUTTER config --enable-web
$FLUTTER build web --web-renderer html --release