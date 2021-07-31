import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/data/model.dart';

class GoalSection extends StatelessWidget {
  final _editCont = TextEditingController();
  final SessionInfo data;
  final int todayUse;

  GoalSection(this.data, this.todayUse, {Key? key}) : super(key: key);

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
                        style: Theme.of(context).textTheme.headline1),
                    SizedBox(height: 12),
                    Text(
                      "${data.totalUse}원/${data.budget}원",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  "기간 : ${DateFormat('MM/dd').format(data.sDay)} ~ ${DateFormat('MM/dd').format(data.dDay)}",
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 30),
                Text("오늘 사용한 금액 : $todayUse원",
                    style: Theme.of(context).textTheme.headline3),
              ],
            ),
            buildButton(context)
          ],
        ),
      ),
    );
  }

  Widget buildButton(context) {
    if (data.editable) {
      return IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    height: 120,
                    child: Center(
                      child: Column(
                        children: [
                          Text('예산을 입력하세요'),
                          TextField(
                            controller: _editCont,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            onEditingComplete: () {
                              bloc.changeBudget(
                                  int.parse(_editCont.value.text));
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.edit, color: white));
    } else {
      return IconButton(
          onPressed: null, icon: Icon(Icons.edit_off, color: Colors.grey));
    }
  }
}
