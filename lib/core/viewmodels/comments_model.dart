import 'package:cocktail_app/core/enums/viewstate.dart';
import 'package:cocktail_app/core/models/comment.dart';
import 'package:cocktail_app/core/services/api.dart';

import '../../locator.dart';
import 'base_model.dart';

class CommentsModel extends BaseModel {
  final Api _api = locator<Api>();

  List<Comment> comments;

  Future fetchComments(int postId) async {
    setState(ViewState.Busy);
    comments = await _api.getCommentsForPost(postId);
    setState(ViewState.Idle);
  }
}
