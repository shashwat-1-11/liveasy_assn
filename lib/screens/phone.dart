import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/ui_styles.dart';
import 'verify.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  String selectedCountryCode = '+91';
  String phoneNo = '';
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();

  late FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    phoneNumberFocus.addListener(updatePhoneNumber);
  }

  void updatePhoneNumber() {
    setState(() {
      phoneNo = selectedCountryCode + phoneNumberController.text;
    });
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
            Icons.close,
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
              Text('Please Enter your Mobile Number', style: headingTextStyle, textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Text(
                  'You will receive a 6 digit code\n to verify next', style: subheadingTextStyle, textAlign: TextAlign.center),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CountryCodePicker(
                        onChanged: (CountryCode? countryCode) {
                          setState(() {
                            selectedCountryCode = countryCode?.dialCode ?? '';
                          });
                          updatePhoneNumber();
                        },
                        initialSelection: 'IN',
                        favorite: const ['+91', 'IN'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        enabled: true,
                        hideMainText: false,
                        showFlagMain: true,
                        showFlag: true,
                        showFlagDialog: true,
                        hideSearch: false,
                        padding: const EdgeInsets.all(1.0),
                        alignLeft: true,
                      ),
                    ),
                    const Text("-", style: TextStyle(fontSize: 25)),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        onChanged: (String value) {
                          updatePhoneNumber();
                        },
                        controller: phoneNumberController,
                        focusNode: phoneNumberFocus,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile Number',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2e3b62),
                  ),
                  onPressed: () async {
                    _auth.verifyPhoneNumber(
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          print('Verification Completed');
                        },
                        verificationFailed:
                            (FirebaseAuthException authException) {
                          print(
                              'Verification Failed: ${authException.message}');
                        },
                        codeSent: (String verificationId, int? resendToken) async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyVerify(verificationId: verificationId, phoneNo: phoneNo),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          print('Auto Retrieval Timeout');
                        },
                        phoneNumber: phoneNo);
                  },
                  child: const Text("CONTINUE"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
