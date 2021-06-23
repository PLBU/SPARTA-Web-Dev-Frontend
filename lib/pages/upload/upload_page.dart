import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/models/assignment.dart';
import 'package:sparta/models/submission.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/pages/upload/services/index.dart';
import 'package:sparta/pages/upload/views/uploader.dart';

class UploadPage extends StatelessWidget {
  const UploadPage();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final currentUser = watch(AuthState.currentUser).state;
      final currentJWT = watch(AuthState.jwt).state;
      Future<List<dynamic>> data = fetchLists(currentJWT);

      return FutureBuilder(
          future: data,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData)
              return Column(
                children: [
                  SizedBox(height: 50),
                  MyTitle(text: "UPLOAD TUGAS", logo: "!"),
                  SizedBox(height: 50),
                  Uploader(
                    user: currentUser,
                    jwtToken: currentJWT,
                    data: snapshot.data,
                  ),
                ],
              );

            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black), //,
              ),
            );
          });
    });
  }
}
