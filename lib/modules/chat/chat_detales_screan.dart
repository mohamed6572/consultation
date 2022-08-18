import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/models/Message_Model.dart';
import 'package:consultation/models/chat_item_model.dart';
import 'package:consultation/modules/chat/audio_call.dart';
import 'package:consultation/modules/chat/rating_screan.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../models/all_cosultant_model.dart';
import '../../shared/components/constens.dart';

class Chat_Detales_Screan extends StatelessWidget {
  Consultants consultant;

  Chat_Detales_Screan({required this.consultant});

  var messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        title: Text(consultant.username ?? '',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28)),
        actions: [
          IconButton(onPressed: () {
navigateTo(context, AudioCallScreen());
          }, icon: Icon(Icons.call)),
        ],
      ),
      body: Column(
        children: [
          myDivider(),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defultButton(
                    text: 'بدأ  خطة العمل',
                    function: () {},
                    Background: Colors.green,
                    width: 130),
                defultButton(
                    text: 'إنهاء المحادثة',
                    function: () {
                      navigateTo(context, Rating_Screan(model:consultant ));
                    },
                    Background: Colors.red,
                    width: 130),
              ],
            ),
          ),
          Expanded(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image(
                image: AssetImage('assets/images/caht_backgraond.png'),
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message =AppCubit.get(context).messages[index];
                            if(ID ==message.senderId )
                              return SendMyMessage(message);

                            return SendMessage(message,context);

                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                          itemCount: AppCubit.get(context).messages.length
                          ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 130,
            width: double.infinity,
            color: defColor,
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    AppCubit.get(context).sendMessage(
                        receiverId: ID!,
                        text: messagecontroller.text,
                        dateTime: DateTime.now().toString());
                  },
                  child: Icon(
                    Icons.send,
                    size: 30,
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: defultFormField(
                    maxlines: 5,
                      type: TextInputType.text,
                      controller: messagecontroller,
                      label: 'دردشة',
                      validator: (v) {}),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget SendMessage(MessageModel model,context) => Align(
        widthFactor: MediaQuery.of(context).size.width * 0.80,
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            if(model.image != null)
            ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: NetworkImage('${model.image}'),
                  height: 40,
                  width: 40,
                )),
            Container(
              width: 170,
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                  ),
                  color: Colors.grey[300]),
              child: Text(
                '${model.text}',
              ),
            ),
            Text(
              '${model.dateTime}',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 9),
            )
          ],
        ),
      );

  Widget SendMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model.dateTime}',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 9),
            ),
            Container(
              width: 170,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(10.0),
                      topEnd: Radius.circular(10.0),
                      topStart: Radius.circular(10.0),
                    ),
                    color: defColor.withOpacity(.2)),
                child: Text(
                  '${model.text}',
                ),
              ),
            ),
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(40),
            //     child: Image(
            //       image: AssetImage('assets/images/ima.png'),
            //       height: 40,
            //       width: 40,
            //     ))
          ],
        ),
      );
}
