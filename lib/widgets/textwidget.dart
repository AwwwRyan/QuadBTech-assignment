import 'package:flutter/cupertino.dart';

class textWidget extends StatelessWidget {
  final String text;

  const textWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: CupertinoColors.white, fontSize: 22, fontWeight: FontWeight.w600));
  }
}
