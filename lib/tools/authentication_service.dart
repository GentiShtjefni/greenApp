
import 'package:entre_cousins/tools/User.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  UserId? _userFromFirebaseUser(User user) {
    return user != null ? UserId(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }


  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signIn ({required String email, required String password}) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e){
      return e.message;

    }
  }
  Future<String?> signUp ({required String email, required String password}) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return 'Signed up';
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){

    }

  }

}