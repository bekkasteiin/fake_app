import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/local_icon_data.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  AnimationController motionController;
  double size = 1;
  var toIn = false;

  @override
  void initState() {
    super.initState();

    motionController = AnimationController(
      duration: Duration(milliseconds: 1300),
      lowerBound: 0,
      upperBound: 1,
      vsync: this,
    );

    motionController.forward();
    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          motionController.forward();
        }
      });
    });

    motionController.addListener(() {
      setState(() {
        size = motionController.value;
      });
    });
    // motionController.repeat();
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var defaultFontSize = 16.0;
    var imageSize = GFSize.MEDIUM;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 1100),
              opacity: size,
              curve: Curves.linear,
              child: GFImageOverlay(
                height: imageSize * 3.2,
                width: imageSize * 3.2,
                colorFilter:
                    ColorFilter.mode(Colors.transparent, BlendMode.color),
                image: AssetImage(LocalIconData.logoIsa),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Text(S().logoTitle,
            //     style: generalFontStyle.copyWith(
            //         fontSize: defaultFontSize, color: appBlackColor)),
            SizedBox(
              height: 10,
            ),
            Text(S().inProgress,
                style: generalFontStyle.copyWith(
                    fontSize: defaultFontSize, color: appGreyColor)),
          ],
        ),
      ),
    );
  }
}
