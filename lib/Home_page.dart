import 'dart:ui';

import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
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
                    Text('Hi,\nUser',style: TextStyle(color: Colors.deepPurple,fontSize: 26),),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Select Date',style:TextStyle(fontSize: 20),)
                      ],
                    ),
                    Column(
                  children:[ ElevatedButton(onPressed: ()async {
                      DateTime? datePicked= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2024));
                    }, child: Text('Date'))]),
                    Column(
                      children: [
                        ElevatedButton(onPressed: (){}, child: Text('Logout'))
                      ],
                    )

                  ]

                ),

              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/message-130659740-14367398737171749148.jpg'), fit: BoxFit.cover
                    )
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: (){
                          Navigator.pushNamed(context, 'map');
                        }, child: Text('Get Map'))
                      ],
                    ),
                  )
                ),

                )


              ),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){}, child: Text('Download'))
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
