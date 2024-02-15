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
  @override
  Widget build(BuildContext context) {
    return MarkerLayer(markers: [
      Marker(
        point: widget.currentPosition!,
        alignment: const Alignment(-0.5, -2),
        child: const Icon(
          Icons.person_pin_circle,
          color: Color.fromARGB(255, 1, 48, 255),
          size: 50,
        ),
      ),
      ...widget.positions
          .map((e) => Marker(
                point: LatLng(e.latitude, e.longitude),
                alignment: const Alignment(-0.5, -2),
                child: const Icon(
                  Icons.person_pin_circle,
                  color: Color.fromARGB(255, 1, 48, 255),
                  size: 50,
                ),
              ))
          .toList()
    ]);
  }
}