import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'service_liff/globalLiffData.dart';
import 'components/checkIn_message.dart';
import 'components/redirect_button.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter/services.dart';
import 'components/warning_message.dart';
import 'components/sendMessage_button.dart';
import 'components/landmarkDetails_card.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
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
            return Center(
              child: CircularProgressIndicator(color: ThemeData().primaryColor),
            );
          } else {
            final String userName = GlobalLiffData.userName ?? '匿名用戶';
            final String userPhoto =
                GlobalLiffData.userPhotoUrl ?? 'assets/images/LOGO.png';

            return Scaffold(
              appBar: AppBar(
                title: Text('「一府 x iF」遊城活動打卡'),
                leading: Image.asset('assets/images/LOGO.png'),
                surfaceTintColor: Colors.white,
                
                shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                elevation: 4,
              ),
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
                        LandmarkdetailsCard(),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Row(
                            children: [
                              GlobalLiffData.isSendMessage == true
                                  ? Expanded(child: SendMessageButton())
                                  : Expanded(child: RedirectButton()),
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
