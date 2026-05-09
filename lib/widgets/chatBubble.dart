import 'package:flutter/material.dart';
import 'package:login_mobile/models/message.dart';

class chatBubble extends StatelessWidget {
  const chatBubble({super.key, required this.msg});
  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 32, right: 32, bottom: 32),

        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 1, 21, 56),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),

        margin: EdgeInsets.all(16),

        child: Text(msg.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
