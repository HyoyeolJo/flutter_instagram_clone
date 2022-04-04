import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  final dynamic document;

  const DetailPostPage(this.document, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: const Text('둘러보기', style: TextStyle(color: Colors.black)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(document['userPhotoUrl']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          document['email'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(document['displayName'])
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Hero(
                tag: document['photoUrl'],
                child: Image.network(document['photoUrl'])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(document['contents']),
            )
          ],
        ),
      ),
    );
  }
}
