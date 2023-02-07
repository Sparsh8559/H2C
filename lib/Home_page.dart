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


                  ],

                ),

              ),
            ),
            Expanded(
              flex: 4,
              child: Container(


              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(

                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
