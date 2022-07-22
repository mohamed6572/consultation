
import 'dart:async';

import 'package:consultation/modules/login/login_screan.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String image;
  String title;

  BoardingModel({
    required this.image,
    required this.title,
  });
}

class onBoarding extends StatefulWidget {
  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  var boardController = PageController();


  bool isLast= false;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding/pngwing1.png',
        title: 'استشارات في مجالات عديدة',
    ),
    BoardingModel(
        image: 'assets/images/onboarding/pngwing2.png',
        title: 'في خدمتك علي مدار 24 ساعة',
    ),
    BoardingModel(
        image: 'assets/images/onboarding/pngwing3.png',
        title: 'علي أيدي خبراء مختصين وموثوقين',
    ),

  ];

  void submit(){
    cash_helper.saveData(key: 'onboard', value: true).then((value) {

        navigateToAndFinish(context,Login_Screan() );

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          defultTextButtton(text: 'SKIP', function: submit)
        ],
      ),
      body:
        Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){

                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    BuildBoardingItem(boarding[index]),
                itemCount: 3,
              ),
            ),

            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.all(0),
              color: HexColor('#64B9E6'),
              padding: EdgeInsets.only(bottom: 50,top: 20),
              child: SmoothPageIndicator(
                controller: boardController,
                count: boarding.length,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.white,
                    activeDotColor: HexColor('#00527D'),
                    dotHeight: 12,
                    dotWidth: 12,
                    expansionFactor: 2,
                    spacing: 20
                ),
              ),
            ),

          ],
        ),

    );
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image(image: AssetImage('assets/images/logo.png')),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: Image(
            image: AssetImage('${model.image}'),
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        color:HexColor('#64B9E6'),
        margin: EdgeInsets.all(0),

        child: Text(
          '${model.title}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),


    ],
  );
}
