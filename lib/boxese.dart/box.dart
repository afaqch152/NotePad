import 'package:hive/hive.dart';
import 'package:hive_data_base/models.dart/notes_model.dart';

class Boxes {
  static Box<NotesModles> getData() => Hive.box<NotesModles>('notes');
}
