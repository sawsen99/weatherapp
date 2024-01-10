import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/core/utils/extensions.dart';
import 'package:weatherapp/core/values/colors.dart';
import 'package:weatherapp/modules/home/controller.dart';
import 'package:weatherapp/modules/home/widgets/days_list.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends GetView<HomeController> {
  // HomeController homeController = Get.put(HomeController(city: 'boumerdes'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<HomeController>(builder: (controller) {
        return controller.is_loading
            ? Center(child: const CircularProgressIndicator())
            : Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: controller.is_light
                      ? LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            lightBckgColor2,
                            lightBckgColor1,
                          ],
                        )
                      : LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            darkBckgdColor2,
                            darkBckgdColor1,
                          ],
                        ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, top: 20, bottom: 8),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  controller.is_light
                                      ? Text(
                                          "Dark Mode",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      : Text(
                                          "Light Mode",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                  SizedBox(width: 8),
                                  Switch(
                                    value: controller.is_light,
                                    activeTrackColor: darkBckgdColor1,
                                    activeColor: Colors.white,
                                    inactiveThumbColor: lightBckgColor1,
                                    inactiveTrackColor: lightBckgColor2,
                                    onChanged: (value) {
                                      controller.changeTheme();
                                    },
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: TextField(
                            onChanged: (value) => controller.city = value,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) => controller.updateWeather(),
                            decoration: InputDecoration(
                              suffix: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintStyle: const TextStyle(color: Colors.white),
                              hintText: 'Search a city',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: controller.is_light
                                        ? lightTextColor
                                        : darkTextColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          width: 100.0.wp,
                          height: 50.0.hp,
                          child: Card(
                            color: controller.is_light
                                ? Colors.white
                                : darkBckgdColor1,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${controller.currentWeatherData.name}'
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: controller.is_light
                                                    ? Colors.black87
                                                    : darkTextColor,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'flutterfonts',
                                              ),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_MMMMEEEEd()
                                              .format(DateTime.now()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: controller.is_light
                                                    ? Colors.black45
                                                    : darkTextColor,
                                                fontSize: 14,
                                                fontFamily: 'flutterfonts',
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Divider(),
                                  //TODO
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          "assets/weather/${controller.currentWeatherData.weather![0].icon.toString()}.png",
                                        ),
                                        // 'wind ${controller.currentWeatherData.wind!.speed} m/s',
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              '${controller.currentWeatherData.weather![0].description}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    color: controller.is_light
                                                        ? Colors.black45
                                                        : darkTextColor,
                                                    fontSize: 20,
                                                    fontFamily: 'flutterfonts',
                                                  ),
                                            ),
                                            //SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  //color: Colors.black,
                                                  width: 50,
                                                  height: 90,
                                                  child: Lottie.asset(
                                                    'assets/lotties/temp2.json',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Text(
                                                  '${(controller.currentWeatherData.main!.temp! - 273.15).round().toString()}\u2103',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                        color:
                                                            controller.is_light
                                                                ? Colors.black87
                                                                : darkTextColor,
                                                        fontFamily:
                                                            'flutterfonts',
                                                        fontSize: 40,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'min: ${(controller.currentWeatherData.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(controller.currentWeatherData.main!.tempMax! - 273.15).round().toString()}\u2103',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    color: controller.is_light
                                                        ? Colors.black45
                                                        : darkTextColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'flutterfonts',
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: controller.is_light
                                          ? lightBckgColor1.withOpacity(0.3)
                                          : darkBckgdColor2.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius: 8,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Lottie.asset(
                                              'assets/lotties/umb.json',
                                              width: 40,
                                              height: 40,
                                            ),
                                            Text(
                                              ' ${controller.currentWeatherData.main!.humidity.toString()} mm/h',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: controller.is_light
                                                    ? lightTextColor
                                                    : darkTextColor,
                                              ),
                                            ),
                                            Text(
                                              'Rain',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: controller.is_light
                                                    ? blackColor
                                                    : darkTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Lottie.asset(
                                              'assets/lotties/wind2.json',
                                              width: 40,
                                              height: 40,
                                            ),
                                            Text(
                                              ' ${controller.currentWeatherData.wind!.speed} m/s',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: controller.is_light
                                                    ? lightTextColor
                                                    : darkTextColor,
                                              ),
                                            ),
                                            Text(
                                              'Wind speed',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: controller.is_light
                                                    ? blackColor
                                                    : darkTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/humidite.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                            Text(
                                              ' ${controller.currentWeatherData.main!.humidity.toString()} %',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: controller.is_light
                                                    ? lightTextColor
                                                    : darkTextColor,
                                              ),
                                            ),
                                            Text(
                                              'Humidity',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: controller.is_light
                                                    ? blackColor
                                                    : darkTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ).animate().fadeIn(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        MyList(fiveDayData: controller.fiveDaysData),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
