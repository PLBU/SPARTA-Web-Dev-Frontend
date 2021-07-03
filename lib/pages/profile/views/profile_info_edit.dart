import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_text_field.dart';

class ProfileInfoEdit extends StatefulWidget {
  const ProfileInfoEdit({Key key, this.controllers}) : super(key: key);

  final controllers;

  @override
  _ProfileInfoEditState createState() => _ProfileInfoEditState();
}

class _ProfileInfoEditState extends State<ProfileInfoEdit> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final Function showPassHandler = () {
      setState(() {
        _isHidden = !_isHidden;
      });
    };

    return Column(
      children: [
        MyTextField(
          controller: widget.controllers['email'],
          minLines: 1,
          maxLines: 1,
          labelText: "Email",
        ),
        MyTextField(
          controller: widget.controllers['namaLengkap'],
          minLines: 1,
          maxLines: 1,
          labelText: "Nama Lengkap",
        ),
        MyTextField(
          controller: widget.controllers['namaPanggilan'],
          minLines: 1,
          maxLines: 1,
          labelText: "Nama Panggilan",
        ),
        MyTextField(
          controller: widget.controllers['instagram'],
          minLines: 1,
          maxLines: 1,
          labelText: "Instagram",
        ),
        MyTextField(
          minLines: 1,
          maxLines: 1,
          hidden: _isHidden,
          controller: widget.controllers['password'],
          labelText: "Password",
          hintText: "Leave it empty if want to use the current password",
          suffixIcon: IconButton(
            icon: (_isHidden)
                ? Icon(Icons.remove_red_eye_outlined)
                : Icon(Icons.remove_red_eye),
            onPressed: showPassHandler,
          ),
        ),
      ],
    );
  }
}
