import 'models/imaanlevel.dart';

class LocalDs {
  static List<ImaanLevel> getAllLevels(){
    final  List<ImaanLevel> levels = [];
    final titles = ["Ahamdulela","Patience","Taqwa","Rizq","Blessings"];
    final days = [3,4,3,6,7];
    final  bages = [LevelBadges.noohArk,LevelBadges.yoonusAsFish,LevelBadges.flowerOfIbrahimAs,LevelBadges.riverNile,LevelBadges.mosqueAqsa];
    for (var i = 0; i < titles.length; i++) {
      final obj = ImaanLevel(id: idGenerator(), title: titles[i], totalDays: days[i], badgeType:bages[i] );
      levels.add(obj);
    }
    return levels;
  }
}
 String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }