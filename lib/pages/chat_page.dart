import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chatPage';

  ChatPage({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagesCollection);

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email= ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(
              Message.fromJson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    klogo,
                    height: 50,
                    width: 50,
                  ),
                  const Text(' Chat')
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    // shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(),
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return  messageList[index].id == email?
                      SenderChatBuble(
                        message: messageList[index],
                      ):RevicedChatBuble(message: messageList[index],);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                         'id':email   
                      });
                      controller.clear();
                      scrollController.animateTo(
                        0,
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Text('Loading .......');
        }
      },
    );
  }
}
