import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instargram_clone/create_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instargram_clone/detail_post_page.dart';

class SearchPage extends StatefulWidget {
  final User? user;

  const SearchPage(this.user, {Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePage(widget.user)));
        },
        child: const Icon(Icons.create),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildBody() {
    print('search_page created');
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('post').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.requireData;

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0),
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return _buildListItem(context, data.docs[index]);
                });
          }),
    );
  }

  Widget _buildListItem(context, document) {
    return Hero(
      tag: document['photoUrl'],
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPostPage(document);
            }));
          },
          child: Image.network(document['photoUrl'], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
