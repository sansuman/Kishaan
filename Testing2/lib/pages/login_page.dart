
import 'dart:io';

import 'package:Testing2/integration/user_authentication.dart';
import 'package:Testing2/pages/user_details_page.dart';
import 'package:Testing2/text/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key,this.auth}):super(key:key);
  final UserAuthentication auth;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String userId;
  var otp =00000;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showExit();
          return false;
        },
        child: Scaffold(
            key: _scaffoldKey,
            body: Padding(
                padding:EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          TextDescription.app_name,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          TextDescription.login_page,
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: mobileController,
                        maxLength: 10,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: TextDescription.mobile_enter,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text(TextDescription.gen_otp),
                          onPressed: ()async {
                            otp = 7878;
                            print(mobileController.text);
                            print(otpController.text);
                           // obj.context=context;
                            widget.auth.verifyPhoneNumber(mobileController.text);


                          },
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: otpController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: TextDescription.otp_enter,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    FlatButton(
                      onPressed: (){
                        //resend script
                        if(userId!=null){
                          userId=null;
                          widget.auth.verifyPhoneNumber(mobileController.text);
                        }else {
                          widget.auth.verifyPhoneNumber(mobileController.text);
                        }
                      },
                      textColor: Colors.blue,
                      child: Text('Resend OTP'),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Verify OTP'),
                          onPressed: () async{
                            print(otp.toString()+'hello');
                            print(mobileController.text);
                            print(otpController.text);

                            userId = await (widget.auth.signInWithPhoneNumber(mobileController.text, otpController.text));

                            showSuccess("OTP Successfully Verified"+userId);
                          },
                        )),

                  ],
                ))));
  }
  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void showExit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Exit"),
          content: Text("Are you sure to exit app"),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () async{
                bool confirm= await widget.auth.saveUser();
                if(confirm){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDetails(userId: userId,)));
                }else{
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

}