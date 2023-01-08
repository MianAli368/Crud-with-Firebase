import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({super.key});

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  Stream<List<User>> readUsers() =>
      // snapshots use to fetch all data from users.
      FirebaseFirestore.instance
          .collection("users")
          .snapshots()
          .map((snapshot) =>
              // Accessing documents of data.
              snapshot.docs.map((doc) =>
                  // Map data to User Type.
                  User.fromJson(
                      // Accessing data of Documents.
                      doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        // If dont want realtime changes then change StreamBuilder with FutureBuilder
        // and readUsers() with readUsers().first
        body: StreamBuilder(
          stream: readUsers(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text("Something Went Wrong!");
            } else {
              final user = snapshot.data!;
              return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: ((context, index) {
                    var userList = user[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.amber,
                        leading: Text("${userList.id}"),
                        title: Text("${userList.name}"),
                        subtitle: Text("${userList.age}"),
                      ),
                    );
                  }));
            }
          }),
        ),
      ),
    );
  }
}
