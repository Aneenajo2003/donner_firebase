

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donnerfirebase/update.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'add.dart';
import 'doner.dart';
 import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference donner = db.collection('donner');
  // await donner.doc('9874258614').delete();
  //-------Delete fields-------
  // final Map<String,dynamic>userFields={
  //   'name':'Manu'
  // };
  // await donner.doc('9874258614').set(userFields);
  // -----Update field-------


  final Map<String,dynamic>userFields={
    'name':'Mini',
    'phone':'7895321459'
  };
  await donner.doc('9874258614').set(userFields);
  // -------create fields--------
  //
  // try {
  //   final DocumentSnapshot snapshot = await donner.doc('EaFdW7nYBJwP4c8pp3zE').get();
  //   final userFields = snapshot.data() as Map<String, dynamic>;
  //
  //   log('Document data: $userFields');
  //
  //   // Example of accessing a field safely with type checking
  //   final userName = userFields['name'];
  //   if (userName is String) {
  //     log('User name: $userName');
  //   } else {
  //     log('Unexpected type for user name: ${userName.runtimeType}');
  //   }
  // } catch (e) {
  //   log('Error fetching document: $e');
  // }
  // // ------Read fields------

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  Doner(),
        '/add': (context) =>  Adduser(),
        '/update':(context) =>  Updateuser(),
      },
    );
  }
}
