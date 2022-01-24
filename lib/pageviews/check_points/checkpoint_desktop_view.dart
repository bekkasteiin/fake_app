import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/check_points/CheckPoint.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/layout/main_widgets.dart';
import 'package:hse/viewmodels/checkpoint_model.dart';
import 'package:provider/provider.dart';

import 'checkpoint_widgets.dart';

class CheckpointDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dateTextStyle = Theme.of(context).textTheme.headline6;
    return Consumer<CheckPointModel>(builder: (context, counter, _) {
      return Scaffold(
        appBar: AppBar(title: Center(child: Text(S().admissions))),
        // drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  S().listOfAccountingEvents,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FutureProvider<List<CheckPoint>>(
                    create: (BuildContext context) => counter.checkpoints,
                    initialData: null,
                    child: Consumer<List<CheckPoint>>(
                        builder: (context, model, _) {
                      if (model == null) {
                        return GFLoader(
                          type: GFLoaderType.ios,
                        );
                      }
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...model.map((e) {
                              return checkPointDesktopItems(
                                  e, context, dateTextStyle);
                            }).toList()
                          ],
                        ),
                      );
                    })),
              ),
            ],
          ),
        ),
      );
    });
  }
}
