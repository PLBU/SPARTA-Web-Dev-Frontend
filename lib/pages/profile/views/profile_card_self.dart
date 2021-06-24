import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/profile/services/index.dart';
import 'package:sparta/pages/profile/views/profile_info_edit.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_container.dart';
import 'package:sparta/pages/profile/views/profile_info.dart';

class ProfileCardSelf extends StatefulWidget {
  ProfileCardSelf({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _ProfileCardSelfState createState() => _ProfileCardSelfState();
}

class _ProfileCardSelfState extends State<ProfileCardSelf> {
  bool _isEditing = false;
  bool _isSaveLoading = false;
  bool _isChangePicLoading = false;
  List<int> _imageBytes;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    String jwt = context.read(AuthState.jwt).state;
    double imageWidth = (deviceType == DeviceType.desktop) ? 240 : 72;
    double containerWidth = (deviceType == DeviceType.desktop) ? 960 : 240;
    double space = (deviceType == DeviceType.desktop) ? 32 : 16;
    Map<String, TextEditingController> mapOfTEC = {
      'email': TextEditingController(text: widget.user.email),
      'username': TextEditingController(text: widget.user.username),
      'namaLengkap': TextEditingController(text: widget.user.namaLengkap),
      'namaPanggilan': TextEditingController(text: widget.user.namaPanggilan),
      'password': TextEditingController(),
    };

    Function changePictureHandler = () async {
      setState(() {
        _isChangePicLoading = true;
      });

      FilePickerResult result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        setState(() {
          _imageBytes = result.files.first.bytes;
        });
      }

      setState(() {
        _isChangePicLoading = false;
      });
    };

    Function saveHandler = () async {
      setState(() {
        _isSaveLoading = true;
      });

      final success = await updateOneUser(
        widget.user.id,
        jwt,
        newImageBytes: _imageBytes,
        newEmail: mapOfTEC['email'].text,
        newUsername: mapOfTEC['username'].text,
        newNamaLengkap: mapOfTEC['namaLengkap'].text,
        newNamaPanggilan: mapOfTEC['namaPanggilan'].text,
        newPassword: mapOfTEC['password'].text,
      );

      if (success) {
        Navigator.pushNamed(context, '/profile/${widget.user.id}');
        AuthState.updateUser(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      setState(() {
        _isSaveLoading = true;
        _isEditing = false;
      });
    };

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
                Column(
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
                        child: (_imageBytes != null)
                            ? Image.memory(_imageBytes)
                            : (widget.user.foto != null)
                                ? Image.memory(widget.user.foto)
                                : Image.asset(
                                    'assets/images/blank_profile.jpg'),
                      ),
                    ),
                    if (_isEditing)
                      SizedBox(
                        height: 0.5 * space,
                      ),
                    if (_isEditing)
                      MyButton(
                        text: "Change Picture",
                        buttonType: ButtonType.white,
                        handler: changePictureHandler,
                        isLoading: _isChangePicLoading,
                      ),
                  ],
                ),
                SizedBox(width: space),
                Expanded(
                  child: (_isEditing)
                      ? ProfileInfoEdit(controllers: mapOfTEC)
                      : ProfileInfo(user: widget.user),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (_isEditing)
                  ? MyButton(
                      buttonType: ButtonType.white,
                      text: 'Cancel',
                      handler: () {
                        setState(() {
                          _isEditing = false;
                        });
                      },
                    )
                  : MyButton(
                      buttonType: ButtonType.white,
                      text: 'Edit Profile',
                      handler: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                    ),
              SizedBox(
                width: space,
              ),
              (_isEditing)
                  ? MyButton(
                      isLoading: _isSaveLoading,
                      buttonType: ButtonType.black,
                      text: 'Save',
                      handler: saveHandler,
                    )
                  : MyButton(
                      buttonType: ButtonType.black,
                      text: 'See Supports',
                    ),
            ],
          )
        ],
      ),
    );
  }
}
