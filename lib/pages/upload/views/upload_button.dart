import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sparta/widgets/my_button.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    this.fileHandler,
    this.submitHandler,
    this.fileName,
    this.width,
    this.submitted,
    this.submission,
    this.loading,
  });

  final fileHandler;
  final submitHandler;
  final fileName;
  final width;
  final submitted;
  final submission;
  final loading;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return Container(
      width: this.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.7,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(5),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: this.submitted ? width * 0.65 : width * 0.4,
                    // height: double.infinity,
                    height: (deviceType == DeviceType.mobile) ? 27 : 35,
                    // padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: (this.submitted && this.submission != null)
                        ? InkWell(
                            onTap: () => launch(this.submission.submissionLink),
                            child: Text(
                              this.submission.submissionLink,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontFamily: "Roboto",
                              ),
                            ),
                          )
                        : (this.loading)
                            ? Text(
                                "Uploading..",
                                style: TextStyle(fontFamily: "Roboto"),
                              )
                            : Text(
                                this.fileName != null
                                    ? this.fileName
                                    : "Pilih File..",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontFamily: "Roboto"),
                              ),
                  ),
                  if (!this.submitted)
                    MyButton(
                      handler: this.fileHandler,
                      text: "Change",
                      buttonType: ButtonType.black,
                    ),
                ],
              ),
            ),
          ),
          MyButton(
            handler: this.submitHandler,
            text: this.submitted ? "Resubmit" : "Submit",
            buttonType: ButtonType.black,
            isLoading: this.loading,
          ),
        ],
      ),
    );
  }
}
