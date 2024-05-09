import 'dart:convert' as convert;
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:riverpod_api_calling/models/post.dart';

class HttpGetPost {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const _endPoint = '/posts';

  Future<List<Post>> getPosts() async {
    List<Post> posts = [];

    try {
      Uri postsUri = Uri.parse('$_baseUrl$_endPoint');
      http.Response response = await http.get(postsUri);
      if (response.statusCode == 200) {
        List<dynamic> postsList = convert.jsonDecode(response.body);

        for (var postListItem in postsList) {
          Post post = Post.fromMap(postListItem);
          posts.add(post);
        }
      }
    } catch (e) {
      log(e.toString());
    }

    return posts;
  }
}
