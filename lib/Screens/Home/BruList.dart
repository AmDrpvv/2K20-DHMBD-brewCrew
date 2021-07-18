import 'package:bruapp/models/BruModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BruList extends StatefulWidget {
  @override
  _BruListState createState() => _BruListState();
}

class _BruListState extends State<BruList> {

  @override
  Widget build(BuildContext context) {
    final querylist=Provider.of <List<Bru>>(context)?? [];
    return ListView.builder(
      itemCount: querylist.length,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
            child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.brown[querylist[index].strength],
                ),
              title: Text(querylist[index].name),
              subtitle: Text('Takes ${querylist[index].sugar} spoons of sugar(s)'),
          ),
        )
        );
      },
    );
  }
}
