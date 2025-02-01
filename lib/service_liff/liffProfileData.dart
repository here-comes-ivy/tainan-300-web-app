import 'globalLiffData.dart';
import 'package:flutter/material.dart';

class LiffProfileData extends StatelessWidget {
  late final String profile;
  late final String displayName;
  late final String userId;

  LiffProfileData() {
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    final profileData = await GlobalLiffData.liffInstance.profile;
    displayName = profileData.displayName;
    userId = profileData.userId;
  }

  Future<String> _getDisplayName() async {
    await _initializeProfile();
    return displayName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getDisplayName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String displayName = snapshot.data ?? 'Not available';
          String userId = this.userId ?? 'User 1';

          return Text(
            'DisplayName: $displayName\n\n'
            'UserId: $userId\n\n'
          );
        }
      },
    );
  }
}