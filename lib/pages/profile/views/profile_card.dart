import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/models/level.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/profile/services/index.dart';
import 'package:sparta/pages/profile/views/profile_info_edit.dart';
import 'package:sparta/pages/profile/views/profile_pic.dart';
import 'package:sparta/pages/send_support/support_dialog.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_container.dart';
import 'package:sparta/pages/profile/views/profile_info.dart';
import 'package:sparta/widgets/my_text_field.dart';

class ProfileCard extends StatefulWidget {
  ProfileCard({Key key, @required this.user, this.self = false})
      : super(key: key);

  final User user;
  final bool self;

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _isEditing = false;
  bool _isSaveLoading = false;
  bool _isChangePicLoading = false;
  bool _isUpdateSkorLoading = false;
  List<int> _imageBytes;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    String jwt = context.read(AuthState.jwt).state;
    String type = context.read(AuthState.type).state;
    double imageWidth = (deviceType == DeviceType.desktop) ? 240 : 120;
    double containerWidth = (deviceType == DeviceType.desktop) ? 960 : 344;
    double space = (deviceType == DeviceType.desktop) ? 32 : 16;
    Map<String, TextEditingController> mapOfTEC = {
      'email': TextEditingController(text: widget.user.email),
      'username': TextEditingController(text: widget.user.username),
      'namaLengkap': TextEditingController(text: widget.user.namaLengkap),
      'namaPanggilan': TextEditingController(text: widget.user.namaPanggilan),
      'password': TextEditingController(),
    };
    TextEditingController updateSkorTEC = new TextEditingController();

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

    Function updateSkorHandler = () async {
      setState(() {
        _isUpdateSkorLoading = true;
      });

      final inputScore = int.tryParse(updateSkorTEC.text);
      final success = (inputScore == null)
          ? false
          : await updateSkorOneUser(inputScore, widget.user.id, jwt);

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
        _isUpdateSkorLoading = false;
      });
    };

    return MyContainer(
      width: containerWidth,
      padding: EdgeInsets.all(1.25 * space),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (deviceType == DeviceType.desktop)
            LandscapeLayout(
              imageWidth: imageWidth,
              imageBytes: _imageBytes,
              isEditing: _isEditing,
              space: space,
              changePictureHandler: changePictureHandler,
              isChangePicLoading: _isChangePicLoading,
              mapOfTEC: mapOfTEC,
              user: widget.user,
            )
          else
            PortraitLayout(
              imageWidth: imageWidth,
              imageBytes: _imageBytes,
              isEditing: _isEditing,
              space: space,
              changePictureHandler: changePictureHandler,
              isChangePicLoading: _isChangePicLoading,
              mapOfTEC: mapOfTEC,
              user: widget.user,
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
                        isLoading: _isUpdateSkorLoading,
                        buttonType: ButtonType.black,
                        text: 'Update Skor',
                        handler: updateSkorHandler,
                      )
                    ],
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.self)
                      (_isEditing)
                          ? MyButton(
                              buttonType: ButtonType.white,
                              text: 'Cancel',
                              handler: () {
                                setState(() {
                                  _isEditing = false;
                                  _imageBytes = null;
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
                    if (widget.self)
                      SizedBox(
                        width: space,
                      ),
                    (widget.self)
                        ? (_isEditing)
                            ? MyButton(
                                isLoading: _isSaveLoading,
                                buttonType: ButtonType.black,
                                text: 'Save',
                                handler: saveHandler,
                              )
                            : MyButton(
                                buttonType: ButtonType.black,
                                text: 'See Supports',
                              )
                        : MyButton(
                            buttonType: ButtonType.black,
                            text: 'Send Support',
                            handler: () {
                              showSupportDialog(context,
                                  widget.user.namaPanggilan, widget.user.id);
                            },
                          )
                  ],
                )
        ],
      ),
    );
  }
}

class PortraitLayout extends StatelessWidget {
  const PortraitLayout({
    Key key,
    @required this.imageWidth,
    @required List<int> imageBytes,
    @required bool isEditing,
    @required this.space,
    @required this.changePictureHandler,
    @required bool isChangePicLoading,
    @required this.mapOfTEC,
    @required this.user,
  })  : _imageBytes = imageBytes,
        _isEditing = isEditing,
        _isChangePicLoading = isChangePicLoading,
        super(key: key);

  final double imageWidth;
  final List<int> _imageBytes;
  final bool _isEditing;
  final double space;
  final Function changePictureHandler;
  final bool _isChangePicLoading;
  final Map<String, TextEditingController> mapOfTEC;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ProfileText(
              text: new Level(user.skor).levelName,
              fontFamily: 'DrukWideBold',
              fontSize: 15,
            ),
            Spacer(),
            ProfileText(
              text: 'Ultah 08/11',
              fontFamily: 'DrukWideBold',
              fontSize: 15,
            ),
          ],
        ),
        SizedBox(
          height: space,
        ),
        ProfilePic(
          imageWidth: imageWidth,
          imageBytes: _imageBytes,
          isSquare: true,
          user: user,
        ),
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
        SizedBox(
          height: space,
        ),
        Container(
          width: double.infinity,
          child: (_isEditing)
              ? ProfileInfoEdit(controllers: mapOfTEC)
              : ProfileInfo(user: user),
        ),
        SizedBox(
          height: space,
        ),
      ],
    );
  }
}

class LandscapeLayout extends StatelessWidget {
  const LandscapeLayout({
    Key key,
    @required this.imageWidth,
    @required List<int> imageBytes,
    @required bool isEditing,
    @required this.space,
    @required this.changePictureHandler,
    @required bool isChangePicLoading,
    @required this.mapOfTEC,
    @required this.user,
  })  : _imageBytes = imageBytes,
        _isEditing = isEditing,
        _isChangePicLoading = isChangePicLoading,
        super(key: key);

  final double imageWidth;
  final List<int> _imageBytes;
  final bool _isEditing;
  final double space;
  final Function changePictureHandler;
  final bool _isChangePicLoading;
  final Map<String, TextEditingController> mapOfTEC;
  final User user;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              ProfilePic(
                imageWidth: imageWidth,
                imageBytes: _imageBytes,
                user: user,
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
                : ProfileInfo(user: user),
          ),
        ],
      ),
    );
  }
}