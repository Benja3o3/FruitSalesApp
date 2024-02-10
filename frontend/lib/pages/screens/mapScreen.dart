import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng _currentPosition =
      LatLng(-39.53851450375843, -72.96117966078549);
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: FlutterMap(
              mapController: mapController,
              options:
                  MapOptions(initialCenter: _currentPosition, initialZoom: 17),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<fruitProvider>().clearFruit();
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Text("go back home")),
                ),
              ]),
        ),
      ],
    );
  }
}
