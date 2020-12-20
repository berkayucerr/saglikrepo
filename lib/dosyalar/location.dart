import 'package:hive/hive.dart';
part 'location.g.dart';

@HiveType(typeId: 1)
class Location {
  @HiveField(0)
  double lati;
  @HiveField(1)
  double longti;
  
  Location({this.lati, this.longti});
}
