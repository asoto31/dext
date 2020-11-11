import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class User extends StatefulWidget {
  final String clientName;
  const User({Key key, this.clientName}): super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  String _name;
  String _email;
  String _ldap;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseFunctions functions = FirebaseFunctions.instance;

  void _create(name, email, ldap) async {
    print(name);
    print(email);
    print(ldap);
    HttpsCallable callable = functions.httpsCallable('createUser');
    try {
      HttpsCallableResult response = await callable.call(<String, dynamic>{
        'name': name,
        'email': email,
        'ldap': ldap
      });
      print(response.data["status"]);
    } catch (e) {
      print(e);
    }
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name is Required';
              }
              return null;
            },
            onSaved: (String value) {
              _name = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Email is Required';
              }
              return null;
            },
            onSaved: (String value) {
              _email = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'LDAP'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'LDAP is Required';
              }
              return null;
            },
            onSaved: (String value) {
              _ldap = value;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clientName),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildName(),
              RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  _create(_name, _email, _ldap);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
