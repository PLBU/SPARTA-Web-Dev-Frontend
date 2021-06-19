import 'package:flutter/material.dart';

import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_card.dart';

class InfoHMIF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double objectSpacing = 40;
    
    return Container(
      child: Column(
        children: [
          MyTitle(text: "HMIF ITB",logo: "?"),
          SizedBox(height: objectSpacing),
          MyCard(
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada bibendum arcu vitae elementum. Aliquam etiam erat velit scelerisque in dictum non. Nunc sed id semper risus in. Suspendisse potenti nullam ac tortor. Velit ut tortor pretium viverra. Pellentesque elit eget gravida cum sociis. Et pharetra pharetra massa massa ultricies mi quis hendrerit.",
            image: Image.asset("assets/images/blank_profile.jpg",width: 100,height: 100,),
            title: "APA ITU HMIF ITB?",
            type: CardType.Right,)
        ],
      )
    );
  }
}