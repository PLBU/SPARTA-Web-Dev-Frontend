import 'package:flutter/material.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_container.dart';
import 'package:sparta/widgets/my_heading_text.dart';
import 'package:sparta/widgets/my_text_field.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _invalidInput = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    double imageSize = (deviceType == DeviceType.desktop) ? 48 : 36;
    double containerWidth = (deviceType == DeviceType.desktop)
        ? 640
        : (deviceType == DeviceType.tablet)
            ? 480
            : 320;
    double containerHeight = (deviceType == DeviceType.desktop) ? 420 : null;
    double textFieldWidth = (deviceType == DeviceType.desktop)
        ? 480
        : (deviceType == DeviceType.tablet)
            ? 360
            : 260;

    TextEditingController emailTEC = TextEditingController();
    TextEditingController passwordTEC = TextEditingController();

    void handleButton() async {
      setState(() {
        _isLoading = true;
        _invalidInput = false;
      });
      try {
        await AuthState.login(emailTEC.text, passwordTEC.text, context);
        Navigator.pushNamed(context, '/');
      } catch (err) {
        print(err);
        setState(() {
          _invalidInput = true;
        });
      }
      setState(() {
        _isLoading = false;
      });
    }

    return MyContainer(
      width: containerWidth,
      height: containerHeight,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/sparta_head.png',
                width: imageSize,
                height: imageSize,
                color: Colors.black,
              ),
              SizedBox(width: 16),
              MyHeadingText(content: "SPARTA"),
            ],
          ),
          SizedBox(height: 32),
          MyTextField(
            hintText: "Email",
            width: textFieldWidth,
            maxLines: 1,
            prefixIcon: Icon(
              Icons.email,
              color: Colors.black,
            ),
            controller: emailTEC,
          ),
          SizedBox(height: 16),
          MyTextField(
            hintText: "Password",
            hidden: true,
            width: textFieldWidth,
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            controller: passwordTEC,
          ),
          SizedBox(height: 16),
          if (_invalidInput)
            Text("Invalid email or password!",
                style: TextStyle(color: Colors.red, fontFamily: 'Roboto')),
          SizedBox(height: 16),
          MyButton(
            buttonType: ButtonType.black,
            text: "LOGIN",
            handler: handleButton,
            isLoading: _isLoading,
          )
        ],
      ),
    );
  }
}
