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
        return  Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(top: 20),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 20, right: 5, left: 5),
            child: Column(
              children: [
                Image(
                  image: NetworkImage('${loginC_Model1?.profilePicture}'),
                  height: 120,
                  fit: BoxFit.cover,
                  width: 120,
                ),
                SizedBox(
                  height: 40,
                ),
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
                  margin: EdgeInsets.only(top: 20, right: 20, left: 20,bottom: 20),
                  width: double.infinity,
                  height: 100,
                  child: Center(child: Text("${loginC_Model1?.about}")),
                ),
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
                              Text('4.5')
                            ],
                          ),
                          Text('التقييمات ',style: TextStyle(fontSize: 18),),

                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1'),
                          Text('عدد الإستشارات المقدمة ',style: TextStyle(fontSize: 18),),

                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('4'),
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
