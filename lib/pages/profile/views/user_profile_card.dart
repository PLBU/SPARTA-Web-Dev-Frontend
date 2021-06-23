import 'package:flutter/material.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/send_support/support_dialog.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_container.dart';
import 'package:sparta/pages/profile/views/profile_info.dart';

class UserProfileCard extends StatefulWidget {
  UserProfileCard({Key key, @required this.user, this.self = false})
      : super(key: key);

  final User user;
  final bool self;

  @override
  _UserProfileCardState createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double imageWidth = (deviceType == DeviceType.desktop) ? 240 : 72;
    double containerWidth = (deviceType == DeviceType.desktop) ? 960 : 240;
    double space = (deviceType == DeviceType.desktop) ? 32 : 16;

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
          (this.widget.self)
              ? MyButton(
                  buttonType: ButtonType.black,
                  text: 'See Supports',
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
