import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  /*  upon sign up the new user is added to 
  the collection in cloud firestore
  and this page will be popped 
  and user is directed to the hompage */
  storeNewUser(user, context) {
    FirebaseFirestore.instance.collection('/users').add({}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
}
