import 'package:flutter/material.dart';
import 'package:sparta/models/assignment.dart';
import 'package:sparta/models/submission.dart';
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
    this.assignment,
    this.loading,
  });

  final fileHandler;
  final submitHandler;
  final fileName;
  final width;
  final submitted;
  final Submission submission;
  final Assignment assignment;
  final loading;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return Container(
      width: this.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(5),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: (deviceType == DeviceType.mobile) ? 27 : 35,
                      alignment: Alignment.centerLeft,
                      child: (this.submitted && this.submission != null)
                          ? InkWell(
                              onTap: () =>
                                  launch(this.submission.submissionLink),
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
          ),
          if (this.assignment.deadline.isAfter(DateTime.now()))
            SizedBox(width: this.width * 0.1),
          if (this.assignment.deadline.isAfter(DateTime.now()))
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
