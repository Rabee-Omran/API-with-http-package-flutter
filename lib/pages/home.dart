import 'dart:convert';
import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:httpexample/model/posts.dart';
import 'package:httpexample/network/api.dart';
import 'package:httpexample/pages/update_screen.dart';

import 'add_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Post>> posts;

  @override
  void initState() {
    setState(() {
      posts = Api().getPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text("Http Example"),
      ),
      body: FutureBuilder(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => Dismissible(
                key: ObjectKey(snapshot.data[index].id),
                confirmDismiss: (direction) {
                  return Future.value(direction == DismissDirection.endToStart);
                },
                onDismissed: (direction) async {
                  await Api().deletePost(snapshot.data[index].id).then((res) {
                    // print(res.body);
                  });
                },
                child: Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        child: Text((snapshot.data[index].id).toString()),
                      ),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].body),
                      onTap: () async {
                        String updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                UpdateScreen(snapshot.data[index]),
                          ),
                        );
                        if (updated == "updated") {
                          setState(() {
                            posts = Api().getPosts();
                          });
                          showSnackBar("Updated Post Successfuly");
                        }
                      }),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          String res = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddScreen()));

          if (res == "added") {
            setState(() {
              posts = Api().getPosts();
            });
            showSnackBar("Created Post Successfuly");
          }
        },
      ),
    );
  }
}

final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

showSnackBar(String msg) {
  scaffoldState.currentState.showSnackBar(new SnackBar(content: Text('$msg ')));
}
