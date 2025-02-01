import 'package:flutter/material.dart';
import 'landingPage_liffInfo.dart';

class LiffInfoButton extends StatefulWidget {
  const LiffInfoButton({super.key});

  @override
  State<LiffInfoButton> createState() => _LiffInfoButtonState();
}

class _LiffInfoButtonState extends State<LiffInfoButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.5, // 初始高度為螢幕的 50%
            minChildSize: 0.3, // 最小高度為螢幕的 30%
            maxChildSize: 0.9, // 最大高度為螢幕的 90%
            builder: (context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  // 拖動指示器
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LiffInfo(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF507166),
        foregroundColor: const Color(0xFFCBAA39),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text('Check LIFF Info'),
    );
  }
}
