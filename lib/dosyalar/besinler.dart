import 'package:hive/hive.dart';

part 'besinler.g.dart';

@HiveType(typeId: 2)
class Besinler {
  @HiveField(0)
  int id;
  @HiveField(1)
  bool value;
  @HiveField(2)
  String isim;
  @HiveField(3)
  int kalori;
  @HiveField(4)
  int miktar;

  Besinler({this.id, this.isim, this.kalori, this.value,this.miktar});
}
