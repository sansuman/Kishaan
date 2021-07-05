
import 'package:Testing2/pages/login_page.dart';
import 'package:Testing2/pages/user_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthentication{
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;
 // final SmsAutoFill _autoFill = SmsAutoFill();
  String userId;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void verifyPhoneNumber(String number) async {
    print(number.toString()+'\t phone authentication');
    // print(mobileController.text);
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackbar("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };
    //Listens for errors with verification, such as too many attempts
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar('Phone number verification failed.');//. Code: ${authException.code}. Message: ${authException.message}');
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
  void signInWithPhoneNumber(String number,String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      userId = user.uid;
      showSuccess("OTP Successfully Verified");
      showSnackbar("Successfully signed in UID: ${user.uid}");
      FirebaseFirestore.instance
          .collection('Users').doc(number)
          .set({ "Phone Number" : number,
        "name":"abc",
      },SetOptions(merge: true)).then((_){
        print("success!");
      });

    } catch (e) {
      showError("otp verification failed");
      showSnackbar("Failed to sign in: " + e.toString());
    }
  }
  void showSuccess(String message) {
    showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDetails()));
              },
            ),
          ],
        );
      },
    );
  }
  void showError(String errorMessage) {
    showDialog(
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

  void signOutConfirmation() {
    showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sign out!"),
          content: Text("Are you sure to log out!!"),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }
}