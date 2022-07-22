import 'package:consultation/modules/login/login_screan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';


void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget defultTextButtton(
        {required String text, required void Function()? function}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget authButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double font = 16.0,
  required String text,
  required String logo,
  required VoidCallback function,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage('assets/images/$logo.png'),
                height: 30,
                width: 30),
            SizedBox(
              width: 9,
            ),
            Text(
              isUpperCase ? text.toUpperCase() : text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: font,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.transparent,
      ),
    );

Widget defultFormField({
  required TextInputType type,
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  required String? Function(String? val)? validator,
  void Function(String val)? onChanged,
  VoidCallback? passwordShow,
  VoidCallback? onTap,
  void Function(String)? onSubmeted,
}) =>
    TextFormField(
      onTap: onTap,
      onFieldSubmitted: onSubmeted,
      onChanged: onChanged,
      obscureText: isPassword,
      validator: validator,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: passwordShow,
              )
            : null,
      ),
    );

Widget defultButton({
  double width = double.infinity,
  Color Background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required String text,
  required VoidCallback function,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Background,
      ),
    );

void ShowToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      gravity:ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: chooseToastColor(state),
      fontSize: 16.0,
      textColor: Colors.white
    );

enum ToastState { SUCSSES, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  late Color color;
  switch (state) {
    case ToastState.SUCSSES:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget SignOut({required context}) =>
  defultTextButtton(text: 'SignOut', function: () {
    cash_helper.removeData(key: 'token').then((value) {
      navigateToAndFinish(context, Login_Screan());
    });
  });

Widget myDivider()=> Padding(
  padding: const EdgeInsets.symmetric(vertical: 10),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[400],
  ),
);

