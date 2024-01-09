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
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: controller.is_light
                ? LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      lightBckgColor2, // Color #c4e0e5
                      lightBckgColor1, // Color #4ca1af
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      darkBckgdColor2, // Color #c4e0e5
                      darkBckgdColor1, // Color #4ca1af
                    ],
                  ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton<String>(
                      offset: Offset(0, 40),
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (String value) {
                        //showToastClicked(context, value);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          //value: "Theme ",
                          child: controller.is_light
                              ? Text("Turn to dark theme")
                              : Text("Turn to light theme"),
                          onTap: () {
                            controller.changeTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  controller.is_loading
                      ? const CircularProgressIndicator()
                      : Container(
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
                                  //TODO
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
                                        child: SizedBox(
                                            width: 120,
                                            height: 140,
                                            child: Image.asset(
                                              "assets/weather/${controller.currentWeatherData.weather![0].icon.toString()}.png",
                                            )),
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
                                            Text(
                                              '${(controller.currentWeatherData.main!.temp! - 273.15).round().toString()}\u2103',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .copyWith(
                                                      color: controller.is_light
                                                          ? Colors.black87
                                                          : darkTextColor,
                                                      fontFamily:
                                                          'flutterfonts'),
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
                                            Image.asset(
                                              'assets/images/parapluie.png',
                                              width: 30,
                                              height: 30,
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
                                            Image.asset(
                                              'assets/images/vent.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                            Text(
                                              ' ${controller.currentWeatherData.wind!.speed} Km/h',
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
                                              width: 30,
                                              height: 30,
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
                  //FiveDaysTable(fiveDayData: controller.fiveDaysData),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}









      // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     decoration: const BoxDecoration(
                    //       image: DecorationImage(
                    //         colorFilter:
                    //             ColorFilter.mode(Colors.black38, BlendMode.darken),
                    //         image: AssetImage(
                    //           'assets/images/cloud-in-blue-sky.jpg',
                    //         ),
                    //         fit: BoxFit.cover,
                    //       ),
                    //       borderRadius: BorderRadius.only(
                    //         bottomLeft: Radius.circular(25),
                    //         bottomRight: Radius.circular(25),
                    //       ),
                    //     ),
                    //     child: Stack(
                    //       children: <Widget>[
                    //         Container(
                    //           child: AppBar(
                    //             backgroundColor: Colors.transparent,
                    //             elevation: 0,
                    //             leading: IconButton(
                    //               icon: const Icon(
                    //                 Icons.menu,
                    //                 color: Colors.white,
                    //               ),
                    //               onPressed: () {},
                    //             ),
                    //           ),
                    //         ),
                    //         //TODO
                    //         Container(
                    //           padding: EdgeInsets.only(top: 100, left: 20, right: 20),
                    //           child: TextField(
                    //             onChanged: (value) => controller.city = value,
                    //             style: const TextStyle(
                    //               color: Colors.white,
                    //             ),
                    //             textInputAction: TextInputAction.search,
                    //             onSubmitted: (value) => controller.updateWeather(),
                    //             decoration: InputDecoration(
                    //               suffix: const Icon(
                    //                 Icons.search,
                    //                 color: Colors.white,
                    //               ),
                    //               hintStyle: const TextStyle(color: Colors.white),
                    //               hintText: 'Search'.toUpperCase(),
                    //               border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 borderSide: BorderSide(color: Colors.white),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 borderSide: const BorderSide(color: Colors.white),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 borderSide: BorderSide(color: Colors.white),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         Align(
                    //           alignment: const Alignment(0.0, 1.0),
                    //           child: SizedBox(
                    //             height: 10,
                    //             width: 10,
                    //             child: OverflowBox(
                    //               minWidth: 0.0,
                    //               maxWidth: MediaQuery.of(context).size.width,
                    //               minHeight: 0.0,
                    //               maxHeight: (MediaQuery.of(context).size.height / 4),
                    //               child: Stack(
                    //                 children: <Widget>[
                    //                   Container(
                    //                     padding: EdgeInsets.symmetric(horizontal: 15),
                    //                     width: double.infinity,
                    //                     height: double.infinity,
                    //                     child: Card(
                    //                       color: Colors.white,
                    //                       elevation: 5,
                    //                       shape: RoundedRectangleBorder(
                    //                         borderRadius: BorderRadius.circular(25),
                    //                       ),
                    //                       child: Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.center,
                    //                         children: <Widget>[
                    //                           //TODO
                    //                           Container(
                    //                             padding: EdgeInsets.only(
                    //                                 top: 15, left: 20, right: 20),
                    //                             child: Column(
                    //                               crossAxisAlignment:
                    //                                   CrossAxisAlignment.start,
                    //                               children: <Widget>[
                    //                                 Center(
                    //                                   child: Text(
                    //                                     '${controller.currentWeatherData.name}'
                    //                                         .toUpperCase(),
                    //                                     style: Theme.of(context)
                    //                                         .textTheme
                    //                                         .caption!
                    //                                         .copyWith(
                    //                                           color: Colors.black45,
                    //                                           fontSize: 24,
                    //                                           fontWeight:
                    //                                               FontWeight.bold,
                    //                                           fontFamily:
                    //                                               'flutterfonts',
                    //                                         ),
                    //                                   ),
                    //                                 ),
                    //                                 Center(
                    //                                   child: Text(
                    //                                     DateFormat()
                    //                                         .add_MMMMEEEEd()
                    //                                         .format(DateTime.now()),
                    //                                     style: Theme.of(context)
                    //                                         .textTheme
                    //                                         .caption!
                    //                                         .copyWith(
                    //                                           color: Colors.black45,
                    //                                           fontSize: 16,
                    //                                           fontFamily:
                    //                                               'flutterfonts',
                    //                                         ),
                    //                                   ),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                           Divider(),
                    //                           //TODO
                    //                           Row(
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.spaceBetween,
                    //                             children: <Widget>[
                    //                               Container(
                    //                                 padding: EdgeInsets.only(left: 50),
                    //                                 child: Column(
                    //                                   children: <Widget>[
                    //                                     Text(
                    //                                       '${controller.currentWeatherData.weather![0].description}',
                    //                                       style: Theme.of(context)
                    //                                           .textTheme
                    //                                           .caption!
                    //                                           .copyWith(
                    //                                             color: Colors.black45,
                    //                                             fontSize: 22,
                    //                                             fontFamily:
                    //                                                 'flutterfonts',
                    //                                           ),
                    //                                     ),
                    //                                     SizedBox(height: 10),
                    //                                     Text(
                    //                                       '${(controller.currentWeatherData.main!.temp! - 273.15).round().toString()}\u2103',
                    //                                       style: Theme.of(context)
                    //                                           .textTheme
                    //                                           .headline2!
                    //                                           .copyWith(
                    //                                               color: Colors.black45,
                    //                                               fontFamily:
                    //                                                   'flutterfonts'),
                    //                                     ),
                    //                                     Text(
                    //                                       'min: ${(controller.currentWeatherData.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(controller.currentWeatherData.main!.tempMax! - 273.15).round().toString()}\u2103',
                    //                                       style: Theme.of(context)
                    //                                           .textTheme
                    //                                           .caption!
                    //                                           .copyWith(
                    //                                             color: Colors.black45,
                    //                                             fontSize: 14,
                    //                                             fontWeight:
                    //                                                 FontWeight.bold,
                    //                                             fontFamily:
                    //                                                 'flutterfonts',
                    //                                           ),
                    //                                     ),
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                               Container(
                    //                                 padding: EdgeInsets.only(right: 20),
                    //                                 child: Column(
                    //                                   mainAxisAlignment:
                    //                                       MainAxisAlignment.center,
                    //                                   children: <Widget>[
                    //                                     SizedBox(
                    //                                       width: 120,
                    //                                       height: 120,
                    //                                       child: LottieBuilder.asset(
                    //                                           Images.cloudyAnim),
                    //                                     ),
                    //                                     Container(
                    //                                       child: Text(
                    //                                         'wind ${controller.currentWeatherData.wind!.speed} m/s',
                    //                                         style: Theme.of(context)
                    //                                             .textTheme
                    //                                             .caption!
                    //                                             .copyWith(
                    //                                               color: Colors.black45,
                    //                                               fontSize: 14,
                    //                                               fontWeight:
                    //                                                   FontWeight.bold,
                    //                                               fontFamily:
                    //                                                   'flutterfonts',
                    //                                             ),
                    //                                       ),
                    //                                     ),
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Expanded(
                    //   flex: 2,
                    //   child: Stack(
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 15),
                    //         child: Container(
                    //           padding: EdgeInsets.only(top: 120),
                    //           child: Align(
                    //             alignment: Alignment.topLeft,
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: <Widget>[
                    //                 // Container(
                    //                 //   child: Text(
                    //                 //     'other city'.toUpperCase(),
                    //                 //     style: Theme.of(context)
                    //                 //         .textTheme
                    //                 //         .caption!
                    //                 //         .copyWith(
                    //                 //           fontSize: 16,
                    //                 //           fontFamily: 'flutterfonts',
                    //                 //           color: Colors.black45,
                    //                 //           fontWeight: FontWeight.bold,
                    //                 //         ),
                    //                 //   ),
                    //                 // ),
                    //                 // MyList(),
                    //                 // Container(
                    //                 //   padding: EdgeInsets.only(top: 10),
                    //                 //   child: Row(
                    //                 //     mainAxisAlignment:
                    //                 //     MainAxisAlignment.spaceBetween,
                    //                 //     children: <Widget>[
                    //                 //       Text(
                    //                 //         'forcast next 5 days'.toUpperCase(),
                    //                 //         style: Theme.of(context)
                    //                 //             .textTheme
                    //                 //             .caption!
                    //                 //             .copyWith(
                    //                 //           fontSize: 18,
                    //                 //           fontWeight: FontWeight.bold,
                    //                 //           color: Colors.black45,
                    //                 //         ),
                    //                 //       ),
                    //                 //       Icon(
                    //                 //         Icons.next_plan_outlined,
                    //                 //         color: Colors.black45,
                    //                 //       ),
                    //                 //     ],
                    //                 //   ),
                    //                 // ),
                    //                 // MyChart(),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),