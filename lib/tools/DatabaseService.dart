import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  getUserByUsername(String username) async {
    return FirebaseFirestore.instance.collection('users').where("name", isEqualTo: username).get();
  }
  getUserByUserEmail(String userEmail) async {
    return FirebaseFirestore.instance.collection('users').where("email", isEqualTo: userEmail).get();
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection('users').add(userMap);

  }

  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection('chat_rooms')
        .doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
  getConversationMessages(String chatRoomId) async{
    return FirebaseFirestore.instance.collection('chat_rooms')
        .doc(chatRoomId).collection('chats')
    .orderBy('time',descending: false)
        .snapshots();
    }
  addConversationMessages(String chatRoomId, messageMap){
    FirebaseFirestore.instance.collection('chat_rooms')
        .doc(chatRoomId).collection('chats')
        .add(messageMap).catchError((e){
      print('error while getting messages: $e');
    });
  }

  getChatRooms(String? username) async{
    return FirebaseFirestore.instance.collection('chat_rooms')
        .where('users', arrayContains: username)
        .snapshots();
  }
}