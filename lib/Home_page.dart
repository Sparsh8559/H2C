import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi,\nUser',
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 26),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Select Date',
                              style: TextStyle(fontSize: 20),)
                        ],
                        // 2023/02/11
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  DateTime? datePicked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2024));
                                      print(datePicked.toString());
                                      String datepicked=datePicked.toString().substring(0,4)+'/'+datePicked.toString().substring(5,7)+'/'+datePicked.toString().substring(8);

                                },
                                child: Text('Date'),
                                )
                          ]),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                try {
                                  await storage.delete(key: 'accessToken');
                                  await storage.delete(key: 'email');
                                  Navigator.pushNamed(context, 'login');
                                } catch (e) {
                                  print("Unsuccessful SignOUt");
                                  print(e);
                                }
                              },
                              child: Text('Logout'))
                        ],
                      )
                    ]),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/WhatsApp Image 2023-02-10 at 23.03.59.jpg'),
                          fit: BoxFit.cover)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'map');
                          },
                          child: Text('Get Map'))
                    ],
                  )),
                )),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Download'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
