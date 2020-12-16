import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseApi {
  static final FirebaseApi _singleton = FirebaseApi._internal();

  factory FirebaseApi() {
    return _singleton;
  }

  FirebaseApi._internal();

  FirebaseFirestore _firebaseFiretore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signWithEmail(String email,String password){
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) => null);

  }




}
