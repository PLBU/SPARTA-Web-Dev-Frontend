import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/pages/upload/services/index.dart';
import 'package:sparta/pages/upload/views/uploader.dart';
import 'package:sparta/pages/upload/views/create_tugas.dart';

class UploadPage extends StatelessWidget {
  const UploadPage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Consumer(builder: (context, watch, child) {
        final type = watch(AuthState.type).state;
        final currentJWT = watch(AuthState.jwt).state;

        if (type == 'admin') {
          return Column(
            children: [
              SizedBox(height: 50),
              MyTitle(text: "CREATE TUGAS", logo: "!"),
              SizedBox(height: 50),
              CreateTugas(),
              SizedBox(height: 50),
            ],
          );
        } else {
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
                        jwtToken: currentJWT,
                        data: snapshot.data,
                      ),
                      SizedBox(height: 50),
                    ],
                  );

                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black), //,
                  ),
                );
              });
        }
      }),
    );
  }
}
