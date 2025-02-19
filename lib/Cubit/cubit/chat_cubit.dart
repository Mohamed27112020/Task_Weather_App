import 'package:chat_1_app/Cubit/cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final ImagePicker _picker = ImagePicker();
  List<ChatMessage> messages = [];
 

  Future<void> deleteCollection(String collectionPath) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get all documents in the collection
    QuerySnapshot snapshot = await firestore.collection(collectionPath).get();

    // Delete each document
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }

    print('Collection "$collectionPath" deleted successfully.');
  }

  void sendTextMessage(String text) {
    messages.add(ChatMessage(text: text));
    emit(ChatMessagesUpdated(messages));
  }

  void sendImageMessage(File image) {
    messages.add(ChatMessage(image: image));
    emit(ChatMessagesUpdated(messages));
  }

  void sendVideoMessage(File video) {
    messages.add(ChatMessage(video: video));
    emit(ChatMessagesUpdated(messages));
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      sendImageMessage(File(image.path));
    }
  }

  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      sendVideoMessage(File(video.path));
    }
  }
}
