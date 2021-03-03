import 'package:flutter/material.dart';
import 'package:httpexample/model/posts.dart';
import 'package:httpexample/network/api.dart';

class UpdateScreen extends StatefulWidget {
  final Post post;

  const UpdateScreen(this.post);
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String title;
  String body;

  @override
  void initState() {
    title = widget.post.title;
    body = widget.post.body;
    super.initState();
  }

  final key = GlobalKey<ScaffoldState>();

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
        title: Text("update post"),
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
                      if (val.isNotEmpty) {
                        title = val;
                      }
                    });
                  },
                  decoration:
                      InputDecoration(hintText: title, labelText: "Title"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please Enter body';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isNotEmpty) {
                        body = val;
                      }
                    });
                  },
                  decoration:
                      InputDecoration(hintText: body, labelText: "Body"),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    widget.post.title = title;
                    widget.post.body = body;
                    if (validateAndSave()) {
                      Api().updatePost(widget.post).then((updatedPost) {
                        // print(updatedPost.body);
                        // print(createdPost);

                        Navigator.of(context).pop('updated');
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
