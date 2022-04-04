import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  final User? user;

  const CreatePage(this.user, {Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();

  PickedFile? _image;

  //release memory
  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  // Firebase Stroage Rules 에서 read, write 권한을 풀어줘야 한다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear_rounded),
          color: Colors.black,
        ),
        title: const Text(
          '새 게시물',
          style: TextStyle(
              color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            color: Colors.lightBlue,
            onPressed: () {
              final firebaseStorageRef = FirebaseStorage.instance
                  .ref()
                  .child('post')
                  .child('${DateTime.now().millisecondsSinceEpoch}.png');
              final metadata = SettableMetadata(contentType: 'image/png');
              File imageFile = File(_image!.path);
              final UploadTask task =
                  firebaseStorageRef.putFile(imageFile, metadata);
              task.then((TaskSnapshot snapshot) {
                var downloadUrl = snapshot.ref.getDownloadURL();
                downloadUrl.then((uri) {
                  var doc = FirebaseFirestore.instance.collection('post').doc();
                  doc.set({
                    'id': doc.id,
                    'photoUrl': uri.toString(),
                    'contents': textEditingController.text,
                    'email': widget.user!.email,
                    'displayName': widget.user!.displayName,
                    'userPhotoUrl': widget.user!.photoURL
                  }).then((value) {
                    Navigator.pop(context);
                  });
                });
              });
            },
          )
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: const Icon(Icons.add_a_photo),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _image == null
              ? const Text('No Image')
              : Image.file(File(_image!.path)),
          TextField(
            decoration: const InputDecoration(hintText: '내용을 입력하세요'),
            controller: textEditingController,
          )
        ],
      ),
    );
  }

  Future _getImage() async {
    //for gallery
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }
}
