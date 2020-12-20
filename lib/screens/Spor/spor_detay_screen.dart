import 'package:asistan_saglik/dosyalar/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SporDetay extends StatefulWidget {
  List<Location> _liste;
  SporDetay(List<Location> liste ){
    this._liste=liste;
  }
  @override
  _SporDetayState createState() => _SporDetayState(_liste);
}

class _SporDetayState extends State<SporDetay> {
  List<Location> _liste;

  _SporDetayState(List<Location> liste){
    this._liste=liste;
  }
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  GoogleMapController controller;

  List<LatLng> latlngSegment1 = List();

  LatLng _lat1;
  LatLng _lastMapPosition;
  Position currentPosition;
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _liste.length; i++) {
    latlngSegment1.add(new LatLng(_liste[i].lati,_liste[i].longti));  
    }
    _lat1=latlngSegment1[0];
    _lastMapPosition=latlngSegment1[latlngSegment1.length-1];
    
  }

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
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Bitiş Noktası',
          snippet: 'Aktivite bitiş noktası',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: latlngSegment1,
        width: 3,
        color: Colors.orange,
      ));
    });
  }
}
