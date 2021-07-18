import 'package:bruapp/Services/auth.dart';
import 'package:bruapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/wrapperClass.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().userStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bru App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}

