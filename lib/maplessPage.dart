import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'service_liff/globalLiffData.dart';
import 'components/checkIn_message.dart';
import 'components/redirect_button.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter/services.dart';
import 'components/warning_message.dart';
import 'components/sendMessage_button.dart';
import 'package:lottie/lottie.dart';

class MaplessPage extends StatefulWidget {
  @override
  State<MaplessPage> createState() => _MaplessPageState();
}

class _MaplessPageState extends State<MaplessPage>
    with SingleTickerProviderStateMixin {
  late Future<void> _initDataFuture;

  bool _showAnimation = true; // 控制動畫顯示
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initDataFuture = _initializeData();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // 設置動畫持續時間
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showAnimation = false; // 動畫完成後隱藏
        });
      }
    });
  }

  Future<void> _initializeData() async {
    await GlobalLiffData.getAllLiffData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initDataFuture,
        builder: (context, snapshot) {
          if (!GlobalLiffData.isInitialized) {
            return Center(
              child: CircularProgressIndicator(color: ThemeData().primaryColor),
            );
          } else {
            final String userName = GlobalLiffData.userName ?? '匿名用戶';
            final String userPhoto = GlobalLiffData.userPhotoUrl ??
                'assets/images/defaultProfilePic.png';

            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0,
                    vertical:
                        MediaQuery.of(context).size.width > 600 ? 40.0 : 16.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start, // 改為從頂部開始排列
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              foregroundImage: NetworkImage(userPhoto),
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            Text(
                              userName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        CheckinMessage(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Row(
                            children: [
                              if (GlobalLiffData.isInclient == true) ...[
                                Expanded(child: RedirectButton()),
                                Expanded(child: SendMessageButton()),
                              ] else ...[
                                Expanded(child: RedirectButton()),
                              ],
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: WarningMessage(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
