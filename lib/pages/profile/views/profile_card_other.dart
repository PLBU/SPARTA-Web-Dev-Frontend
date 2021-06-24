import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/profile/services/index.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_container.dart';
import 'package:sparta/pages/profile/views/profile_info.dart';
import 'package:sparta/pages/send_support/support_dialog.dart';
import 'package:sparta/widgets/my_text_field.dart';

class ProfileCardOther extends StatefulWidget {
  ProfileCardOther({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _ProfileCardOtherState createState() => _ProfileCardOtherState();
}

class _ProfileCardOtherState extends State<ProfileCardOther> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double imageWidth = (deviceType == DeviceType.desktop) ? 240 : 72;
    double containerWidth = (deviceType == DeviceType.desktop) ? 960 : 240;
    double space = (deviceType == DeviceType.desktop) ? 32 : 16;
    String type = context.read(AuthState.type).state;
    String jwt = context.read(AuthState.jwt).state;
    TextEditingController updateSkorTEC = new TextEditingController();

    return MyContainer(
      width: containerWidth,
      padding: EdgeInsets.all(1.25 * space),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: imageWidth,
                  height: 4 / 3 * imageWidth,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: (widget.user.foto != null)
                        ? Image.memory(widget.user.foto)
                        : Image.asset('assets/images/blank_profile.jpg'),
                  ),
                ),
                SizedBox(width: space),
                Expanded(
                  child: ProfileInfo(user: widget.user),
                ),
              ],
            ),
          ),
          (type == 'admin')
              ? IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MyTextField(
                        width: double.infinity,
                        controller: updateSkorTEC,
                      ),
                      SizedBox(
                        height: 0.05 * space,
                      ),
                      MyButton(
                        isLoading: _isLoading,
                        buttonType: ButtonType.black,
                        text: 'Update Skor',
                        handler: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          final inputScore = int.tryParse(updateSkorTEC.text);
                          final success = (inputScore == null) ? false : await updateSkorOneUser(inputScore, widget.user.id, jwt);

                          if (success) {
                            Navigator.pushNamed(context, '/profile/${widget.user.id}');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to update the score'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }

                          setState(() {
                            _isLoading = false;
                          });
                        },
                      )
                    ],
                  ),
                )
              : MyButton(
                  buttonType: ButtonType.black,
                  text: 'Send Support',
                  handler: () {
                    showSupportDialog(
                        context, widget.user.namaPanggilan, widget.user.id);
                  },
                )
        ],
      ),
    );
  }
}
