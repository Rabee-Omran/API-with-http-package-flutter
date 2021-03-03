import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:httpexample/model/posts.dart';

class Api {
  static const String _BASE_URL = 'https://jsonplaceholder.typicode.com';

  Future<Post> createPost(Post post) async {
    final http.Response response = await http.post(
      "$_BASE_URL/posts/",
      // headers: {"Content-Type": "application/json"},
      body: json.encode(
        post.toJSON(),
      ),
    );

    if (response.statusCode == 201) {
      // print(response.body);
      return Post.fromJSON(json.decode(response.body));
    } else {
      throw Exception("can't create post.");
    }
  }

  Future<List<Post>> getPosts() async {
    final http.Response response = await http.get(
      "$_BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final data =
          json.decode(response.body).cast<Map<String, dynamic>>(); // as Map;
      return data.map<Post>((item) {
        return Post.fromJSON(item);
      }).toList();
    } else {
      throw Exception("can't create post.");
    }
  }

  Future<http.Response> deletePost(int id) async {
    final http.Response response = await http.delete(
      "$_BASE_URL/posts/$id/",
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      // print(response.body);
      return response;
    } else {
      throw Exception("can't create post.");
    }
  }

  Future<http.Response> updatePost(Post post) async {
    final http.Response response = await http.put(
      "$_BASE_URL/posts/${post.id}/",
      headers: {"Content-Type": "application/json"},
      body: json.encode(post.toJSON()),
    );

    if (response.statusCode == 200) {
      // print(response.body);
      return response;
    } else {
      throw Exception("can't create post.");
    }
  }
}
