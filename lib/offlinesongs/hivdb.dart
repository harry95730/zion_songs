import 'package:hive/hive.dart';
part 'hivdb.g.dart';

@HiveType(typeId: 0)
class SongData {
  @HiveField(0)
  String link;

  @HiveField(1)
  int start;

  @HiveField(2)
  bool like;

  SongData({required this.link, required this.start, required this.like});
}
