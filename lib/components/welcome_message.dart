import 'package:flutter/material.dart';

class WelcomingMessage extends StatelessWidget {
  double paragraphHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            '府城城垣 300 年 任務集章活動',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: paragraphHeight*2),
        Text('Hello 巡城人！',
            style: TextStyle(
              
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: paragraphHeight),
        Text('歡迎加入府城城垣 300 年任務集章活動。',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: paragraphHeight),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 14.0,
                  height: 1.5,
                ),
            children: const [
              TextSpan(
                text:
                    '請先與官方帳號 LINE 成為好友，才能開啟後續的集章任務，並獲得活動資訊、任務清單與獎勵哦！活動共有 38 處任務地點，並分成紅、黃、藍三類，每類各集滿 6 個集章圖卡並於 5/10~5/11 到南門公園參加',
              ),
              TextSpan(
                text: '《城是生活嘉年華》',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '活動，即可獲得本次限量的府城城垣節指定好禮。',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text('活動方式：', style: const TextStyle(fontWeight: FontWeight.bold)),
        //const SizedBox(height: 8.0),
        _buildNumberedItem(
          number: 1,
          text: '加入「府城城垣 300 年官方 Line 」好友 。',
          context: context,
        ),
        _buildNumberedItem(
          number: 2,
          text:
              '前往活動指定地點，於現場找到 QR Code 掃描 QR Code 開啟畫面，複製頁面上的指定密碼，並輸入在「府城城垣 300 年官方 Line 」對話框中 。',
          context: context,
        ),
        _buildNumberedItem(
          number: 3,
          text: '對話框會自動回覆訊息，並提供對應圖卡。',
          context: context,
        ),
        _buildNumberedItem(
          number: 4,
          text: '完成指定任務，並於 5/10~5/11 到南門公園參加《城是生活嘉年華》活動，即可獲得本次指定好禮（數量有限！）。',
          context: context,
        ),
        _buildNumberedItem(
          number: 5,
          text: '部分店家會推出指定優惠，出示對話框中的優惠圖卡即可使用，歡迎多多探索！',
          context: context,
        ),
        _buildNumberedItem(
          number: 6,
          text: '出發前請先留意各地點的營業及開放時間。',
          context: context,
        ),
      ],
    );
  }
}

Widget _buildNumberedItem({
  required int number,
  required String text,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.0,
          margin: const EdgeInsets.only(left: 8.0),
          child: Text(
            '$number.',
          ),
        ),
        Expanded(
          child: Text(
            text,
          ),
        ),
      ],
    ),
  );
}
