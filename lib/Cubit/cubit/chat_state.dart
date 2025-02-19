import 'dart:io';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatMessagesUpdated extends ChatState {
  final List<ChatMessage> messages;
  ChatMessagesUpdated(this.messages);
}

class ChatMessage {
  final String? text;
  final File? image;
  final File? video;

  ChatMessage({this.text, this.image, this.video});
}