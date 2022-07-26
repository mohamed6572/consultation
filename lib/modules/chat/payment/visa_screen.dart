import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/home_layout.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../layout/cubit/states.dart';

class Visa_Screen extends StatefulWidget {
  Visa_Screen({required this.price, required this.balance, required this.ID});

  final price;
  final balance;
  final ID;

  @override
  _Visa_ScreenState createState() => _Visa_ScreenState();
}

class _Visa_ScreenState extends State<Visa_Screen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
       if(state is paymentSucssesState)   {
if(state.model?.status==true){
  ShowToast(text: 'تمت عمليه الدفع بنجاج', state: ToastState.SUCSSES);
  print('${widget.balance+widget.price}');
  print('${(1000*70)/100}');
  int  p = ((widget.price*70)/100).toInt();
  AppCubit.get(context).Update_Balance(
      id: widget.ID,
      balance: '${widget.balance+p}'
  );
  navigateTo(context, Home_Layout());
}else{
  ShowToast(text: ' ${state.model?.message}', state: ToastState.ERROR);
}



       }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.teal[50],
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text('ادخل بياناتك'),
            ),
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Column(
                children: [
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CreditCardForm(
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          onCreditCardModelChange: onCreditCardModelChange,
                          themeColor: Colors.blue,
                          formKey: formKey,
                          cardNumberDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Number',
                              hintText: 'xxxx xxxx xxxx xxxx'),
                          expiryDateDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Expired Date',
                              hintText: 'xx/xx'),
                          cvvCodeDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVV',
                              hintText: 'xxx'),
                          cardHolderDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Card Holder',
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              primary: Color(0xff1b447b)),
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'validate',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () {
                            cubit.visa_Payment(
                                number: cardNumber.replaceAll(RegExp(r"\s+"), ""),
                                name: cardHolderName,
                                cvv: cvvCode,
                                expiry_month:
                                int.parse(expiryDate.substring(0, 2)),
                                amount: widget.price,
                                expiry_year:
                                int.parse(expiryDate.substring(3, 5)));
                          },
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
          );
        });
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
