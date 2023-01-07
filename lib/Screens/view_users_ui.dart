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
  Stream<List<User>>? userList;
  Stream<List<User>>? readUsers() {
    // snapshots use to fetch all data from users.
    userList = FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .map((event) =>
            // Accessing documents of data.
            event.docs.map((e) =>
                // Map data to User Type.
                User.fromJson(
                    // Accessing data of Documents.
                    e.data())))
        .toList() as Stream<List<User>>;
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: StreamBuilder(
          stream: readUsers(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Something Went Wrong!");
            } else {
              final user = snapshot.data!;
              return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: ((context, index) {
                    return Text("Mian Ali");
                  }));
            }
          }),
        ),
      ),
    );
  }
}
