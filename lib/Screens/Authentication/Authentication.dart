import 'package:bruapp/Screens/Authentication/Register.dart';
import 'package:flutter/material.dart';
import 'SignIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isshowRegister = false;
  void toggleview()
  {
    setState(() {
      isshowRegister=!isshowRegister;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(isshowRegister){
      return Register(showotherview: toggleview);
    }
    else {
        return SignIn(showotherview: toggleview);
    }
  }
}
