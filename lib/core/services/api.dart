import 'dart:convert';

import 'package:cocktail_app/core/models/comment.dart';
import 'package:cocktail_app/core/models/post.dart';
import 'package:cocktail_app/core/models/user.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://jsonplaceholder.typicode.com';
  
  var client = http.Client();

  Future<User> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get(Uri.dataFromString('$endpoint/users/$userId'));

    // Convert and return
    return User.fromJson(json.decode(response.body));
  }

  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = <Post>[];
    // Get user posts for id
    var response = await client.get(Uri.dataFromString('$endpoint/posts?userId=$userId'));

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var post in parsed) {
      posts.add(Post.fromJson(post));
    }

    return posts;
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = <Comment>[];

    // Get comments for post
    var response = await client.get(Uri.dataFromString('$endpoint/comments?postId=$postId'));

    // Parse into List
    var parsed = json.decode(response.body) as List<dynamic>;
    
    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      comments.add(Comment.fromJson(comment));
    }

    return comments;
  }
}
