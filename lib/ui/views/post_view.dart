import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_app/core/models/post.dart';
import 'package:cocktail_app/core/models/user.dart';
import 'package:cocktail_app/ui/shared/app_colors.dart';
import 'package:cocktail_app/ui/shared/text_styles.dart';
import 'package:cocktail_app/ui/shared/ui_helpers.dart';
import 'package:cocktail_app/ui/widgets/comments.dart';
import 'package:cocktail_app/ui/widgets/like_button.dart';

class PostView extends StatelessWidget {
  final Post post;
  const PostView({this.post, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Text(post.title, style: headerStyle),
            Text(
              'by ${Provider.of<User>(context).name}',
              style: const TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium(),
            Text(post.body),
            LikeButton(postId: post.id,),
            Comments(post.id)
          ],
        ),
      ),
    );
  }
}
