import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/models/position.dart';
import 'package:latlong2/latlong.dart';

class MapMarkers extends StatefulWidget {
  final List<Position> positions;
  final LatLng? currentPosition;
  const MapMarkers(
      {required this.currentPosition, required this.positions, Key? key})
      : super(key: key);

  @override
  _MapMarkersState createState() => _MapMarkersState();
}

class _MapMarkersState extends State<MapMarkers> {
  final List<Color> _markerColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
  ];
  @override
  Widget build(BuildContext context) {
    return MarkerLayer(markers: [
      ...widget.positions
          .map((e) => Marker(
                point: LatLng(e.latitude, e.longitude),
                alignment: const Alignment(-0.5, -2),
                child: Icon(
                  e.type == "vendedor"
                      ? Icons.person_pin_circle
                      : Icons.car_crash,
                  color: _markerColors[e.user_id],
                  size: 50,
                ),
              ))
          .toList()
    ]);
  }
}
