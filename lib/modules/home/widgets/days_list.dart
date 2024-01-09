import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/core/values/colors.dart';
import 'package:weatherapp/models/five_days_data.dart';
import 'package:weatherapp/modules/home/controller.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyList extends GetView<HomeController> {
  List<FiveDayData> fiveDayData;

  MyList({Key? key, required this.fiveDayData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20, bottom: 15),
            child: Text(
              "Next Days",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: controller.is_light ? lightTextColor : darkTextColor,
              ),
            ),
          ),
          Container(
            height: 190,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => VerticalDivider(
                color: Colors.transparent,
                width: 5,
              ),
              itemCount: fiveDayData.length > 5 ? 5 : fiveDayData.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 6, bottom: 15),
                  //color: Colors.red,
                  width: 130,
                  height: 170,
                  child: Card(
                    elevation: 14, // Elevation for shadow effect
                    color: controller.is_light
                        ? lightBckgColor1.withOpacity(0.6)
                        : darkBckgdColor1
                            .withOpacity(0.6), // Background color with opacity
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            DateFormat.E().format(
                                DateTime.now().add(Duration(days: index))),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 168, 219, 253),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${fiveDayData[index].temp!}\u2103 ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              "assets/weather/${fiveDayData[index].weather![0].icon.toString()}.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ).animate().fadeIn(
                duration: const Duration(milliseconds: 1000),
              ),
        ],
      );
    });
  }
}
