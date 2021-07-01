git clone https://github.com/flutter/flutter.git
FLUTTER=flutter/bin/flutter
FLUTTER_CHANNEL=stable
FLUTTER_VERSION=v2.2.1
$FLUTTER channel $FLUTTER_CHANNEL
$FLUTTER version $FLUTTER_VERSION
$FLUTTER config --enable-web
$FLUTTER build web