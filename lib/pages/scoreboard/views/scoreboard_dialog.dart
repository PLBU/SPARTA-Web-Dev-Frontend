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
        'Wat is dis ?!',
        style: TextStyle(fontFamily: 'DrukWideBold'),
      ),
      content: Center(child: SelectableText(this.content)),
    );
  }
}
