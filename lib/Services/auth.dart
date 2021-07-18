import 'package:bruapp/Services/database.dart';
import 'package:bruapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth =FirebaseAuth.instance;
//create our user from firebase user
  User _createuserfromFirebaseuser(FirebaseUser user){
    return user==null?null:User(uid: user.uid);
  }

  // auth change user stream
  Stream<User> get userStream{
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _createuserfromFirebaseuser(user));
  }


  //sign in anon
  Future signInAnon() async{

    try{
      AuthResult _result = await _auth.signInAnonymously();
      FirebaseUser user = _result.user;
      return _createuserfromFirebaseuser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signin with username and password
  Future signin(String username,String password) async
  {
    try{
      AuthResult _result = await _auth.signInWithEmailAndPassword(
          email: username,
          password: password
      );
      FirebaseUser user = _result.user;
      return _createuserfromFirebaseuser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with username and password
  Future register(String username,String password) async
  {
    try{
      AuthResult _result = await _auth.createUserWithEmailAndPassword(
          email: username,
          password: password
      );
      FirebaseUser user = _result.user;
      //creating database document for this user
      if(user!=null){
        await DatabaseService(uid: user.uid).updateDatabase('0', username, 100);
      }
      return _createuserfromFirebaseuser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //signing out
  Future signout ()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}