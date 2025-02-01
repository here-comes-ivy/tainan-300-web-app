import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapwidgetTest extends StatefulWidget {
  const MapwidgetTest({super.key});

  @override
  State<MapwidgetTest> createState() => _MapwidgetTestState();
}

class _MapwidgetTestState extends State<MapwidgetTest> {
  static const LatLng _center = LatLng(22.990808966544325, 120.19974816980327);
  final Set<Marker> _markers = {};
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: _center,
                          zoom: 15,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        // onMapCreated: (GoogleMapController controller) {
                        //   if (_markers.isEmpty) {
                        //     _loadMarkers();
                        //   }
                        // },
                      ),
                      if (_markers.isEmpty)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}