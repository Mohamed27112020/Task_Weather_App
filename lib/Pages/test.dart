import 'package:chat_1_app/Component/Constant.dart';
import 'package:chat_1_app/Cubit/LoginCubit/login_cubit.dart';
import 'package:chat_1_app/Cubit/cubit/chat_cubit.dart';
import 'package:chat_1_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Component/customchatbubble.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.email, required this.name});
  final String name;
  final String email;

  String mess = '';
  final controller = ScrollController();
  TextEditingController cont = TextEditingController();
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCMessages);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(
            ktime,
            descending: true,
          )
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<Message> listmassage = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            // Ensure the data is correctly parsed into the Message model
            listmassage.add(Message.FromJson(
                snapshot.data!.docs[i].data() as Map<String, dynamic>));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Kprimarycolor,
              title: Center(
                  child: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              )),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemCount: listmassage.length,
                    itemBuilder: ((context, index) {
                      return listmassage[index].id != email
                          ? customchatbubble(
                              message: listmassage[index],
                            )
                          : customchatbubbleforfriend(
                              message: listmassage[index],
                            );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: cont,
                    onSubmitted: (data) {
                      mess = data;
                      messages.add({
                        kCMessages: data,
                        ktime: DateTime.now(),
                        'id': email,
                        'name': name,
                      });
                      cont.clear();
                      controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send message ',
                      prefixIcon: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Kprimarycolor,
                        ),
                        onPressed: () {
                          BlocProvider.of<ChatCubit>(context)
                              .deleteCollection(kCMessages);
                        },
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          messages.add({
                            kCMessages: mess,
                            ktime: DateTime.now(),
                            'id': email,
                            'name': name,
                          });
                          cont.clear();
                          controller.animateTo(
                            0.9,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Kprimarycolor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
