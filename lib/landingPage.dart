import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'service_liff/globalLiffData.dart';
import 'components/welcome_message.dart';
import 'components/redirect_button.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter/services.dart';
import 'components/warning_card.dart';
import 'components/pageDetails_card.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String landmarkPictureUrl = GlobalLiffData.landmarkPictureUrl ?? '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: landmarkPictureUrl.isNotEmpty
                      ? Image.network(
                          landmarkPictureUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/eventMap.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      LandmarkdetailsCard(),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: RedirectButton(),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: WarningMessage(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3 - 40,
              left: 0,
              right: 0,
              child: Center(
                child: Material(
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    radius: 40,
                    foregroundImage: const AssetImage('assets/images/LOGO.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LandingPage extends StatefulWidget {
//   @override
//   State<LandingPage> createState() => _LandingPageState();
// }

// class _LandingPageState extends State<LandingPage>
//     with SingleTickerProviderStateMixin {
//   late Future<void> _initDataFuture;

//   @override
//   void initState() {
//     super.initState();
//     _initDataFuture = _initializeData();
//   }

//   Future<void> _initializeData() async {
//     await GlobalLiffData.getAllLiffData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: _initDataFuture,
//         builder: (context, snapshot) {
//           if (!GlobalLiffData.isInitialized) {
//             return Center(
//               child: CircularProgressIndicator(color: ThemeData().primaryColor),
//             );
//           } else {
//             String landmarkPictureUrl = GlobalLiffData.landmarkPictureUrl ?? '';
//             return Scaffold(
//               body: SingleChildScrollView(
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(
//                           width: double.infinity,
//                           height: MediaQuery.of(context).size.height * 0.3,
//                           child: landmarkPictureUrl.isNotEmpty
//                               ? Image.network(
//                                   landmarkPictureUrl,
//                                   fit: BoxFit.cover,
//                                 )
//                               : Image.asset(
//                                   'assets/images/eventMap.jpg',
//                                   fit: BoxFit.cover,
//                                 ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               LandmarkdetailsCard(),
//                               SizedBox(height: 10),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 6.0),
//                                 child: RedirectButton(),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: WarningMessage(),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                       top: MediaQuery.of(context).size.height * 0.3 -
//                           40, 
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: Material(
//                           elevation: 4,
//                           shape: const CircleBorder(),
//                           child: CircleAvatar(
//                             radius: 40,
//                             foregroundImage:
//                                 const AssetImage('assets/images/LOGO.png'),
//                             backgroundColor: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
