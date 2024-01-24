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
  List<LatLng> tracePositions = [];
  Location location = Location();
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    location.onLocationChanged.listen((LocationData xd) {
      setState(() {
        currentPosition = LatLng(xd.latitude!, xd.longitude!);
        tracePositions.add(LatLng(xd.latitude!, xd.longitude!));
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
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: currentPosition == null
          ? CircularProgressIndicator()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.7,
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
                      PolylineLayer(polylines: [
                        Polyline(
                            points: tracePositions,
                            color: Colors.blue,
                            strokeWidth: 4)
                      ]),
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
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (currentPosition != null)
                              mapController.move(currentPosition!, 17);
                          },
                          child: Text("Centrar Mapa")),
                      ElevatedButton(
                          onPressed: () {
                            if (currentPosition != null)
                              mapController.move(currentPosition!, 17);
                          },
                          child: Text("Buscar Camioneta")),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
