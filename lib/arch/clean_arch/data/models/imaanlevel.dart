 
enum LevelBadges{
noohArk,yoonusAsFish,flowerOfIbrahimAs, riverNile, mosqueAqsa
}
class ImaanLevel {
 final  String id;
 final  String title;
 final int totalDays;
 final LevelBadges badgeType;

  ImaanLevel({required this.id, required this.title, required this.totalDays, required this.badgeType});
 
}