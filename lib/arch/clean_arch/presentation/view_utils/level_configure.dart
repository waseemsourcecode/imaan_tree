import 'package:imaan_tree/arch/clean_arch/data/models/imaanlevel.dart';

class LevelConfigure {
 static String   configureBadges(LevelBadges badge){
 
switch (badge) {
  case LevelBadges.noohArk:return "Ark Of Noh-AS ⛵";
   case LevelBadges.flowerOfIbrahimAs: return"Flower of Abrahim-AS 🌹";
    case LevelBadges.yoonusAsFish: return"Fish of Yonis-AS 🐋";
  case LevelBadges.riverNile: return"Blessed Nile River 🌊";
  case LevelBadges.mosqueAqsa: return"Masjid Aqsa 🕌";
}
 
  }
}