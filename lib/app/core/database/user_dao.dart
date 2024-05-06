import "package:floor/floor.dart";

import "../models/local_models/user_model.dart";

@dao
abstract class UserDao {
  @Query('SELECT * FROM User ORDER BY id DESC')
  Future<List<User>> findAllUsers();

  @transaction
  Future<GetUser> findCurrentUser() async {
    final users = await findAllUsers();
    if (users.isNotEmpty) {
      return GetUser(user: users[0]);
    } else {
      return GetUser(user: null);
    }
  }

  @insert
  Future<void> insertUser(User user);
}
