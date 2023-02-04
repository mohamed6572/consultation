import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class policey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text('Privacy Policy'
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            "estesharti: Privacy policy Welcome to the estesharti app for Android! \n This is an open source Android app developed by Mohamed Hany(DarkNEEs). the app is also available on Google Play.\n  As an avid Android user myself, I take privacy very seriously. I know how irritating it is when apps collect your data without your knowledge.\n  I have not programmed this app to collect any personally identifiable information. All data (app preferences (like theme, etc.) ) created by the you is stored on your device only, and can be simply erased by clearing the apps data or uninstalling it.\n  If you find any security vulnerability that has been inadvertently caused by me or have any question regarding how the app protectes your privacy  Mohamed Hany(DarkNEEs) mhmdalqshlan2@gmail.com",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
