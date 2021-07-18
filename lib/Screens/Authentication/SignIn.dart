import 'package:bruapp/Services/auth.dart';
import 'package:bruapp/models/Loading.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {
  final Function showotherview;

  SignIn({this.showotherview});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService authservice = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool isLoading =false;

  String username='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return isLoading? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Sign In"),
        backgroundColor: Colors.brown[400],
        actions: [
          FlatButton.icon(onPressed: (){
            widget.showotherview();
          },
              icon: Icon(Icons.account_circle,color: Colors.white,),
              label: Text("Register",style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                  validator: (val)=>val.isEmpty? "enter valid username":null,
                  onChanged:(val){
                  setState(() {
                    username=val;
                  });
                },
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.brown[300]),
                      labelText: "enter username",

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown[400])
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)
                      ),
                  )
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                obscureText: true,
                  validator: (val)=>val.length < 5? "enter valid password of at least 5 digits":null,
                onChanged:(val){
                  setState(() {
                    password=val;
                  });
                },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.brown[300]),
                    labelText: "enter password",
                      enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown[400])
              ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)
                      )
                  )
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                child: Text("Sign In",style: TextStyle(color: Colors.white),),
                color: Colors.brown[300],
                onPressed: ()async{
                  if(_formkey.currentState.validate()){
                    setState(() {
                      isLoading=true;
                    });
                    dynamic result = await authservice.signin(
                        username, password);
                    if(result==null){
                      setState(() {
                        error="could not sign in with these credentials";
                        isLoading=false;
                      });
                    }
                  }
                },

              ),
              SizedBox(height: 15.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 15.0),
              ),
            ],
          ),
        )
      ),
    );
  }
}
