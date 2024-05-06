import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int age;

  User({
    this.id,
    required this.name,
    required this.age,
  });
}
