import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';

class SenderChatBuble extends StatelessWidget {
  final Message message;
  const SenderChatBuble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
class RevicedChatBuble extends StatelessWidget {
  final Message message;
  const RevicedChatBuble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: const BoxDecoration(
          color: Color(0xff0842A0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
