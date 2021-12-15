import 'package:flutter/material.dart';
import 'package:cocktail_app/ui/views/home_view.dart';

import 'login_view.dart';

class TabContainer extends StatelessWidget {
  const TabContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: const TabBarView(
          children: [
            LoginView(),
            HomeView(),
          ],
        ),
      ),
    );
  }
}
