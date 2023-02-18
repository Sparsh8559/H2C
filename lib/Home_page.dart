import 'dart:async';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:h2c/brain/pointerclass.dart';
import 'package:h2c/map.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final storage = new FlutterSecureStorage();
  // List<Pinter> pointerList = [];



Future<List<Pinter>> getLocationDetails(String date) async {
  List<Pinter> pointerList=[];
      String? AccessTokenStored = await storage.read(key: 'accessToken');
  if (AccessTokenStored == "") {
      // print('Error in access token storate only******************');
      Navigator.pushReplacementNamed(context, 'login');
      return pointerList;
    } else {
      final message = jsonEncode({'calculated_date': date.substring(0,10)});
            final response = await http.post(
        Uri.parse(
            'http://52.66.31.173/address/csvDetails/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $AccessTokenStored'
        },
    body: message,
      );


      if (response.statusCode == 200) {
        Map<String,dynamic> data = json.decode(response.body);
        // print(data);
        List dataList = data['resp'];
        // print(dataList);
        dataList.forEach((element) async{
          var latitude = element['location']['latitude'];
          var longitude = element['location']['longitude'];
          var address = element['location']['address'];
          Pinter specPointer = Pinter(address: address, longitude: longitude, latitude: latitude);
          // print(specPointer);
          pointerList.add(specPointer);
        });
        return pointerList;
      } 
      else {
        storage.delete(key: 'accessToken');
        storage.delete(key: 'email');
        Navigator.pushReplacementNamed(context, 'login');
        return pointerList;
      }

    }


}


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
                                      List<Pinter> pointerList = await getLocationDetails(datepicked);
                                      pointerList.forEach((element) { print(element.address);});
                                      // ignore: use_build_context_synchronously
                                     Navigator.push(context, 
       MaterialPageRoute(builder: (context) => mapRoute(pointerList: pointerList)));
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
