import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'map_info_window.dart';
import 'map_addressTextField.dart';
import 'package:explore_tainan_web/service_liff/globalLiffData.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Set<Marker> _markers = {};
  static const LatLng _center = LatLng(22.990808966544325, 120.19974816980327);
  Map<PolylineId, Polyline> _polylines = {};

  BitmapDescriptor? markerIcon;
  bool _isIconLoaded = false;
  var marker_attraction;
  var marker_store;
  var marker_home;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initializeMap() async {
    try {
      await _loadIcon();
      await _loadMarkers();
      _addPolyline();
    } catch (e) {
      print('Error when initializing map: $e');
    }
  }

  void _addPolyline() {
    final PolylineId polylineId = PolylineId('polyline_id');
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: const Color(0xFFCBAA39),
      points: [
        LatLng(23.006606027301125, 120.19986590700486),
        LatLng(22.99125223276316, 120.19161025486223),
        LatLng(22.981747576065388, 120.19736115612643),
        LatLng(22.981814365276634, 120.21355961991738),
        LatLng(22.992572672797248, 120.21829548484772),
        LatLng(22.996931183000385, 120.21511531164586),
        LatLng(23.006606027301125, 120.19986590700486),
      ],
      width: 5,
    );

    setState(() {
      _polylines[polylineId] = polyline;
    });
  }

  Future<void> _loadIcon() async {
    try {
      marker_attraction = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(25, 25)),
        'assets/images/marker_attraction.png',
      );
      marker_store = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(25, 25)),
        'assets/images/marker_store.png',
      );
      marker_home = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(25, 25)),
        'assets/images/marker_home.png',
      );
      _isIconLoaded = true;
      setState(() {});
    } catch (e) {
      print('Error when loading icon: $e');
      markerIcon = BitmapDescriptor.defaultMarker;
      _isIconLoaded = true;
      setState(() {});
    }
  }

  Future<void> _loadMarkers() async {
    if (!_isIconLoaded) {
      print('Loading markers...');
      return;
    }

    try {
      final allLandmarkDetails = GlobalLiffData.allLandmarkDetails;

      if (allLandmarkDetails.isNotEmpty) {
        final List<dynamic> data = allLandmarkDetails;

        setState(() {
          _markers.clear();
          for (var item in data) {
            final position = LatLng(
              double.parse(item['position_lat'].toString()),
              double.parse(item['position_lng'].toString()),
            );

            final markerType = item['marker_type'];

            final marker = Marker(
              markerId: MarkerId(item['markerId']),
              position: position,
              // icon: markerType == 'home'
              //     ? marker_home
              //     : markerType == 'store'
              //         ? marker_store
              //         : markerType == 'attraction'
              //             ? marker_attraction
              //             : BitmapDescriptor.defaultMarker,

              // infoWindow: InfoWindow(
              //   title: item['infoWindow_title'],
              //   snippet: item['infoWindow_snippet'],
              // ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return MapInfoWindow(
                      title: item['infoWindow_title'],
                      snippet: item['infoWindow_snippet'],
                    );
                  },
                );
              },
            );
            _markers.add(marker);
          }
        });
      } else {
        print('Fail to load markers: allLandmarkDetails is empty');
      }
    } catch (e) {
      print('Loading error: $e');
    }
  }

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
                        polylines: Set<Polyline>.of(_polylines.values),
                        markers: _markers,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          if (_markers.isEmpty) {
                            _loadMarkers();
                          }
                        },
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
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: AddressTextField(),
            ),

          ],
        ),
      ),
    );
  }
}
