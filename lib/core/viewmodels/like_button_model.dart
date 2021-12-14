import 'package:cocktail_app/core/services/posts_service.dart';
import 'package:cocktail_app/locator.dart';

import 'base_model.dart';

class LikeButtonModel extends BaseModel {
  final PostsService _postsService = locator<PostsService>();

  int postLikes(int postId) {
    return _postsService.posts
        .firstWhere((post) => post.id == postId)
        .likes;
  }

  void increaseLikes(int postId) {
    _postsService.incrementLikes(postId);
    notifyListeners();
  }
}
