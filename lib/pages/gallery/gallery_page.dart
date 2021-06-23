import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_container.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_pattern_decoration.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/pages/gallery/services/fetchImgLinks.dart';
import 'package:sparta/pages/gallery/services/fetchFeatured.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final imgPerPage = 15;
  int currFirstIdx = 0;
  Future<List<String>> imgLinksResp;
  Future<List<String>> featuredResp;
  List<String> allImgLinks;
  List<String> currImgLinks = [];
  List<String> featuredLinks = [];
  bool isPrevBtnExist = false;
  bool isNextBtnExist = true;

  @override
  void initState() {
    super.initState();
    imgLinksResp = fetchImgLinks();
    imgLinksResp.then((List<String> allImgLinks) {
      this.allImgLinks = allImgLinks;
      this.currImgLinks = allImgLinks;
    });
    featuredResp = fetchFeatured();
    featuredResp.then((List<String> featuredLinks) {
      this.featuredLinks = featuredLinks;
    });
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 20
            : 40;

    void prevPage() {
      setState(() {
        if (currFirstIdx > 0) currFirstIdx -= imgPerPage;
        if (currFirstIdx <= 0) isPrevBtnExist = false;
        isNextBtnExist = true;

        currImgLinks = [];
        for (var i = currFirstIdx; i < currFirstIdx + imgPerPage; i++) {
          currImgLinks.add(allImgLinks[i]);
        }
      });
    }

    void nextPage() {
      setState(() {
        if (isPrevBtnExist) currFirstIdx += imgPerPage;
        if (currFirstIdx >= allImgLinks.length - imgPerPage)
          isNextBtnExist = false;
        isPrevBtnExist = true;

        currImgLinks = [];
        for (var i = currFirstIdx; i < currFirstIdx + imgPerPage; i++) {
          if (i < allImgLinks.length) currImgLinks.add(allImgLinks[i]);
        }
      });
    }

    return FutureBuilder(
        future: Future.wait([imgLinksResp , featuredResp]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: <Widget>[
              SizedBox(height: space / 2),
              MyPatternDecoration(),
              SizedBox(height: space * 2),
              MyTitle(text: "GALLERY", logo: "!"),
              SizedBox(height: space),
              if (!isPrevBtnExist) Row(
                children: <Widget>[
                  SizedBox(width: space * 3),
                  MyTitle(text: "FEATURED"),
                ],
              ),
              SizedBox(height: space),
              
              /* GALLERY */
              Container(
                padding: EdgeInsets.symmetric(horizontal: space * 3),
                child: GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: space / 2,
                  crossAxisSpacing: space / 2,
                  crossAxisCount: 3,
                  children: [
                    for (var i = 0; i <
                            ((!isPrevBtnExist)
                                ? featuredLinks.length 
                                : (currFirstIdx < allImgLinks.length - imgPerPage + 1)
                                ? imgPerPage
                                : allImgLinks.length - currFirstIdx);
                        i++)
                      GestureDetector(
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: 'imageHero' + i.toString(),
                          child: MyContainer(
                            child: FittedBox(
                              child: (!isPrevBtnExist) ? Image.network(featuredLinks[i]) : Image.network(currImgLinks[i]),
                              fit: BoxFit.cover,
                              clipBehavior: Clip.antiAlias,
                            ),
                            width: 128,
                            height: 128,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                                return ImgFullScreen(
                                  linkSource: (!isPrevBtnExist) ? featuredLinks[i] : currImgLinks[i],
                                  tag: i.toString(),
                                );
                            }
                          ));
                        },
                      )
                  ],
                ),
              ),

              SizedBox(height: space * 2),

              /* BUTTONS */
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: space * 3),
                          if (isPrevBtnExist)
                            MyButton(
                              handler: prevPage,
                              buttonType: ButtonType.white,
                              text: 'Prev Page',
                            )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          if (isNextBtnExist)
                            MyButton(
                              handler: nextPage,
                              buttonType: ButtonType.white,
                              text: 'Next Page',
                            ),
                          SizedBox(width: space * 3),
                        ]),
                  ]),
              SizedBox(height: space),
            ]);
          }

          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
        });
  }
}

class ImgFullScreen extends StatelessWidget {
  const ImgFullScreen({
    this.linkSource,
    this.tag,
  });

  final String linkSource;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(127, 0, 0, 0),
        child: Hero(
          transitionOnUserGestures: true,
          tag: 'imageHero' + this.tag,
          child: FittedBox(
            child: Image.network(linkSource),
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}