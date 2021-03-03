import 'dart:convert';
import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httpexample/model/posts.dart';

import 'add_screen.dart';

class GetPost extends StatefulWidget {
  @override
  _GetPostState createState() => _GetPostState();
}

class _GetPostState extends State<GetPost> {
  Future<Post> postData;
  @override
  void initState() {
    super.initState();
  
    postData = getPostsById();
  }

//  Future<http.Response> getPostsById() async {
  Future<Post> getPostsById() async {
    http.Response response =
        await http.get("https://jsonplaceholder.typicode.com/posts/1/");
    if (response.statusCode == 200) {
      return Post.fromJSON(json.decode(response.body));
    } else {
      throw Exception("an error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http Example"),
      ),
      body: FutureBuilder<Post>(
        future: postData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListTile(
              title: Text(snapshot.data.title),
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
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddScreen()));
        },
      ),
    );
  }
}
