import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
class AccountPage extends StatefulWidget {
  final User? user;
  const AccountPage(this.user, {Key? key}) : super(key: key);
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  int _postcount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection('post').where('email', isEqualTo: widget.user!.email)
    .get()
    .then((snapshot) {
      setState(() {
        _postcount = snapshot.size;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Account',
        style: TextStyle(
            color : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_box_outlined),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            _googleSignIn.signOut();
          },
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),

      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
      Column(
      children: <Widget>[
      Stack(
      children: <Widget>[
        SizedBox(
        width:80.0,
        height:80.0,
        child: CircleAvatar(
            backgroundImage: NetworkImage(widget.user!.photoURL.toString()),
      ),
    ),
    ],
    ),
    const Padding(
    padding: EdgeInsets.all(8.0),
    ),
    Text(widget.user!.displayName.toString(),
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),),
    ],
    ),
    Text(
    '$_postcount\n게시물',
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 15.0),),
    const Text(
    '0\n팔로워',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 15.0),),
    const Text(
    '0\n팔로잉',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 15.0),),
    ],
    ),
    );
  }
}