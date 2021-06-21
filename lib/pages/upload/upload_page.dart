import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/pages/upload/views/uploader.dart';
import 'package:sparta/widgets/my_title.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final currentUser = watch(AuthState.currentUser).state;
      final currentJWT = watch(AuthState.jwt).state;
      return Column(
        children: [
          SizedBox(height: 50),
          MyTitle(text: "UPLOAD TUGAS", logo: "!"),
          SizedBox(height: 50),
          Uploader(user: currentUser, jwtToken: currentJWT),
        ],
      );
    });
  }
}
