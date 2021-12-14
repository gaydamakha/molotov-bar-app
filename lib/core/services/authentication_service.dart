import 'dart:async';

import 'package:cocktail_app/core/models/user.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  final Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser != null;
    if(hasUser) {
      userController.add(fetchedUser);
    }

    return hasUser;
  }
}