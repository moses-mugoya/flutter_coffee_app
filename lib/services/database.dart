import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference coffeeCollection =
      Firestore.instance.collection("coffee");

  //update user records
  Future updateUserRecords(String sugars, String name, int strength) async {
    return await coffeeCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //coffee list from snapshot
  List<Coffee> _getCoffeeListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((doc) {
      return Coffee(
          sugars: doc.data['sugars'],
          name: doc.data['name'],
          strength: doc.data['strength']);
    }).toList();
  }

  //Stream to listen to coffee list changes
  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots().map(_getCoffeeListFromSnapshot);
  }

  //get user data from document snapshot
  UserData _getUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: snapshot.data['uid'],
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  //Stream to listen to userData changes
  Stream<UserData> get userData {
    return coffeeCollection
        .document(uid)
        .snapshots()
        .map(_getUserDataFromSnapshot);
  }
}
