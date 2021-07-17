import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionInfo {
  int budget;
  int totalUse;
  int todayUse;
  DateTime sDay;
  DateTime dDay;

  SessionInfo(this.budget, this.totalUse, this.todayUse, this.sDay, this.dDay);
}

class GoalSection extends StatelessWidget {
  final SessionInfo data;
  
  const GoalSection(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text("목표 금액 : ${data.totalUse}원/${data.budget}원"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                      "기간 : ${DateFormat('MM/dd').format(data.sDay)} ~ ${DateFormat('MM/dd').format(data.dDay)}"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text("오늘 사용한 금액 : ${data.todayUse}원"),
                ),
              ],
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
