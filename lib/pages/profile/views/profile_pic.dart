import 'package:flutter/material.dart';
import 'package:sparta/models/user.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
    @required this.imageWidth,
    @required List<int> imageBytes,
    @required this.user,
    this.isSquare = false,
  })  : _imageBytes = imageBytes,
        super(key: key);

  final double imageWidth;
  final List<int> _imageBytes;
  final User user;
  final isSquare;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      width: imageWidth,
      height: (isSquare) ? imageWidth : 4 / 3 * imageWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: (_imageBytes != null)
            ? Image.memory(
                _imageBytes,
                fit: BoxFit.cover,
              )
            : (user.foto != null)
                ? Image.memory(
                    user.foto,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/blank_profile.jpg',
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}