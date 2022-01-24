import 'package:flutter/material.dart';
import 'package:getflutter/components/image/gf_image_overlay.dart';
import 'package:hse/core/utils/local_icon_data.dart';
import 'package:hse/generated/l10n.dart';

class UpdateRequiedLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GFImageOverlay(
                    height: 50 * 2.2,
                    width: 50 * 2.2,
                    colorFilter:
                        ColorFilter.mode(Colors.transparent, BlendMode.color),
                    image: AssetImage(LocalIconData.logoIsa),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      S.of(context).updateRequired,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).updateNeededToContinue,
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
