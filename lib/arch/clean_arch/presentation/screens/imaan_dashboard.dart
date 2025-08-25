import 'package:flutter/material.dart';
import 'package:imaan_tree/arch/clean_arch/data/local_ds.dart';
import 'package:imaan_tree/arch/clean_arch/data/models/imaanlevel.dart';
import 'package:imaan_tree/arch/clean_arch/features/notifications/notification_widget.dart';
import 'package:imaan_tree/arch/clean_arch/presentation/view_utils/level_configure.dart';
 

class ImaanDashboard extends StatefulWidget{
  const ImaanDashboard({super.key});

  @override
  State<StatefulWidget> createState() {
   return _StateImaanDashboard();
  }
  
}
final type1 = "There are two words which are light on the tongue, heavy on the scale, and loved by the Most Merciful: SubhanAllahi wa bihamdi, SubhanAllahi al-azeem (Glorified is Allah and praised is He, Glorified is Allah the Most Great)";
     
class _StateImaanDashboard extends State<ImaanDashboard>{
    final NotificationModel notification = NotificationModel(
  title: "Test Remembrance",
  body: type1,
  id: 1,
  isDone: false,
);


  @override
  Widget build(BuildContext context) {
   var imaanLevels =   LocalDs.getAllLevels();
   return   Scaffold(body: Container(
       width: MediaQuery.of(context).size.width,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/bg1.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
     child: SafeArea(
       child: Stack(children: [
        Center(child: NotificationWidget(notification: notification))
        //levels_wigets(imaanLevels: imaanLevels),
          //level meter
       
        //  ClipRRect(
        //   borderRadius: BorderRadius.circular(50),
        //   child: Container(
        //     height: 100,
        //     width: 100,
        //     color: Colors.green,)),
       ],),
     ),
   )
   
   
   );
  }
  
}

class levels_wigets extends StatelessWidget {
  const levels_wigets({
    super.key,
    required this.imaanLevels,
  });

  final List<ImaanLevel> imaanLevels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:80.0,bottom: 80),
      child: ListView.builder(
        reverse: true,
       itemCount: imaanLevels.length,
       //shrinkWrap: true,
       itemBuilder: (build, index){
        final level = imaanLevels[index];
        final pullLevelCorner = index % 2 == 0 ? true : false;
       return Padding(
         padding:   EdgeInsets.only(left: 20.0,right: 20,bottom: pullLevelCorner ? 60 : 20,top:  pullLevelCorner ? 60: 0),
         child: RotationTransition(
          
       turns: new AlwaysStoppedAnimation(pullLevelCorner ? 15 / 360 : 0/ 360),
           child: Container(height: 200,child: Container(
             // width: 400,
             // height: 200,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               border: Border.all(
                 color: Colors.white,
                 width: 10,
               ),
               image: DecorationImage(
                 fit: BoxFit.cover,
                 image: AssetImage("assets/images/bg1.jpg"),
               ),
             ),
             child: Stack(children: [
              Image.asset( pullLevelCorner ?
    "assets/images/alhamdulela.gif":"assets/images/calm.gif",
    width: double.infinity,
    fit: BoxFit.cover,
     
      
    ),
              //  Padding(
              //    padding: const EdgeInsets.all(8.0),
              //    child: Column(children: [
                 
                   
              //    ],),
              //  )
             
              Container(
                height: 200,
                color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        // NotificationWidget(notification: notification),
                Text("Level:" + level.title,style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
               // Text("Achieve",style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),),
                SizedBox(width: 2,),
                                 Text(LevelConfigure.configureBadges(level.badgeType),style: TextStyle(fontSize: 30, color: Colors.green,fontWeight: FontWeight.bold),),
                               
              
                                 ],),
                                   Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                     Text("${level.totalDays} Day's",style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),),
                     SizedBox(width: 3,),
                   Text("Goal ",style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),),
                  
                              
                 
                 ],),
              ],
                                ),)
             ],)
             
            
           ),),
         ),
       );
      }),
    );
  }
}