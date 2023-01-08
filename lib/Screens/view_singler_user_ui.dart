import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleUser extends StatefulWidget {
  const SingleUser({super.key});

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  Future<User?> readUser() async {
    // Get Document ID
    final docUser = FirebaseFirestore.instance.collection("users").doc("2");
    // getting single user based on id
    final snapshot = await docUser.get();

    // var data = User.fromJson(snapshot.data()!);

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Single User"),
            ),
            body: FutureBuilder<User?>(
                future: readUser(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text("Something Went Wrong!");
                  } else {
                    final user = snapshot.data!;
                    return user == null
                        ? const Text("User not Exist")
                        : ListTile(
                            leading: Text("${user.id}"),
                            title: Text("${user.name}"),
                            subtitle: Text("${user.age}"),
                          );
                  }
                }))));
  }
}
