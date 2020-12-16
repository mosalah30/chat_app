import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseApi {
  static final FirebaseApi _singleton = FirebaseApi._internal();

  factory FirebaseApi() {
    return _singleton;
  }

  FirebaseApi._internal();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signInWithEmail(String email,String password)async{

   return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).catchError((e)=> print(e.toString()));

  }

  signUpWithEmail(String email,String password)async{

   await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).catchError((e)=> print(e.toString()));;

  }




}
