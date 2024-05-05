import 'package:floor/floor.dart';

@entity
class Settings {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String theme;

  Settings({
    this.id,
    required this.theme,
  });
}

class GetSettings {
  final Settings? settings;

  GetSettings({
    this.settings,
  });
}