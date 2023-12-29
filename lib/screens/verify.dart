import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telephony/telephony.dart';
import '../utils/ui_styles.dart';

class MyVerify extends StatefulWidget {
  final String verificationId;
  final String phoneNo;
  const MyVerify(
      {required this.verificationId, required this.phoneNo, Key? key})
      : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> with TickerProviderStateMixin {
  String userOtp = '';
  Telephony telephony = Telephony.instance;
  OtpFieldController otpbox = OtpFieldController();
  late FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        String sms = message.body.toString();
        if (message.body!.contains('liveasy-assn.firebaseapp.com')) {
          String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
          otpbox.set(otpcode.split(""));
          setState((){});
        } else {
          print("error");
        }
      },
      listenInBackground: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verify Phone',
                style: headingTextStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Code is sent to ${widget.phoneNo}',
                style: subheadingTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              OTPTextField(
                outlineBorderRadius: 10,
                controller: otpbox,
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  userOtp = pin;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive the code? ',
                    style: subheadingTextStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Request Again',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2e3b62),
                    ),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: userOtp);
                        _auth.signInWithCredential(credential)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()),
                                  (route) => false);
                        });
                      } catch (exception) {
                        print(exception.toString());
                      }
                    },
                    child: const Text("VERIFY AND CONTINUE")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
