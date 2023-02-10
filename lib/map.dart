import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h2c/brain/pointerclass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class mapRoute extends StatefulWidget {
    final List<Pinter> pointerList;
  const mapRoute({Key? key, required this.pointerList}) : super(key: key);

  @override
  State<mapRoute> createState() => _mapRouteState();
}

class _mapRouteState extends State<mapRoute> {
  Completer<GoogleMapController> _controller = Completer();


// void LatLangAdder(List<Pinter> pointerList){
 
// }

  static final CameraPosition _kgoogleplex = const CameraPosition(
    target: LatLng(12.9716, 77.5946),
    zoom: 13,
  );

  Set<Marker> _markers = {};
  List<LatLng> _latlng = []; // lattitude and longitude
  Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
    // LatLangAdder(pointerList);




  }




// Future<void> getDriverMarkers() async {
//     // String AccessTokenStored = await storage.read(key: 'accessToken');
//     String AccessTokenStored = "15d1dcbbe887742f5b4a7c8f3276161bb9075a63";
//     if (AccessTokenStored == "") {
//       // print('Error in access token storate only******************');
//       Navigator.pushReplacementNamed(context, 'login');
//     } else {
//       final response = await http.post(
//         Uri.parse(
//             'https://52.66.31.173/address/csvDetails/'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Token $AccessTokenStored'
//         },
//         body: {
//           'calculated_date': '2023/02/12'
//         },
//       );

//       if (response.statusCode == 200) {
//         // print(response.body);
//         List<dynamic> data = json.decode(response.body);
//         // Set<Circle> _circles = Set<Circle>();
//         print("Is this functioning even bing called *************************");
//         data.forEach((element) async{
//           var nameS = element['name'];
//           var latitudeS = element['latitude'];
//           var longitudeS = element['longitude'];
//           var radiuS = element['radius'];
//           // print('*******************************************$nameS***************************************' );
//           var huecolor = BitmapDescriptor.hueRed;
//           print("Is this function even functioning");
//           var adder = await addCircleMarker(latitudeS, longitudeS, nameS, huecolor);
//           _markers1.add(adder);
//           //  _markers1.add(addMarkers(latitudeS, longitudeS, nameS, huecolor));
//                 //  print("Loop running Successfully **************************************");
//         });
//         setState(() {});
//                 // print(_circles);

//                   //         List<CheckPostInfo> CPList = [];
//                 //         CPList.add(CheckPostInfo.fromJson(jsonDecode(response.body)));
//                 // print(CPList);

//         // basially iterate through the elements of the resopnse.body, and pass circle
//         // _circles.add(addCircles(latitudeS, longitudeS, radiuS, nameS, huecolor));

//       } else {
//         // print("There is Some error in the return of that checkpost details function**********************************************");
//         // storage.delete(key: 'accessToken');
//         // storage.delete(key: 'email');
//         // Navigator.pushNamed(context, SignInScreen.routeName);
//       }
//     }
//   }








  @override
  Widget build(BuildContext context) {
    
      widget.pointerList.forEach((element) {
      LatLng latter = LatLng(element.latitude, element.longitude);
      _latlng.add(latter);
    });



    for (int i = 0; i < _latlng.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latlng[i],
        infoWindow: InfoWindow(title: 'title'),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(
          polylineId: PolylineId('1'),
          points: _latlng,
          color: Colors.blueAccent,
          width: 10));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Route Polygon',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kgoogleplex,
          markers: _markers,
          onMapCreated: (GoogleMapController Controller) {
            _controller.complete(Controller);
          },
          polylines: _polyline,
          myLocationEnabled: true,
          compassEnabled: true,
        ),
      ),
    );
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.location_disabled_outlined),
      //   onPressed: ()async{
      //     GoogleMapController Controller =await _controller.future;
      //     Controller.animateCamera(CameraUpdate.newCameraPosition(
      //       CameraPosition(target: LatLng(12.9716,  77.5946),
      //       zoom: 13)
      //     ));
      //     setState(() {
      //
      //     });
      //   },
      // ),
    // );
  }
}
