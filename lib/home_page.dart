import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final User? user;

  const Homepage(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_box_outlined),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send_outlined),
            color: Colors.black,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
          child: SingleChildScrollView(
              child: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Instagram에 오신 것을 환영합니다',
              style: TextStyle(fontSize: 24.0),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            const Text('사진과 동영상을 보려면 팔로우하세요'),
            const Padding(padding: EdgeInsets.all(16.0)),
            SizedBox(
              width: 260.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.all(4.0)),
                      SizedBox(
                        width: 80.0,
                        height: 80.0,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(user!.photoURL.toString()),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Text(
                        user!.email.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(user!.displayName.toString()),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: Image.network(
                              'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(1.0)),
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: Image.network(
                                'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
                                fit: BoxFit.cover),
                          ),
                          const Padding(padding: EdgeInsets.all(1.0)),
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: Image.network(
                                'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      const Text('Facebook 친구'),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      ElevatedButton(
                        child: const Text('팔로우'),
                        onPressed: () {},
                      ),
                      const Padding(padding: EdgeInsets.all(4.0)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ))),
    );
  }
}
