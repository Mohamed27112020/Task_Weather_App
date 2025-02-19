import 'package:chat_1_app/Component/Constant.dart';

class Message {
  final String messagetxt;
  final String id;
  final String name;
  

  Message(
    this.messagetxt,
    this.id,
    this.name,
    
  );

  factory Message.FromJson(jsondata) {
    return Message(
      jsondata[kCMessages],
      jsondata['id'],
      jsondata['name'],
      
    );
  }
}
