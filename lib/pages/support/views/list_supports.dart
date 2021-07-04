import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';

const supportsPerPage = 5;

class ListSupports extends StatefulWidget {
  ListSupports({
    this.isReceivedDisplayed,
    this.lists,
    this.space,
  });

  final isReceivedDisplayed;
  final List<dynamic> lists;
  final double space;

  @override
  _ListSupportsState createState() => _ListSupportsState();
}

class _ListSupportsState extends State<ListSupports> {
  List<dynamic> supportCards;

  bool _isNextBtnExist;
  bool _isPrevBtnExist;
  int _pageNum = 0;

  @override
  void initState() {
    super.initState();
    var tempArr = [];

    var allCards = widget.lists;

    if (allCards.length > 0)
      for (int i = 0; i <= allCards.length ~/ supportsPerPage; i++) {
        if (i == allCards.length ~/ supportsPerPage) {
          if (allCards.length % supportsPerPage > 0)
            tempArr.add(
              allCards.sublist(i * supportsPerPage, allCards.length).map(
                (card) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    child: card,
                  );
                },
              ).toList(),
            );
          else
            continue;
        } else
          tempArr.add(
            allCards
                .sublist(i * supportsPerPage, (i + 1) * supportsPerPage)
                .map(
              (card) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  child: card,
                );
              },
            ).toList(),
          );
      }

    supportCards = tempArr;
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    final PageController controller = PageController(initialPage: 0);

    // print(_pageNum.toString() + " " + supportCards.length.toString());
    setState(() {
      _isNextBtnExist = (_pageNum + 1) % supportCards.length > 0;
      _isPrevBtnExist = _pageNum % supportCards.length > 0;
    });

    return Column(
      children: <Widget>[
        // Support Cards (PageView)
        Container(
          height: (deviceType == DeviceType.mobile)
              ? supportCards[_pageNum].length * 160
              : (deviceType == DeviceType.tablet)
                  ? supportCards[_pageNum].length * 180
                  : supportCards[_pageNum].length * 250,
          padding: EdgeInsets.symmetric(horizontal: widget.space * 5),
          child: PageView.builder(
            onPageChanged: (pageID) {
              setState(() {
                _pageNum = pageID;
              });
            },
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.lists.length % supportsPerPage > 0
                ? (widget.lists.length ~/ supportsPerPage) + 1
                : (widget.lists.length ~/ supportsPerPage),
            itemBuilder: ((context, index) {
              return Column(
                children: supportCards[index],
              );
            }),
          ),
        ),
        SizedBox(height: widget.space),
        /* PAGE HANDLING BUTTONS */
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: widget.space * 5),
                if (_isPrevBtnExist)
                  MyButton(
                    handler: () {
                      controller.animateToPage(
                        controller.page.toInt() - 1,
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                      );
                    },
                    buttonType: ButtonType.white,
                    text: 'Prev Page',
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (_isNextBtnExist)
                  MyButton(
                    handler: () {
                      controller.animateToPage(
                        controller.page.toInt() + 1,
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                      );
                    },
                    buttonType: ButtonType.white,
                    text: 'Next Page',
                  ),
                SizedBox(width: widget.space * 5),
              ],
            ),
          ],
        ),
        SizedBox(height: widget.space),
      ],
    );
  }
}
