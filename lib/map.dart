import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapRoute extends StatefulWidget {
  const mapRoute({Key? key}) : super(key: key);

  @override
  State<mapRoute> createState() => _mapRouteState();
}

class _mapRouteState extends State<mapRoute> {
  Completer<GoogleMapController> _controller=Completer();

  static final CameraPosition _kgoogleplex = const CameraPosition(target:
  LatLng(12.9716,  77.5946),
  zoom: 13,);
  List<Marker> _marker =[];
  List<Marker> _list =[
    Marker(markerId: MarkerId('1'),
    position: LatLng(12.9716,  77.5946),
    infoWindow: InfoWindow(title: 'Current Location'))
  ];

  @override
  void initState(){
    super.initState();
    _marker.addAll(_list);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kgoogleplex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController Controller){
          _controller.complete(Controller);
        },
        myLocationEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
