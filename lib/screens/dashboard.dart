import 'package:flutter/material.dart';
import 'package:liveasy_assn/utils/ui_styles.dart';
import 'package:liveasy_assn/utils/logoImage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int? selectedTileIndex;

  final List<Map<String, dynamic>> tileData = [
    {
      'heading': 'Shipper',
      'subheading': 'Lorem ipsum dolor sit amet, consectetur adipiscing',
      'imagePath': 'assets/shipper.png',
    },
    {
      'heading': 'Transporter',
      'subheading': 'Lorem ipsum dolor sit amet, consectetur adipiscing',
      'imagePath': 'assets/transporter.png',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please select your profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: tileData.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> data = tileData[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTileIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                        leading: Container(
                          padding: const EdgeInsets.all(3.0),
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedTileIndex == index
                                  ? const Color(0xFF2e3b62)
                                  : Colors.white,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            LogoImage(imagePath: data['imagePath']),
                            const SizedBox(width: 16.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['heading'],
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    data['subheading'],
                                    style: subheadingTextStyle,
                                    softWrap: true,
                                    maxLines: null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2e3b62),
                    ),
                    onPressed: () {
                      print('Button pressed');
                    },
                    child: const Text('CONTINUE')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
