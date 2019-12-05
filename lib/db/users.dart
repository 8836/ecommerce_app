import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  final String uid;
  UserServices({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future updateUserData(nameTextController, emailTextController, user, e)async{
    await userCollection.document(uid).setData({
      'username': nameTextController.text,
      'email': emailTextController,
      'userId': user.uid,
      'gender': e
    });
  }


}