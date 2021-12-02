import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
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

  getProducts() async{
    return FirebaseFirestore.instance.collection('products')
        .snapshots();
  }

  getProductsByCategories(String categorie) async{
    return FirebaseFirestore.instance.collection('products')
        .where('categorie', isEqualTo: categorie).snapshots();
  }
  getProductInfo(String productId){
    return FirebaseFirestore.instance.collection('products')
        .doc(productId).snapshots();
  }
  getPhoneNumber(String productId) async{
    return FirebaseFirestore.instance.collection('products')
        .doc(productId).get();
  }
  addProduct(productMap){
    return FirebaseFirestore.instance.collection('products')
        .add(productMap).catchError((e){
          print(e.toString());
    });
  }

  getEvents() async{
    return FirebaseFirestore.instance.collection('events')
        .snapshots();
  }
  addEvent(eventMap){
    return FirebaseFirestore.instance.collection('events')
        .add(eventMap).catchError((e){
      print("${e.toString()} this is the error");
    });
  }
  getEventInfo(String eventId){
    return FirebaseFirestore.instance.collection('events')
        .doc(eventId).snapshots();
  }
  getPhoneNumberEvent(String eventId) async{
    return FirebaseFirestore.instance.collection('events')
        .doc(eventId).get();
  }
  checkUserName(String username) async{
    return FirebaseFirestore.instance.collection('users')
        .where('name', isEqualTo: username).snapshots();
  }
  checkUserNameUnique(String username) async{
    return FirebaseFirestore.instance.collection('users')
        .where('name', isEqualTo: username).get();
  }
  getPending() async {
    return FirebaseFirestore.instance.collection('users')
        .where("pending", isEqualTo: true).snapshots();
  }

  getPendingInfo(userId) async {
    return FirebaseFirestore.instance.collection("users").doc(userId)
        .get();
  }

  getUsers() async {
    return FirebaseFirestore.instance.collection("users")
        .snapshots();
  }


}