import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/modules/login/cubit/cubit.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile_Screan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
       var usermodel = AppCubit.get(context).usermodel;
        return  Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(top: 20),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 20, right: 5, left: 5),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image(
                    image: NetworkImage('${usermodel?.others?.profilePicture}'),
                    height: 120,
                    fit: BoxFit.cover,
                    width: 120,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                  usermodel?.others?.about==null
                      ? Container (
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(top: 20, right: 20, left: 20,bottom: 20),
                    width: double.infinity,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                       children: [

                         Text("${usermodel?.others?.username}"),
                         Text("  مرحبا بك يا  "),
                       ],
                    ),
                  ):
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 6), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(top: 20, right: 20, left: 20,bottom: 20),
                  width: double.infinity,
                  height: 100,
                  child: Center(child: Text("${usermodel?.others?.about}")),
                ),
                if(usermodel?.others?.about!=null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal:  20),
                  width: double.infinity,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star,color: Colors.orangeAccent,),
                              Text('${usermodel?.others?.rating}.0')
                            ],
                          ),
                          Text('التقييمات ',style: TextStyle(fontSize: 18),),

                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${usermodel?.others?.counseling}'),
                          Text('عدد الإستشارات المقدمة ',style: TextStyle(fontSize: 18),),

                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${usermodel?.others?.clinet}'),
                          Text('عدد العملاء ',style: TextStyle(fontSize: 18),),

                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
