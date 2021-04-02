import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth {
  final String phoneNo;
  String verificationId;
  String errorMessage = '';
  // For firebase auth
  final auth = FirebaseAuth.instance;

  //For Web
  ConfirmationResult confirmationResult;

  PhoneAuth({this.phoneNo});
//
  Future<void> nativeVerifyPhone(BuildContext context) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      final res = await auth.signInWithCredential(phoneAuthCredential);
      // Todo After Verification Complete
      Navigator.of(context).pop();
    };
//
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Auth Exception is ${authException.message}');
    };
//
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
    };
//
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };
//
    await auth.verifyPhoneNumber(
      // mobile no. with country code
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  nativeSignIn(context, {@required String smsOTP}) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      await auth.signInWithCredential(credential);

      // Todo After Verification Complete
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  void signout() {
    auth.signOut();
  }

  Future<void> webInitiateSignIn(BuildContext context) async {
    confirmationResult = await auth.signInWithPhoneNumber(
      phoneNo,
    );
  }

  Future<void> webSignInWithOTP(BuildContext context,
      {@required String smsOTP}) async {
    try {
      // UserCredential userCredential =
      await confirmationResult.confirm(smsOTP);

      // Todo After Verification Complete
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }
}
