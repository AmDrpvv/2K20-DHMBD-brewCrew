import 'package:bruapp/Screens/Home/homepage.dart';
import 'package:bruapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authentication/Authentication.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user==null){
      return Authenticate();
    }
    else{
      return HomePage();
    }
  }
}
