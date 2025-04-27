import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_ios_workouts/flutter_ios_workouts.dart';

class MapWidget extends StatefulWidget {
  final List<Location> path;

  const MapWidget({super.key, required this.path});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var initialCenter = const LatLng(47.3769, 8.5417); // Default fallback
    var initialZoom = 15.0; // Zoom out more if path is empty

    if (widget.path.isNotEmpty) {
      initialCenter = LatLng(widget.path.first.latitude, widget.path.first.longitude);
      initialZoom = 15.0; // Zoom in more if path is not empty

      _mapController.move(initialCenter, initialZoom);
    }

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: initialCenter,
          initialZoom: initialZoom,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.doubleTapZoom |
                InteractiveFlag.drag |
                InteractiveFlag.pinchMove |
                InteractiveFlag.pinchZoom,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),

          if( widget.path.isNotEmpty ) PolylineLayer(
            polylines: [
              Polyline(
                points: widget.path.map((location) => LatLng(location.latitude, location.longitude)).toList(),
                color: Colors.blue,
                strokeWidth: 4.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
