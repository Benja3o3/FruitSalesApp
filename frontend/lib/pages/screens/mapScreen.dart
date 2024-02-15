import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/api/positionQuerys.dart';
import 'package:frontend/models/position.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:frontend/widgets/mapButton.dart';
import 'package:frontend/widgets/mapMarkers.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  final int user_id;
  final working_day_id;
  const MapScreen(
      {required this.working_day_id, required this.user_id, Key? key})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Position> _positions = [];
  LatLng? _currentPosition;
  late MapController mapController;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    getCurrentPosition();
    getPositions();
    location.onLocationChanged.listen((LocationData xd) {
      getPositions();
      setState(() {
        _currentPosition = LatLng(xd.latitude!, xd.longitude!);
      });
    });
  }

  void getPositions() async {
    final response = await PositionQuerys.getPositions(996575);
    setState(() {
      _positions = response;
    });
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
        _currentPosition = LatLng(xd.latitude!, xd.longitude!);
      });
    } catch (e) {}
  }

  void addPosition() async {
    await PositionQuerys().addPosition(_currentPosition!.latitude,
        _currentPosition!.longitude, widget.user_id, 996575);
  }

  void updatePosition() async {
    await PositionQuerys().updatePosition(_currentPosition!.latitude,
        _currentPosition!.longitude, widget.user_id, 996575);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: _currentPosition == null
          ? const SizedBox(
              height: 100, width: 100, child: CircularProgressIndicator())
          : Stack(children: [
              FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                      initialCenter: _currentPosition!, initialZoom: 17),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MapMarkers(
                        currentPosition: _currentPosition,
                        positions: _positions)
                  ]),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                right: 20,
                child: Column(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("Center")),
                    IconButton(onPressed: () {}, icon: Icon(Icons.traffic)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.traffic)),
                    MapButton(
                        icon: Icon(Icons.center_focus_weak),
                        onPressed: () {
                          mapController.move(_currentPosition!, 17);
                        })
                  ],
                ),
              )
            ]),
    );
  }
}
