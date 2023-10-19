import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModles extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String desription;

  NotesModles({required this.title, required this.desription});
}
