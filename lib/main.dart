import 'dart:convert';

import 'package:crud/Screens/add_user_ui.dart';
import 'package:crud/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.brown),
      // home: const MyHomePage(),
      home: const AddUser(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameTC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: 200,
            child: TextField(
              controller: nameTC,
            )),
        actions: [
          IconButton(
              onPressed: () {
                final name = nameTC.text;
                CreateUserwithName(name: name);
                print("Button Pressed");
              },
              icon: const Icon(Icons.add))
        ],
      ),
    ));
  }
}

// Creating user with Only Name Field;
Future CreateUserwithName({required String name}) async {
  // Referencing to the Document
  // final docUser = FirebaseFirestore.instance.collection("users").doc("doc-id");

  // To generate id automatically use this code
  final docUser = FirebaseFirestore.instance.collection("users").doc();

  // final json = {
  //   "name": name,
  //   "age": 21,
  //   "birthday": DateTime(2001, 7, 8),
  // };

  // Replacing json with User Object;
  final user = User(
    id: docUser.id, name: name, age: 21,
    // birthday: DateTime(2001, 7, 8)
  );
  // Converting user to Json
  final json = user.toJson();

  // Create document and set data to the Firebase
  await docUser.set(json);
}
