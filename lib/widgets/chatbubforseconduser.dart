import 'package:flutter/material.dart';
import 'package:login_mobile/models/message.dart';

class seconduser extends StatelessWidget {
  const seconduser({super.key, required this.msg});
  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 32, right: 32, bottom: 32),

        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),

        margin: EdgeInsets.all(16),

        child: Text(msg.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
