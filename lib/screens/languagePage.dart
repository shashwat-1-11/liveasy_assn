import 'package:flutter/material.dart';
import '../utils/logoImage.dart';
import '../utils/ui_styles.dart';
import 'phone.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoImage(imagePath: 'assets/lang.png'),
              const SizedBox(height: 32.0),
              Text('Please select your Language',
                  style: headingTextStyle, textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Text('You can change the language at any time',
                  style: subheadingTextStyle),
              const SizedBox(height: 16.0),
              buildDropDownMenu(),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.6,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2e3b62),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyPhone()));
                  },
                  child: const Text('NEXT'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDropDownMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      width: MediaQuery.of(context).size.width / 1.6,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        value: selectedLanguage,
        icon: const SizedBox.shrink(),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? newValue) {
          setState(() {
            selectedLanguage = newValue!;
          });
        },
        items: <String>['English', 'Spanish', 'French', 'German']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
