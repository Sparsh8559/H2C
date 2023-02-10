import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapRoute extends StatefulWidget {
  const mapRoute({Key? key}) : super(key: key);

  @override
  State<mapRoute> createState() => _mapRouteState();
}

class _mapRouteState extends State<mapRoute> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kgoogleplex = const CameraPosition(
    target: LatLng(12.9716, 77.5946),
    zoom: 13,
  );

  Set<Marker> _markers = {};
  List<LatLng> _latlng = [
    LatLng(12.9716, 77.5946),
    LatLng(13.9716, 76.5946),
    LatLng(11.9716, 75.5946),
  ]; // lattitude and longitude
  Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
