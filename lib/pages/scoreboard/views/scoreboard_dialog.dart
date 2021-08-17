import 'package:flutter/material.dart';

class ScoreboardDialog extends StatelessWidget {
  const ScoreboardDialog(this.content);

  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      actionsPadding: EdgeInsets.only(bottom: 24, right: 12),
      title: Text(
        'Wayolo apa ni ?!',
        style: TextStyle(fontFamily: 'DrukWideBold'),
      ),
      content: SelectableText(
        this.content,
        textAlign: TextAlign.center,
      ),
    );
  }
}
