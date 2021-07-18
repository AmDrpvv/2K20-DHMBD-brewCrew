import 'package:bruapp/Screens/Home/BottomBar.dart';
import 'package:bruapp/Screens/Home/BruList.dart';
import 'package:bruapp/Services/auth.dart';
import 'package:bruapp/Services/database.dart';
import 'package:bruapp/models/BruModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authservice = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showsettingsPanel(){
      showModalBottomSheet(context: context, builder:(context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
          child: BottomPanel(),
        );
      }
      );
    }

    return StreamProvider<List<Bru>>.value(
      value: DatabaseService().databaseStream,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
                onPressed: () async{
                  await authservice.signout();
                },
                icon: Icon(Icons.person,color: Colors.white,),
                label: Text("sign out",style: TextStyle(color: Colors.white),)
            ),
            FlatButton.icon(
                onPressed: ()=> _showsettingsPanel(),
                icon: Icon(Icons.settings_applications,color: Colors.white,),
                label: Text("settings",style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
        body: BruList(),
      ),
    );
  }
}
