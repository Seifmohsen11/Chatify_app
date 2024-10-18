import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatScreen extends StatelessWidget {
  static String id = "chatScreen";
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMesssagesCollections);
  final TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    const Text(
                      "Chat",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                                message: messagesList[index],
                              )
                            : ChatBubleForFriend(message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kMessage: data,
                          kCreatedAt: FieldValue.serverTimestamp(),
                          'id': email
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      },
                      decoration: InputDecoration(
                        hintText: "Send Message",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            var data = controller.text;
                            if (data.isNotEmpty) {
                              messages.add({
                                kMessage: data,
                                kCreatedAt: FieldValue.serverTimestamp(),
                                'id': email
                              });
                              controller.clear();
                              _controller.animateTo(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                            }
                          },
                          child: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                      )),
                )
              ]),
            );
          } else {
            return const ModalProgressHUD(
                inAsyncCall: true,
                child: Scaffold(
                  backgroundColor: Colors.white,
                ));
          }
        });
  }
}
