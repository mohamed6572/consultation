import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/models/Message_Model.dart';
import 'package:consultation/models/chat/all_conversation.dart';
import 'package:consultation/models/chat_item_model.dart';
import 'package:consultation/modules/chat/call/audio_call.dart';
import 'package:consultation/modules/chat/payment/payment_screan.dart';
import 'package:consultation/modules/chat/rating/rating_screan.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/all_cosultant_model.dart';
import '../../shared/components/constens.dart';

class Chat_Detales_Screan extends StatelessWidget {
  Consultants consultant;
  All_Conversation model;

  Chat_Detales_Screan({required this.consultant, required this.model});

  var messagecontroller = TextEditingController();

  void send(context) {
    var user = AppCubit.get(context).usermodel;
    var now = new DateTime.now();
    // var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    // String formattedDate = formatter.format(now);
    print(formattedTime);
    // print(formattedDate);
  //   DateTime now = DateTime.now();
    if(ID ==  model.members![0]){

    AppCubit.get(context).sendMessage(
        receiverId: model.members![1],
        text: messagecontroller.text,
        dateTime:formattedTime);
    AppCubit.get(context).sendNotification(
      body: messagecontroller.text,
        Image : user?.others?.profilePicture ?? '',
      title:consultant.username!,
        fcmtoken:"${consultant.FCM_TOKEN }"
    );
  }

  if(ID ==  model.members![1]){

    AppCubit.get(context).sendMessage(
        Image: consultant.profilePicture ?? '',
        receiverId:model.members![0] ,
        text: messagecontroller.text,
        dateTime: formattedTime);
    AppCubit.get(context).sendNotification(
        body: messagecontroller.text,
        Image : consultant.profilePicture ?? '',
        title: consultant.username!,
        fcmtoken:"${user?.others?.FCM_TOKEN }"
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          AppCubit.get(context).getMessages(
              reseiverId: model.members![0]
          );
          AppCubit.get(context).getMessages(
            reseiverId: model.members![1]
          );

          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  toolbarHeight: 90,
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image(image:
                        NetworkImage("${consultant.profilePicture}"),height: 60,width: 70,),
                      ),
                      SizedBox(width: 8,),
                      Text(
                          consultant.username ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20)),
                    ],
                  ),
                  actions: [
                    IconButton(onPressed: () {
                      navigateTo(context, AudioCallScreen());
                    }, icon: Icon(Icons.call)),
                  ],
                ),
                body: Stack(
                  children: [
                    Image(
                      image: AssetImage(
                          'assets/images/caht_backgraond.png'),
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,

                    ),
                    Column(
                      children: [

                        Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              defultButton(
                                  text: 'بدأ  خطة العمل',
                                  function: () {
                                    navigateTo(
                                        context, Payment_Screan(model: consultant));
                                  },
                                  Background: Colors.green,
                                  width: 130),
                              defultButton(
                                  text: 'إنهاء المحادثة',
                                  function: () {
                                    navigateTo(
                                        context, Rating_Screan(model: consultant));
                                  },
                                  Background: Colors.red,
                                  width: 130),
                            ],
                          ),
                        ),
                        Expanded(
                            child:  Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
//
//  if(message[index].conversationId == ID ){
//   return SendMyMessage(message[index]);}
//
// return SendMessage(message[index],context);
                                        var message = AppCubit
                                            .get(context)
                                            .messages[index];
                                        if (ID == message.receiverId)
                                          return SendMyMessage(message);
                                         if (ID == message.senderId)
                                          return SendMessage(
                                              message, context);

                                        return Center(
                                          child: Text('no messaeeges'),);
                                      },

                                      separatorBuilder: (context,
                                          index) =>
                                          SizedBox(
                                            height: 15,
                                          ),
                                      itemCount: AppCubit
                                          .get(context)
                                          .messages
                                          .length,
                                      physics: BouncingScrollPhysics(),

                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 130,
                          width: double.infinity,
                          color: defColor,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                 send(context);
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
                  ],
                ),
              );
            },

          );
        }
    );
  }

  Widget SendMessage(Message_Model model, context) =>
      Align(
        widthFactor: MediaQuery
            .of(context)
            .size
            .width * 0.80,
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
              margin: EdgeInsets.symmetric(horizontal: 8),
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

  Widget SendMyMessage(Message_Model model) =>
      Align(
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
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 8),

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
            if(model.image!=null)
            ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: NetworkImage("${model.image}"),
                  height: 40,
                  width: 40,
                ))
          ],
        ),
      );
}
