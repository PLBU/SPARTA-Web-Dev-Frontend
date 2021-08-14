import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sparta/models/user.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
    @required this.imageWidth,
    @required this.imageBytes,
    @required this.user,
    this.isSquare = false,
  }) : super(key: key);

  final double imageWidth;
  final List<int> imageBytes;
  final User user;
  final isSquare;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      width: imageWidth,
      height: (isSquare) ? imageWidth : 4 / 3 * imageWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: (imageBytes != null)
            ? Image.memory(
                imageBytes,
                fit: BoxFit.cover,
              )
            : (user.picture != null)
                ? CachedNetworkImage(
                    imageUrl: user.picture,
                    fit: BoxFit.cover,
                    placeholder: (BuildContext context, _) {
                      return Center(
                        child: Container(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/blank_profile.jpg',
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}
