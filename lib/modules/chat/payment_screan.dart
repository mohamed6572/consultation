import 'package:flutter/material.dart';

class Payment_Screan extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 5,
        title: Text('الدفع'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
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
            child: Center(child: Row(
              children: [
                Text('Total'),
                Spacer(),
                Row(
                  children: [
                    Text('100'),
                    Icon(Icons.attach_money,color: Colors.black,)
                  ],
                ),

              ],
            )),
          ),
          SizedBox(height: 20,),
          Text('من فضلك اختر طريقة الدفع المناسبة',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(onPressed: (){},child: Image(image: AssetImage('assets/images/visa.png'),),),
              SizedBox(width: 20,),
              MaterialButton(onPressed: (){},child: Image(image: AssetImage('assets/images/paypal.png'),),),
            ],
          ),


        ],
      )
    );
  }
}
