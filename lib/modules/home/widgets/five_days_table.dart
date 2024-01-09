import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/core/utils/extensions.dart';
import 'package:weatherapp/models/five_days_data.dart';

class FiveDaysTable extends StatelessWidget {
  List<FiveDayData> fiveDayData;
  FiveDaysTable({Key? key, required this.fiveDayData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(bottom: 10, left: 10),
          child: const Text(
            "Next Days",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
        dailyList(),
      ],
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 30.0.hp,
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemCount: fiveDayData.length > 5 ? 5 : fiveDayData.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            height: 40,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  DateFormat.E()
                      .format(DateTime.now().add(Duration(days: index))),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'flutterfonts',
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                      "assets/weather/${fiveDayData[index].weather![0].icon.toString()}.png"),
                ),
                Text(
                  '${fiveDayData[index].temp!}\u2103 ',
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
