import 'package:consultation/models/chat_item_model.dart';
import 'package:consultation/modules/chat/rating_screan.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class Chat_Detales_Screan extends StatelessWidget {
  Chat_Item_Model model;

  Chat_Detales_Screan({required this.model});

  var messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        title: Text(model.name ?? '',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
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
                      navigateTo(context, Rating_Screan(model:model ));
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
                            return Container(
                              width: 300,
                              child: Column(
                                children: [
                                  SendMessage(context),
                                  SendMyMessage()
                                ],
                              ),
                            );
                            // var message =SocialCubit.get(context).messages[index];
                            //  if(messagecontroller == 'ahmed')
                            //SocialCubit.get(context).userModel?.uId ==message.senderId
                            //if( )
                            //    return SendMyMessage();
                            //
                            //  return SendMessage();
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                          itemCount: 20
                          //SocialCubit.get(context).messages.length
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
                Icon(
                  Icons.send,
                  size: 30,
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

  Widget SendMessage(context) => Align(
        widthFactor: MediaQuery.of(context).size.width * 0.80,
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: AssetImage('assets/images/ima.png'),
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
                'hello',
              ),
            ),
            Text(
              '2.00pm',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 9),
            )
          ],
        ),
      );

  Widget SendMyMessage() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '20.00pm',
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
                  'hi',
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
