// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutterapp/post.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String imagePath = '';

  Stream<QuerySnapshot> postStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image.path;
    });
  }

  void submit() async {
    try {
      String title = titleController.text;
      String description = titleController.text;
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/zain.jpg');
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: "Enter the title"),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: "Enter the Description"),
          ),
          ElevatedButton(onPressed: pickImage, child: Text('Image_Pick')),
          ElevatedButton(onPressed: submit, child: Text('Submit')),
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: postStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data();
                      return Post(data: data);
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
