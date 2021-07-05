
import 'package:Testing2/integration/user_authentication.dart';
import 'package:Testing2/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  UserAuthentication obj = new UserAuthentication();
  var otp =00000;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onPressed: () {
                        print(otp.toString()+'hello');
                        print(mobileController.text);
                        print(otpController.text);
                        if(otp.toString() == otpController.text){
                          obj.showSuccess("OTP Successfully Verified");
                        }else{
                          obj.showError("OTP Verification Failed");
                        }
                      },
                    )),

              ],
            )));
  }
}