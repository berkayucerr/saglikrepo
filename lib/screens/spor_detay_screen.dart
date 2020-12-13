import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SporDetay extends StatefulWidget {
  @override
  _SporDetayState createState() => _SporDetayState();
}

class _SporDetayState extends State<SporDetay> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  GoogleMapController controller;

  List<LatLng> latlngSegment1 = List();

  LatLng _lat1;
  LatLng _lastMapPosition;
  Position currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          //that needs a list<Polyline>
          polylines: _polyline,
          markers: _markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _lastMapPosition,
            zoom: 11.0,
          ),
          mapType: MapType.normal,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Awesome Polyline tutorial',
          snippet: 'This is a snippet',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment1,
        width: 2,
        color: Colors.blue,
      ));
    });
  }
}
