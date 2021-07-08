
import 'package:Testing2/pages/login_page.dart';
import 'package:Testing2/pages/user_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthentication{
  FirebaseAuth _auth = FirebaseAuth.instance;
  BuildContext context;
  String _verificationId;
 // final SmsAutoFill _autoFill = SmsAutoFill();
  User user;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void verifyPhoneNumber(String number) async {
    print(number.toString()+'\t phone authentication');
    // print(mobileController.text);

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
     // await _auth.signInWithCredential(phoneAuthCredential);
     // showSnackbar("Phone number automatically verified ");
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
     // showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
     // showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };
    //Listens for errors with verification, such as too many attempts
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
    //  showSnackbar('Phone number verification failed.');//. Code: ${authException.code}. Message: ${authException.message}');
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91'+number,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);


    } catch (e) {
      showSnackbar("Failed to Verify Phone Number.");

    }
  }
  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
  Future<String> signInWithPhoneNumber (String number,String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,

      );
      user= (await _auth.signInWithCredential(credential)).user;

      print("entering success");
      //  showError("otp verification failed");
      //showSnackbar("Successfully signed in UID: ${user.uid}");
/*      FirebaseFirestore.instance
          .collection('Users').doc(number)
          .set({ "Phone Number" : number,
        "name":"abc",
      },SetOptions(merge: true)).then((_){
        print("success!");
      });*/
      print(user.uid+"\thhhhh");
     return user.uid;

    } catch (e) {
      print("ERROR!!!!!!");
      if(user!=null){
        user=null;
      }

      print(user.uid+"\thhhhh");
      return user?.uid;
      //showError("otp verification failed");
      //showSnackbar("Failed to sign in: " + e.toString());

    }

  }


  Future<User> signOut() async{
    if(user!=null){
      user=null;
    }
    return user;
  }
  Future<bool> saveUser() async{
    bool confirm= false;
    print("save user\t:\t"+user.phoneNumber);
    try {
      FirebaseFirestore.instance
          .collection('Users').doc(user.uid)
          .set({ "Phone Number": user.phoneNumber,
        "name": "abc",
      }, SetOptions(merge: true)).then((_) {

      });
      confirm = true;
    }
    catch(e){
      confirm=false;
    }
    print("aghjhhja\t"+confirm.toString());
    return confirm;
  }


  void retrieveData(String userId)
  {
    FirebaseFirestore.instance.collection("users").doc(userId).get().then((value){
      print(value.data());
    });
  }
}