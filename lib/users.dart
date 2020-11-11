import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dext/user.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: ListTile(
        title: Text(document['name']),
        trailing: FlatButton(
          child: Icon(Icons.remove_red_eye),
          onPressed: () {
            Navigator.of(context).pushNamed('/second',
                arguments: document.id + " " + document["name"]);
          },
        ),
      ),
    );
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
      await firestore.collection('users').doc('testUser').get();
      print(documentSnapshot.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Members"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Test_user').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => User(clientName: "WonderClientName")));
        },
      ),
    );
  }
}
