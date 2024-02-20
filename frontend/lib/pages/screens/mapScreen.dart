import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/api/positionQuerys.dart';
import 'package:frontend/library/animated_map_controller.dart';
import 'package:frontend/models/position.dart';
import 'package:frontend/models/positionHistory.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/widgets/mapButton.dart';
import 'package:frontend/widgets/mapMarkers.dart';
import 'package:frontend/widgets/tracePositionMarker.dart';
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

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  bool isAdded = false;
  int _partnerIndex = 0;
  LatLng? _vanCurrentPosition;
  late final _animatedMapController = AnimatedMapController(vsync: this);
  List<Position> _positions = [];
  List<PositionHistory> _positionHistory = [];
  LatLng? _currentPosition;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    print(widget.user_id);
    print(widget.working_day_id);
    getCurrentPosition();
    getPositions();
    getPositionHistory();
    location.onLocationChanged.listen((LocationData xd) {
      setState(() {
        _currentPosition = LatLng(xd.latitude!, xd.longitude!);
      });
      if (!isAdded) {
        addPosition();
      }
      updatePosition();
      addPositionHistory();
      getPositions();
      getPositionHistory();
    });
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

  void getPositions() async {
    try {
      final response =
          await PositionQuerys().getPositions(widget.working_day_id);
      print(response);
      double? vanLatitude = response
          .firstWhere((position) => position.type == "camioneta")
          .latitude;
      double? vanLongitude = response
          .firstWhere((position) => position.type == "camioneta")
          .longitude;
      _vanCurrentPosition = LatLng(vanLatitude, vanLongitude);
      setState(() {
        _positions = response;
      });
    } catch (e) {
      print("ERROR EN GETPOSITIONS FUNCTION: $e");
    }
  }

  void getCurrentPosition() async {
    try {
      LocationData xd = await getLocation();
      setState(() {
        _currentPosition = LatLng(xd.latitude!, xd.longitude!);
      });
    } catch (e) {
      print("ERROR EN GETCURRENTPOSITION FUNCTION: $e");
    }
  }

  void addPosition() async {
    if (_currentPosition == null) {
      return;
    }
    try {
      await PositionQuerys().addPosition(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        widget.user_id,
        widget.working_day_id,
      );
      setState(() {
        isAdded = true;
      });
    } catch (e) {
      print("ERROR EN ADDPOSITION FUNCTION: $e");
    }
  }

  void updatePosition() async {
    if (_currentPosition == null) {
      return;
    }
    try {
      await PositionQuerys().updatePosition(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        widget.user_id,
        widget.working_day_id,
      );
    } catch (e) {
      print("ERROR EN UPDATEPOSITION FUNCTION: $e");
    }
  }

  void getPositionHistory() async {
    try {
      final response =
          await PositionQuerys.getPositionHistory(widget.working_day_id);
      setState(() {
        _positionHistory = response;
      });
    } catch (e) {
      print("ERROR EN GETPOSITIONHISTORY FUNCTION: $e");
    }
  }

  void addPositionHistory() async {
    if (_currentPosition == null) {
      return;
    }
    try {
      await PositionQuerys().addPositionHistory(
        [_currentPosition!.latitude, _currentPosition!.longitude],
        widget.user_id,
        widget.working_day_id,
      );
    } catch (e) {
      print("ERROR EN ADDPOSITIONHISTORY FUNCTION: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _currentPosition == null
          ? const CircularProgressIndicator()
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                FlutterMap(
                    mapController: _animatedMapController.mapController,
                    options: MapOptions(
                        initialCenter: _currentPosition!, initialZoom: 17),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                      ),
                      TracePositionMarker(tracePositions: _positionHistory),
                      MapMarkers(
                          currentPosition: _currentPosition,
                          positions: _positions)
                    ]),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                  right: 20,
                  child: Column(
                    children: [
                      MapButton(
                          color: Colors.red,
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            // mapController.
                          }),
                      MapButton(
                          color: Colors.blue,
                          icon: Icon(Icons.center_focus_weak),
                          onPressed: () {
                            _animatedMapController.animateTo(
                                dest: _currentPosition!, zoom: 17);
                            // mapController.
                          }),
                      MapButton(
                          color: Colors.blue,
                          icon: Icon(Icons.fire_truck),
                          onPressed: () {
                            _animatedMapController.animateTo(
                                dest: _vanCurrentPosition!, zoom: 17);
                            // mapController.
                          }),
                      MapButton(
                          color: Colors.green,
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            _positions.length > 0
                                ? _animatedMapController.animateTo(
                                    dest: _positions
                                            .where((element) =>
                                                element.user_id !=
                                                Provider.of<userProvider>(context, listen: false)
                                                    .id)
                                            .toList()
                                            .isEmpty
                                        ? _currentPosition
                                        : LatLng(
                                            _positions
                                                .where((element) =>
                                                    element.user_id !=
                                                    Provider.of<userProvider>(context,
                                                            listen: false)
                                                        .id)
                                                .toList()[_partnerIndex]
                                                .latitude,
                                            _positions
                                                .where((element) =>
                                                    element.user_id !=
                                                    Provider.of<userProvider>(context, listen: false).id)
                                                .toList()[_partnerIndex]
                                                .longitude),
                                    zoom: 17)
                                : _animatedMapController.animateTo(dest: _currentPosition!, zoom: 17);
                            setState(() {
                              _partnerIndex++;
                              if (_partnerIndex >=
                                  _positions
                                      .where((element) =>
                                          element.user_id !=
                                          Provider.of<userProvider>(context,
                                                  listen: false)
                                              .id)
                                      .toList()
                                      .length) {
                                _partnerIndex = 0;
                              }
                            });

                            // mapController.
                          })
                    ],
                  ),
                )
              ]),
            ),
    );
  }
}
