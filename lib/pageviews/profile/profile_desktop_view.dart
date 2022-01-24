import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/home/home_page_widgets.dart';
import 'package:hse/viewmodels/profile_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';
import 'profile_widgets.dart';

class ProfileDesktopView extends StatelessWidget {
  var map = {
    '/assignment': AssignmentCard(),
    '/anthropometry': AnthropometryCard(),
    '/placement': PlacementCard(),
    '/rating': RatingCard()
  };

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Profile>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            GFImageOverlay(
              height: GFSize.SMALL,
              width: GFSize.SMALL,
              colorFilter:
                  ColorFilter.mode(Colors.transparent, BlendMode.color),
              image: AssetImage('assets/images/user.png'),
            ),
            Text(S().profile),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserProfileWindow(canRedirect: false),
            Container(
              margin: EdgeInsets.fromLTRB(200, 50, 200, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DesktopCategories(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: appBlueColor),
                        borderRadius: BorderRadius.circular(10)),
                    constraints: BoxConstraints.tightForFinite(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4),
                    padding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                    child: map[counter.index],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
