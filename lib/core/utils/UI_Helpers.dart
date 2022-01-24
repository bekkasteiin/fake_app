import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/viewmodels/appeal_model.dart';
import 'package:hse/viewmodels/car_model.dart';
import 'package:hse/viewmodels/food_model.dart';
import 'package:hse/viewmodels/testing_model.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

Color appRedColor = Color(0xffd95858);
Color appYellowColor = hexToColor('#FEE1A6');
Color appGreenColor = Color(0xff405fa4);
Color appBlueColor = Color(0xff51b1d8);
Color appDarkBlueColor = Color(0xff405fa4);
Color appSeaBlueColor = Color(0xffc2dfff);
Color appDarkYellowColor = Color(0xffe2a849);
Color appBorderColor = Color(0xffdce3e7);
Color appDisabledColor = Color(0xffcfd1d3);
Color appGreyColor = Color(0xffbcbcbc);
Color appBlackColor = Colors.black;
Color appDarkGrayColor = Color(0xff8C8C8C);
Color appFiledBorderColor = Color(0xffcbcbcb);
Color appWhiteColor = Colors.white;
Color appOrangeColor = Color(0xfffb9764);
Color appLightOrangeColor = Color(0xfffee5d8);
Color appLightPurpleColor = Color(0xff9595D2);
Color appButtonGreyColor = Color(0xffcfd1d3);
Color customStepperGreyCircleColor = Color(0xffDCE3E7);

var namingStyle = generalFontStyle.copyWith(fontSize: 18, color: Colors.black);
var captionStyle =
    generalFontStyle.copyWith(fontSize: 14, color: Colors.black54);
var defaultFontSize = 16.0;
var defaultAccordionTitleFontSize = 20.0;
var defaultButtonTextFontSize = 22.0;

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String formatDate(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
}

String formatOnlyDate(dateTime) {
  if (!(dateTime is DateTime)) return '';

  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('dd.MM.yyyy').format(dateTime);
}

String formatOnlyYear(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('yyyy').format(dateTime);
}

String formatNamedDate(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('yMMMd').format(dateTime);
}

String formatMonthNamedDate(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('MMM dd yyyy').format(dateTime);
}

String formatHour(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('HH:mm').format(dateTime);
}

String formatNumber(double n) {
  if (n == null) {
    return ' ';
  }
  return NumberFormat('0.00').format(n);
}

class TabView extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> tabBar;
  final double height;
  final bool canScroll;

  const TabView({
    Key key,
    this.tabs,
    this.tabBar,
    this.height,
    this.canScroll,
  }) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      var model = Provider.of<CarModel>(context);
      if (model != null) {
        model.controller ??= _tabController;
      }
    } catch (e) {}
    try {
      var model = Provider.of<FoodModel>(context);
      if (model != null) {
        model.controller ??= _tabController;
      }
    } catch (e) {}
    try {
      var model = Provider.of<TestingModel>(context);
      if (model != null) {
        model.controller ??= _tabController;
        _tabController.addListener(() {
          model.currentIndex(_tabController.index);
        });
      }
    } catch (e) {}
    try {
      var model = Provider.of<AppealModel>(context);
      if (model != null) {
        model.controller ??= _tabController;
      }
    } catch (e) {}
    return GFTabs(
      tabBarHeight: 50,
      initialIndex: 0,
      indicatorColor: appBlueColor,
      tabBarColor: Colors.white,
      labelColor: appBlackColor,
      labelStyle: Theme.of(context).textTheme.subtitle2,
      length: widget.tabs.length,
      height: widget.height ??
          MediaQuery.of(context).size.height * (isDesktop(context) ? 0.7 : 1),
      tabs: widget.tabs,
      controller: _tabController,
      tabBarView: GFTabBarView(
        controller: _tabController,
        physics: widget.canScroll
            ? BouncingScrollPhysics()
            : NeverScrollableScrollPhysics(),
        children: widget.tabBar,
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  final List<Function> functions;
  final int current;

  CustomStepper({this.functions, this.current, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = isDesktop(context) ? GFSize.LARGE : GFSize.LARGE * 1.2;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...functions.map((e) {
            var index = functions.indexOf(e) + 1;
            var color2 =
                index <= current ? appGreenColor : customStepperGreyCircleColor;
            var color3 = index <= current ? Colors.white : appGreyColor;
            return Row(
              children: <Widget>[
                GestureDetector(
                  onTap: e,
                  child: Container(
                    height: size / 1.2,
                    width: size / 1.2,
                    decoration: BoxDecoration(
                      color: color2,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (index).toString(),
                        style: isDesktop(context)
                            ? generalFontStyle.copyWith(
                                fontSize: defaultFontSize + 4, color: color3)
                            : generalFontStyle.copyWith(
                                fontSize: defaultFontSize + 4, color: color3),
                      ),
                    ),
                  ),
                ),
                index >= functions.length
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: GFSize.MEDIUM,
                          child: Center(
                            child: Text(
                              '- - -',
                              style: generalFontStyle.copyWith(
                                  fontSize: defaultFontSize + 4, color: color2),
                            ),
                          ),
                        ),
                      )
              ],
            );
          }).toList()
        ]);
  }
}

class SnackButtons extends StatelessWidget {
  final Widget child;
  final Function functionLeft;
  final Function functionRight;
  final String rightText;
  final String leftText;

  const SnackButtons(
      {Key key,
      this.functionLeft,
      this.functionRight,
      this.rightText,
      this.leftText,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        child ?? SizedBox(),
        Container(
          width: screenSize.width,
          height: screenSize.height * 0.1,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor, //Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width * 0.41,
                child: Container(
                  child: GFButton(
                    size: 52,
                    text: leftText,
                    textStyle: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    color: appGreenColor,
                    onPressed: functionLeft,
                  ),
                ),
              ),
              SizedBox(
                width: 0.0,
              ),
              Container(
                width: screenSize.width * 0.41,
                child: GFButton(
                  size: 52,
                  text: rightText,
                  textStyle: generalFontStyle.copyWith(
                      fontSize: defaultFontSize + 4,
                      fontWeight: FontWeight.bold,
                      color: appGreenColor),
                  color: appGreenColor,
                  type: GFButtonType.outline,
                  onPressed: functionRight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  final Function function;
  final String caption;

  const BottomButton({Key key, this.function, this.caption}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appWhiteColor,
          //boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(2, -1), spreadRadius: 2)],
          //borderRadius: BorderRadius.circular(10)
          border: Border.all(color: appGreyColor, width: 0.2)),
      height: 100,
      padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      child: GFButton(
        onPressed: function,
        color: appGreenColor,
        textColor: appWhiteColor,
        text: caption ?? '',
        textStyle: generalFontStyle.copyWith(
            fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({@required this.onInit, @required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

DeviceScreenType getDeviceInfo(BuildContext context) {
  var deviceType = getDeviceType(MediaQuery.of(context).size);
  return deviceType;
}

bool isDesktop(BuildContext context) {
  var deviceInfo = getDeviceInfo(context);
  return deviceInfo == DeviceScreenType.desktop;
}

class LeadingDrawerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Padding(
          padding: isDesktop(context)
              ? EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0)
              : EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
          child: Icon(
            Icons.apps,
            size: GFSize.MEDIUM,
          )),
    );
  }
}
