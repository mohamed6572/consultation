import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/models/all_cosultant_model.dart';
import 'package:consultation/models/catI_tem_model.dart';
import 'package:consultation/models/chat/all_conversation.dart';
import 'package:consultation/models/chat_item_model.dart';
import 'package:consultation/models/consultant_model.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/states.dart';
import '../../shared/components/constens.dart';
import 'chat_detales_screan.dart';

class Chat_Screan extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return  ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var model = cubit.all_Conversations[index];
              var user = cubit.usermodel;
              cubit.consultant.forEach((element) {
                if(model.members![1] == element.sId )
                  cubit.consultant1.add(element);
              });
// if(token!=null)
  return ChatItemC(model,context,cubit.consultant1[index],index,user!);


// if(tokenU!=null)
//   return ChatItemU(model,context,cubit.consultant1[index],index);


// return Center(child: Text('No chat Yet'));

            },

            itemCount: cubit.all_Conversations.length);
      },
    );
  }

  Widget ChatItemC( model,context,Consultants consultant,index,Consultant_Model user) => Card(
    child: InkWell(
     onTap: (){
       navigateTo(context, Chat_Detales_Screan( consultant: consultant,model : model));
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
                  // Text(model.time, style: TextStyle(height: 2),),
                  SizedBox(width: 13,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            model.members![1] ==ID?
                         "  ${consultant.username}":
                            "  ${user.others?.username}"
                            ,

                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1, fontWeight: FontWeight.w500, fontSize: 20)),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  SizedBox(width: 13,),


                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      height: 100,
                      width: 100,
                      image: NetworkImage(
                          model.members![1] ==ID?
                          '${consultant.profilePicture}':
                          '${user.others?.profilePicture}'

                      ),
                    ),
                  ),
                ],
              ),
          ),
    ),
  );
}
