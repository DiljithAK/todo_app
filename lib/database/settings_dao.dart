import 'package:floor/floor.dart';
import 'package:todo_app/models/local_models/settings_model.dart';

@dao
abstract class SettingsDao {
  @Query('SELECT * FROM Settings ORDER BY id DESC')
  Future<List<Settings>> findAllSettings();

  @transaction
  Future<GetSettings> findCurrentSettings() async {
    final settings = await findAllSettings();
    if (settings.isNotEmpty) {
      return GetSettings(settings: settings[0]);
    } else {
      return GetSettings(settings: null);
    }
  }

  @insert
  Future<void> insertSettings(Settings settings);

  @update
  Future<void> updateSettings(Settings settings);
}
