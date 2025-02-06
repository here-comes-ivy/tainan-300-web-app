import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart' as line_liff;
import 'service_liff/globalLiffData.dart';
import 'components/checkIn_message.dart';
import 'components/redirect_button.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter/services.dart';
import 'components/warning_message.dart';

class MaplessPage extends StatefulWidget {
  @override
  State<MaplessPage> createState() => _MaplessPageState();
}

class _MaplessPageState extends State<MaplessPage> {
  late Future<void> _initDataFuture;
  @override
  void initState() {
    super.initState();
    _initDataFuture = _initializeData();
  }

  Future<void> _initializeData() async {
    await GlobalLiffData.getAllLiffData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initDataFuture,
        builder: (context, snapshot) {
          if (!GlobalLiffData.isInitialized) {
            return Center(child: CircularProgressIndicator());
          } else {
            final String userName = GlobalLiffData.userName ?? '匿名用戶';
            final String userPhoto = GlobalLiffData.userPhotoUrl ??
                'assets/images/defaultProfilePic.png';
            final String password = GlobalLiffData.password ?? '未知密碼';

            return Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    foregroundImage:
                        AssetImage('assets/images/defaultProfilePic.png'),
                  ),
                ),
                title: Text('「一府 x iF」遊城活動打卡'),
                shape: Border(
                    bottom: BorderSide(color: Colors.blueGrey, width: 2)),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Image.asset('assets/images/iF300eventMap.jpg',
                            height: 280, width: double.infinity),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 10,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  child: RedirectButton(),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: WarningMessage(),
                                ),
                              )
                            ],
                          ),
                        ),
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
