import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_text_field.dart';
import 'package:sparta/widgets/my_button.dart';

class FilterInput extends StatelessWidget {
  const FilterInput({
    this.width,
    this.fontSize,
    this.lowerBoundTEC,
    this.upperBoundTEC,
    this.nimTEC,
    this.kelompokTEC,
    this.submitHandler,
    this.uploadingState,
    this.isDesktop,
  });

  final width;
  final fontSize;
  final lowerBoundTEC;
  final upperBoundTEC;
  final nimTEC;
  final kelompokTEC;
  final submitHandler;
  final uploadingState;
  final isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      margin: EdgeInsets.only(top: 20),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InputCol(
                      controller: lowerBoundTEC,
                      width: this.width * 0.18,
                      text: "Skor batas bwh:",
                      fontSize: this.fontSize,
                      isDesktop: this.isDesktop,
                    ),
                    InputCol(
                      controller: upperBoundTEC,
                      width: this.width * 0.18,
                      text: "Skor batas atas:",
                      fontSize: this.fontSize,
                      isDesktop: this.isDesktop,
                    ),
                    InputCol(
                      controller: nimTEC,
                      width: this.width * 0.18,
                      text: "NIM:",
                      fontSize: this.fontSize,
                      isDesktop: this.isDesktop,
                    ),
                    InputCol(
                      controller: kelompokTEC,
                      width: this.width * 0.18,
                      text: "Kelompok:",
                      fontSize: this.fontSize,
                      isDesktop: this.isDesktop,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      text: "BUAT",
                      buttonType: ButtonType.black,
                      handler: this.submitHandler,
                      isLoading: this.uploadingState,
                    ),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InputCol(
                      controller: upperBoundTEC,
                      width: this.width * (isDesktop ? 0.18 : 0.2),
                      text: "Skor batas atas:",
                      fontSize: this.fontSize,
                      isDesktop: this.isDesktop,
                    ),
                    InputCol(
                      controller: lowerBoundTEC,
                      width: this.width * (isDesktop ? 0.18 : 0.2),
                      text: "Skor batas bwh:",
                      fontSize: this.fontSize,
                      isDesktop: this.isDesktop,
                    ),
                    InputCol(
                      controller: nimTEC,
                      width: this.width * (isDesktop ? 0.18 : 0.2),
                      text: "NIM:",
                      fontSize: this.fontSize,
                      isDesktop: this.isDesktop,
                    ),
                    InputCol(
                      controller: kelompokTEC,
                      width: this.width * (isDesktop ? 0.18 : 0.2),
                      text: "Kelompok:",
                      fontSize: this.fontSize,
                      isDesktop: this.isDesktop,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      text: "BUAT",
                      buttonType: ButtonType.black,
                      handler: this.submitHandler,
                      isLoading: this.uploadingState,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class InputCol extends StatelessWidget {
  const InputCol({
    this.text,
    this.fontSize,
    this.width,
    this.controller,
    this.isDesktop,
  });

  final text;
  final fontSize;
  final width;
  final controller;
  final isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: fontSize * (isDesktop ? 1.5 : 2.5),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: this.fontSize,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          MyTextField(
            controller: this.controller,
          ),
        ],
      ),
    );
  }
}
