import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Location location = new Location();

  LatLng? currentPosition;

  // Future<LocationData> getLocation() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return Future.error("error");
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return Future.error("error");
  //     }
  //   }

  //   return await location.getLocation();
  // }

  Future<Position> getPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("error");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentPosition() async {
    Position position = await getPosition();
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
    // LocationData xd = await getLocation();
    print(position.latitude);
    print(position.longitude);
    // print(xd);
  }

  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: currentPosition == null
          ? CircularProgressIndicator()
          : FlutterMap(
              options:
                  MapOptions(initialCenter: currentPosition!, initialZoom: 17),
              children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    // Plenty of other options available!
                  ),
                  MarkerLayer(markers: [
                    Marker(
                        point: currentPosition!,
                        alignment: const Alignment(-0.5, -2),
                        child: const Icon(
                          Icons.person_pin_circle,
                          color: Color.fromARGB(255, 1, 48, 255),
                          size: 50,
                        ))
                  ])
                ]),
    );
  }
}
