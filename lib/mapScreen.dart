import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? currentPosition;
  Location location = Location();
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    location.onLocationChanged.listen((LocationData xd) {
      setState(() {
        currentPosition = LatLng(xd.latitude!, xd.longitude!);
        print("LISTENER MAP");
      });
    });
    getCurrentPosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<LocationData> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error("Error: Servicio de ubicación no habilitado.");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error("Error: Permiso de ubicación denegado.");
      }
    }

    return await location.getLocation();
  }

  void getCurrentPosition() async {
    try {
      LocationData xd = await getLocation();
      setState(() {
        currentPosition = LatLng(xd.latitude!, xd.longitude!);
      });
      print("Latitude: ${xd.latitude}");
      print("Longitude: ${xd.longitude}");
    } catch (e) {
      print("Error al obtener la ubicación: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: currentPosition == null
          ? CircularProgressIndicator()
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        initialCenter: currentPosition!, initialZoom: 17),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                      ),
                      MarkerLayer(markers: [
                        Marker(
                          point: currentPosition!,
                          alignment: const Alignment(-0.5, -2),
                          child: const Icon(
                            Icons.person_pin_circle,
                            color: Color.fromARGB(255, 1, 48, 255),
                            size: 50,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (currentPosition != null)
                        mapController.move(currentPosition!, 17);
                    },
                    child: Text("Centrar Mapa"))
              ],
            ),
    );
  }
}
