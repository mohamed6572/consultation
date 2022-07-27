import 'package:consultation/models/catI_tem_model.dart';
import 'package:consultation/models/chat_item_model.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';

import 'chat_detales_screan.dart';

class Chat_Screan extends StatelessWidget {
List<Chat_Item_Model> items=[
  Chat_Item_Model(name: 'الدكتور فهد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: '12:12 AM'),
  Chat_Item_Model(name: 'الدكتور فهد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: '12:12 AM'),
  Chat_Item_Model(name: 'الدكتور علي', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
  Chat_Item_Model(name: 'الدكتور محمد', message: 'وعليكم السلام', image: 'assets/images/im.png', time: 'Yesterday'),
];
late catItem_model model1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => ChatItem(items[index],context),
       
        itemCount: items.length);
  }

  Widget ChatItem(model,context) => InkWell(
   onTap: (){
     navigateTo(context, Chat_Detales_Screan(model:model,));
   },
    child: Container(
            height: 110,
            margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.time, style: TextStyle(height: 2),),
                SizedBox(width: 13,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(model.name,maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                          height: 1, fontWeight: FontWeight.w500, fontSize: 20)),
                      SizedBox(height: 10,),
                      Text(model.message,maxLines: 2,
                          overflow: TextOverflow.ellipsis, style: TextStyle(
                          height: 1.1, fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(width: 13,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: AssetImage(model.image),
                  ),
                ),
              ],
            )
        ),
  );
}
