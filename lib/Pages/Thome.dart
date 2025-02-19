import 'dart:io';

import 'package:chat_1_app/Cubit/cubit/chat_cubit.dart';
import 'package:chat_1_app/Cubit/cubit/chat_state.dart';
import 'package:chat_1_app/Pages/tgom.dart';
import 'package:chat_1_app/teess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ImagePicker _picker = ImagePicker();
  List<String> videoUrls = [];
  List<bool> isLocalFile = [];

  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        videoUrls.add(video.path);
        isLocalFile.add(true);
      });
    }
  }

  final TextEditingController _controller = TextEditingController();
 List<String> voiceMessages = [];

  void _sendVoiceMessage(String audioPath) {
    setState(() {
      voiceMessages.add(audioPath);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Chat'))),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                final messages = context.read<ChatCubit>().messages;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    if (message.text != null) {
                      return ListTile(
                        style: ListTileStyle.drawer,
                        title: Text(message.text!),
                      );
                    } else if (message.image != null) {
                      return Image.file(message.image!);
                    } else if (message.video != null) {
                      return VideoPlayerWidget1(
                        videoUrl: message.video!.path,
                        isLocalFile: false,
                      );
                    }
                    return SizedBox.shrink();
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amber,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () => context.read<ChatCubit>().pickImage(),
                  ),
                  IconButton(
                    icon: Icon(Icons.video_library),
                    onPressed: () => context.read<ChatCubit>().pickVideo(),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Type a message'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      context
                          .read<ChatCubit>()
                          .sendTextMessage(_controller.text);
                      _controller.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
