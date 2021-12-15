import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_app/core/enums/viewstate.dart';
import 'package:cocktail_app/core/models/post.dart';
import 'package:cocktail_app/core/models/user.dart';
import 'package:cocktail_app/core/viewmodels/home_model.dart';
import 'package:cocktail_app/ui/shared/app_colors.dart';
import 'package:cocktail_app/ui/shared/text_styles.dart';
import 'package:cocktail_app/ui/shared/ui_helpers.dart';
import 'package:cocktail_app/ui/widgets/postlist_item.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: model.state == ViewState.Busy
        ? const Center(child: CircularProgressIndicator())
         : Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             UIHelper.verticalSpaceLarge(),
             Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Welcome ${Provider.of<User>(context).name}', 
              style: headerStyle,),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Here are all your posts', 
              style: subHeaderStyle),
            ),
            UIHelper.verticalSpaceSmall(),
            Expanded(child: getPostsUi(model.posts)),
        ],)
      ),
    );
  }

  Widget getPostsUi(List<Post> posts) => ListView.builder(
    itemCount: posts.length,
     itemBuilder: (context, index) => PostListItem(
      post: posts[index],
      onTap: () {
        Navigator.pushNamed(context, 'post', arguments: posts[index]);
      },
     )
  );
}
