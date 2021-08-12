import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_container.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/pages/gallery/services/fetchImgLinks.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final imgPerPage = 12;
  int currFirstIdx = 0;
  Future<List<List<String>>> imgLinksResp;
  List<List<String>> allImgLinks;
  List<String> currImgLinks = [];
  List<String> dropDownItems = [];
  bool isPrevBtnExist = false;
  bool isNextBtnExist = true;
  String _chosenDayText = 'Day 0';
  int _chosenDay = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    imgLinksResp = fetchImgLinks();
    imgLinksResp.then((List<List<String>> allImgLinks) {
      this.allImgLinks = allImgLinks;
      this.currImgLinks = allImgLinks[_chosenDay];

      for (int i=0; i<12; i++){
        if ((allImgLinks[i].isNotEmpty) && (i<=8)) dropDownItems.add('Day ' + i.toString());
        else if ((allImgLinks[i].isNotEmpty) && (i==9)) dropDownItems.add('Day 8.5'); 
        else if (allImgLinks[i].isNotEmpty) dropDownItems.add('Day ' + (i-1).toString()); 
      }

      if (allImgLinks[_chosenDay].length <= imgPerPage) isNextBtnExist = false;
      else isNextBtnExist= true;
      _isLoading = false;
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
    double respText = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 12
            : 16;

    void prevPage() {
      setState(() {
        currFirstIdx -= imgPerPage;
        currImgLinks = [];
        for (var i = currFirstIdx; i < currFirstIdx + imgPerPage; i++) {
          currImgLinks.add(allImgLinks[_chosenDay][i]);
        }
        isNextBtnExist = true;
        if (currFirstIdx <= 0) isPrevBtnExist = false;
      });
    }

    void nextPage() {
      setState(() {
        currFirstIdx += imgPerPage;
        if (currFirstIdx >= allImgLinks[_chosenDay].length - imgPerPage)
          isNextBtnExist = false;
        isPrevBtnExist = true;

        currImgLinks = [];
        for (var i = currFirstIdx; i < currFirstIdx + imgPerPage; i++) {
          if (i < allImgLinks[_chosenDay].length) currImgLinks.add(allImgLinks[_chosenDay][i]);
        }
      });
    }

    return FutureBuilder(
        future: imgLinksResp,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: <Widget>[
              SizedBox(height: space * 2),
              MyTitle(text: "GALLERY", logo: "!"),
              SizedBox(height: space * 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: space * 2.5),
                child: MyContainer(
                  height: (deviceType == DeviceType.mobile) ? space*4 : null,
                  padding: EdgeInsets.fromLTRB(
                    space/2, 
                    (deviceType == DeviceType.desktop) ? 15.0 : (deviceType == DeviceType.tablet) ? 7.0 : 3.0, 
                    space/2,
                    (deviceType == DeviceType.desktop) ? 15.0 : (deviceType == DeviceType.tablet) ? 7.0 : 3.0, ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pilih day SPARTA:",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: respText,
                          color: Colors.black,
                        ),
                      ),

                      /* DROPDOWN */
                      Container(
                        padding: EdgeInsets.fromLTRB(space/2, 0, space/2, 0),
                        width: space*12.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            value: _chosenDayText,
                            underline: Container(color: Colors.white, height: 1.0),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: respText,
                              color: Colors.black,
                            ),
                            items: dropDownItems.map<DropdownMenuItem<String>>((String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String value){
                              setState(() {
                                _isLoading = true;
                                isPrevBtnExist = false;
                                _chosenDayText = value;
                                _chosenDay = (value != "Day 8.5") && (int.parse(value.split(' ')[1]) <= 8)
                                  ? int.parse(value.split(' ')[1])
                                  : (value != "Day 8.5") && (int.parse(value.split(' ')[1]) > 9)
                                  ? int.parse(value.split(' ')[1]) + 1
                                  : 9;
                                currFirstIdx = 0;
                                this.currImgLinks = allImgLinks[_chosenDay];
                                if (allImgLinks[_chosenDay].length <= imgPerPage) isNextBtnExist = false;
                                else isNextBtnExist= true;
                                _isLoading = false;
                              });
                            }
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: space*1.5),

              /* GALLERY */
              (!_isLoading)
              ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: space * 2.5),
                      child:  (allImgLinks[_chosenDay].length == 0)
                              ? Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height -
                                      MyNavigationBar().preferredSize.height -
                                      8 * space,
                                  child: Text("Belum ada Foto yang tersedia",
                                      style: TextStyle(fontFamily: 'DrukWideBold')))
                              : GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  mainAxisSpacing: space / 1.5,
                                  crossAxisSpacing: space / 1.5,
                                  crossAxisCount: 3,
                                  children: [
                                    for (var i = 0; i < ((currFirstIdx < allImgLinks[_chosenDay].length - imgPerPage + 1) 
                                                            ? imgPerPage 
                                                            : allImgLinks[_chosenDay].length - currFirstIdx); i++)
                                      GestureDetector(
                                        child: Hero(
                                          transitionOnUserGestures: true,
                                          tag: 'imageHero' + i.toString(),
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                            child: MyContainer(
                                              child: FittedBox(
                                                child: Image.network(
                                                  currImgLinks[i],
                                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child: Container(
                                                        width: 250.0,
                                                        height: 250.0,
                                                        child: Center(
                                                            child: CircularProgressIndicator(
                                                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                                            )
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                fit: BoxFit.cover,
                                                clipBehavior: Clip.antiAlias,
                                              ),
                                              width: 128,
                                              height: 128,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder:
                                                  (BuildContext context, _, __) {
                                                return ImgFullScreen(
                                                  linkSource: currImgLinks[i],
                                                  tag: i.toString(),
                                                );
                                              }));
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
                                SizedBox(width: space * 2.5),
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
                                SizedBox(width: space * 2.5),
                              ]),
                        ]),
                  ],
                )
              : Column(
                children: [
                  SizedBox(height: space*3),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                  SizedBox(height: space*3),
                ],
              ),
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
