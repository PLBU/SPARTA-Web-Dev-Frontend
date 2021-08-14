import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/utils/nav_util.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/widgets/my_container.dart';

class TopThree extends StatelessWidget {
  const TopThree(this.user1, this.user2, this.user3);

  final User user1;
  final User user2;
  final User user3;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return MyContainer(
      width: (deviceType == DeviceType.mobile)
          ? 350
          : (deviceType == DeviceType.tablet)
              ? 600
              : 1000,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopCard(num: "1", user: user1),
          TopCard(num: "2", user: user2),
          TopCard(num: "3", user: user3),
        ],
      ),
    );
  }
}

class TopCard extends StatelessWidget {
  const TopCard({this.num, this.user});

  final String num;
  final User user;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double respWidth = (deviceType == DeviceType.mobile)
        ? 100
        : (deviceType == DeviceType.tablet)
            ? 150
            : 250;
    double respHeight = (deviceType == DeviceType.mobile)
        ? 150
        : (deviceType == DeviceType.tablet)
            ? 200
            : 350;
    double respText = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 15
            : 20;
    double respID = (deviceType == DeviceType.mobile)
        ? 15
        : (deviceType == DeviceType.tablet)
            ? 24
            : 30;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        if (this.user.id != null)
          NavUtil.navigate(context, '/profile/${this.user.id}');
      },
      child: Container(
        width: respWidth,
        child: Column(
          children: [
            Container(
              height: respHeight,
              width: respWidth,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: this.user.picture == null
                    ? Image.asset(
                        'assets/images/blank_profile.jpg',
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: this.user.picture,
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
                      ),
              ),
            ),
            SizedBox(height: (deviceType == DeviceType.mobile) ? 3 : 10),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "${this.user.skor} pts",
                style: TextStyle(
                  fontFamily: 'DrukWideBold',
                  color: Colors.white,
                  fontSize: (deviceType == DeviceType.mobile)
                      ? 12
                      : (deviceType == DeviceType.tablet)
                          ? 16
                          : 22,
                ),
              ),
            ),
            SizedBox(height: (deviceType == DeviceType.mobile) ? 3 : 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "#" + this.num,
                    style: TextStyle(
                      fontFamily: 'DrukWideBold',
                      fontSize: respID,
                    ),
                  ),
                  SizedBox(width: respText - 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: respWidth * 0.6,
                        child: Text(
                          this.user.namaPanggilan,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: respText,
                          ),
                        ),
                      ),
                      Text(
                        this.user.nim,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: respText,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
