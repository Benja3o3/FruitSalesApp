import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/models/positionHistory.dart';
import 'package:latlong2/latlong.dart';

class TracePositionMarker extends StatefulWidget {
  final List<PositionHistory> tracePositions;
  const TracePositionMarker({required this.tracePositions, Key? key})
      : super(key: key);

  @override
  _TracePositionMarkerState createState() => _TracePositionMarkerState();
}

class _TracePositionMarkerState extends State<TracePositionMarker> {
  final List<Color> _routesColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
  ];
  @override
  Widget build(BuildContext context) {
    return PolylineLayer(
        polylines: widget.tracePositions
            .map((e) => Polyline(
                points: e.coordinates_list
                    .map((e) => LatLng(e['x']!, e['y']!))
                    .toList(),
                color: _routesColors[widget.tracePositions.indexOf(e)],
                strokeWidth: 4))
            .toList());
    // Polyline(
    //     points: widget.tracePositions,
    //     color: Colors.blue,
    //     strokeWidth: 4),

    ;
  }
}
