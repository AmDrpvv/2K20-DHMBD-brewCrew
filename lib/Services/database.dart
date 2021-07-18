import 'package:bruapp/models/BruModel.dart';
import 'package:bruapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String  uid;
  DatabaseService({this.uid});

  final CollectionReference bruCollection=Firestore.instance.collection('Bru Collection');

  //Convert stream into BruModel list
  List<Bru> _changeQuerySnapshotsintoBru(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Bru(
        name: doc.data['name'] ?? '',
        sugar: doc.data['sugar'] ?? '0',
        strength: doc.data['strength'] ?? 0
      );
    }).toList();
  }

  UserData _changeDocumentSnapshotsintoUserdata(DocumentSnapshot snapshot)
  {
      return UserData(
        uid: uid,
          name: snapshot['name'] ?? '',
          sugar: snapshot['sugar'] ?? '0',
          strength: snapshot['strength'] ?? 0
      );
  }

  //get database change stream
  Stream<List<Bru>> get databaseStream
  {
    return bruCollection.snapshots()
    .map(_changeQuerySnapshotsintoBru);
  }

  //get userdata stream
  Stream<UserData> get userdataStream
  {
    return bruCollection.document(uid).snapshots()
        .map(_changeDocumentSnapshotsintoUserdata);
  }

  Future updateDatabase(String sugar,String name,int strength) async{
    return await bruCollection.document(uid).setData({
      'sugar':sugar,
      'name':name,
      'strength':strength,
    });
  }
}