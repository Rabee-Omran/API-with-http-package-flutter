import 'package:flutter/material.dart';
import 'package:httpexample/model/posts.dart';
import 'package:httpexample/network/api.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final key = GlobalKey<ScaffoldState>();
  String title;
  String body;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "enter title", labelText: "Title"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please Enter Title';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "enter body", labelText: "Body"),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (validateAndSave()) {
                      Api()
                          .createPost(Post(
                            body: body,
                             title: title
                            
                            ))
                          .then((createdPost) {
                        // print(createdPost);
                        
                        Navigator.of(context).pop('added');
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
