import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/data/model.dart';

class GoalSection extends StatelessWidget {
  final SessionInfo data;
  final int todayUse;

  const GoalSection(this.data, this.todayUse, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("목표 금액 : ",
                        style:
                            whiteText(size: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Text(
                      "${data.totalUse}원/${data.budget}원",
                      style: whiteText(size: 22, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  "기간 : ${DateFormat('MM/dd').format(data.sDay)} ~ ${DateFormat('MM/dd').format(data.dDay)}",
                  style: whiteText(size: 12),
                ),
                SizedBox(height: 30),
                Text("오늘 사용한 금액 : $todayUse원",
                    style: whiteText(size: 22)),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit, color: white))
          ],
        ),
      ),
    );
  }
}
