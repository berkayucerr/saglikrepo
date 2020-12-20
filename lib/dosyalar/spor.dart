import 'location.dart';
import 'package:hive/hive.dart';

part 'spor.g.dart';
@HiveType(typeId: 0)
class SporBilgileri {
  @HiveField(0)
  String baslangiczamani ;
  @HiveField(1)
  String bitiszamani ;
  @HiveField(2)
  String sportipi ;
  @HiveField(3)
  List<Location> l;
  @HiveField(4)
  int kalori ;

  SporBilgileri({this.baslangiczamani,this.bitiszamani,this.kalori,this.sportipi,this.l});
}
