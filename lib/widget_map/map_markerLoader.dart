import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../service_liff/globalLiffData.dart';
import 'map_info_window.dart';

class MarkerLoader {
  static Future<void> loadMarkers(
    BuildContext context,
    bool isIconLoaded,
    Set<Marker> markers,
  ) async {
    if (!isIconLoaded) {
      print('Loading markers...');
      return;
    }

    try {
      final allLandmarkDetails = GlobalLiffData.allLandmarkDetails;
      print('allLandmarkDetails: $allLandmarkDetails');
      if (allLandmarkDetails.isNotEmpty) {
        markers.clear();
        for (var item in allLandmarkDetails) {
          print('Processing item: $item');

          final id = item['id']?.toString() ?? 'default_id';
          final lat = item['position_lat']?.toString();
          final lng = item['position_lng']?.toString();
          final imageUrl = item['landmark_pictureUrl']?.toString();

          if (lat == null || lng == null) {
            print('Error: position_lat or position_lng is null');
            continue;
          }

          final position = LatLng(double.parse(lat), double.parse(lng));

          // **取得圖片並轉換成 BitmapDescriptor**
          BitmapDescriptor customIcon = await getCustomMarkerIcon(imageUrl);

          final marker = Marker(
            markerId: MarkerId(id),
            position: position,
            icon: customIcon,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return MapInfoWindow(
                    title: item['infoWindow_title']?.toString() ?? 'No Title',
                    snippet: item['infoWindow_snippet']?.toString() ?? 'No Description',
                  );
                },
              );
            },
          );
          markers.add(marker);
        }
      } else {
        print('Fail to load markers: allLandmarkDetails is empty');
      }
    } catch (e) {
      print('Loading error: $e');
    }
  }

  // 取得自訂標記圖片
  static Future<BitmapDescriptor> getCustomMarkerIcon(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      print("Error: Image URL is null or empty");
      return BitmapDescriptor.defaultMarker;
    }

    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List imageData = response.bodyBytes;
        return await createCircleAvatar(imageData);
      } else {
        print("Error: Failed to load image from $imageUrl");
        return BitmapDescriptor.defaultMarker;
      }
    } catch (e) {
      print("Error loading image: $e");
      return BitmapDescriptor.defaultMarker;
    }
  }

  // 建立圓形 Avatar 圖片
  static Future<BitmapDescriptor> createCircleAvatar(Uint8List imageData) async {
    final ui.Codec codec = await ui.instantiateImageCodec(imageData, targetWidth: 100);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final Paint paint = Paint()..isAntiAlias = true;
    final double radius = 50; // 設定圓形大小

    final Rect rect = Rect.fromLTWH(0, 0, radius * 2, radius * 2);
    canvas.clipPath(Path()..addOval(rect));
    canvas.drawImage(image, Offset(0, 0), paint);

    final ui.Image finalImage = await recorder.endRecording().toImage(100, 100);
    final ByteData? byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
  }
}
