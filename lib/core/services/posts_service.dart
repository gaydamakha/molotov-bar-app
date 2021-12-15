import 'package:cocktail_app/core/models/post.dart';

import '../../locator.dart';
import 'api.dart';

class PostsService {
  final Api _api = locator<Api>();

  late List<Post> _posts;
  List<Post> get posts => _posts;

  Future getPostsForUser(int userId) async {
    _posts = await _api.getPostsForUser(userId);
  }

  void incrementLikes(int postId){
    _posts.firstWhere((post) => post.id == postId).likes++;
  }
} 
