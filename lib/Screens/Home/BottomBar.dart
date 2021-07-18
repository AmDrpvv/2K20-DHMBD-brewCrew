import 'package:bruapp/Services/database.dart';
import 'package:bruapp/models/Loading.dart';
import 'package:bruapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final _formkey = GlobalKey<FormState>();
  List<String> sugars=['0','1','2','3','4','5'];
  String _currentsugar;
  String _currentname;
  int _currentstrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userdataStream,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Loading();
        }
        else {
          UserData ourUserData = snapshot.data;
          return Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Text('Update your Preferences',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                initialValue: ourUserData.name,
                  validator: (val)=>val.isEmpty? "enter valid name":null,
                  onChanged:(val){
                    setState(() {
                      _currentname=val;
                    });
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.brown[300]),
                    labelText: "enter name",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown[400])
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown)
                    ),
                  )
              ),
              SizedBox(height: 20.0,),
              DropdownButtonFormField(
                value: _currentsugar ?? ourUserData.sugar,
                onChanged: (val){
                  setState(() {
                    _currentsugar=val;
                  });
                },
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                  );
                }).toList(),
                decoration:InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[400])
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Slider(
                activeColor: Colors.brown[_currentstrength?? ourUserData.strength],
                inactiveColor:Colors.brown[_currentstrength?? ourUserData.strength],
                min: 100,
                max: 900,
                divisions: 8,
                value: (_currentstrength?? ourUserData.strength).toDouble(),
                onChanged: (val){
                  setState(() {
                    _currentstrength=val.round();
                  });
                }
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                child: Text("Update",style: TextStyle(color: Colors.white),),
                color: Colors.brown[300],
                onPressed: ()async{
                  if(_formkey.currentState.validate()){
                    await DatabaseService(uid: ourUserData.uid).updateDatabase(
                        _currentsugar ?? ourUserData.sugar,
                        _currentname ?? ourUserData.name,
                        _currentstrength ?? ourUserData.strength);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
        }
      }
    );
  }
}
