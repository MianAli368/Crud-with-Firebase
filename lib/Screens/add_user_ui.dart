import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Screens/view_users_ui.dart';
import 'package:crud/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController idTC = TextEditingController();
  TextEditingController nameTC = TextEditingController();
  TextEditingController ageTC = TextEditingController();
  TextEditingController birthDateTC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Add User")),
        body: Column(
          children: [
            const Text(
              "Add User",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: idTC,
              decoration: const InputDecoration(label: Text("ID")),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameTC,
              decoration: const InputDecoration(label: Text("Name")),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: ageTC,
              decoration: const InputDecoration(label: Text("Age")),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // TextFormField(
            //   controller: birthDateTC,
            //   decoration: const InputDecoration(label: Text("BirthDate")),
            // ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  final user = User(
                    id: idTC.text,
                    name: nameTC.text,
                    age: int.parse(ageTC.text),
                    // birthday: DateTime.parse(birthDateTC.text)
                  );

                  createUser(user, idTC.text);
                },
                child: const Text("Add User")),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ViewUsers())));
                },
                child: const Text("Show Users"))
          ],
        ),
      ),
    );
  }

  Future createUser(User user, String id) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc(id);
    final json = user.toJson();
    await docUser.set(json);
    print("User Created");
  }
}
