import 'package:flutter/material.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/profile/services/index.dart';
import 'package:sparta/pages/profile/views/profile_card.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/utils/nav_util.dart';
import 'package:sparta/widgets/my_title.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key, @required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final Future<User> user = fetchOneUser(id);
    final User currentUser = context.read(AuthState.currentUser).state;

    return FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => NavUtil.navigate(context, '/not-found'),
            );
            return Container();
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTitle(text: "PROFILE"),
                  SizedBox(
                    height: 32,
                  ),
                  ProfileCard(
                    user: snapshot.data,
                    self: (currentUser != null)
                        ? (snapshot.data.id == currentUser.id)
                        : false,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
        }
      },
    );
  }
}
