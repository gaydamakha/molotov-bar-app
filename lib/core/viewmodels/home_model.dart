import 'package:cocktail_app/core/enums/viewstate.dart';
import 'package:cocktail_app/core/models/post.dart';
import 'package:cocktail_app/core/services/posts_service.dart';
import 'package:cocktail_app/locator.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  final PostsService _postsService = locator<PostsService>();
  
  List<Post> get posts => _postsService.posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    await _postsService.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}