import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/car_order/car_order_widgets.dart';
import 'package:hse/viewmodels/car_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class CarOrderMobileView extends StatelessWidget {
  CarOrderMobileView({Key key}) : super(key: key);

  final Map map = {
    '/address': Expanded(
      child: OrderMap(),
    ),
    '/dateTime': OrderDateTime(),
    '/passagers': Expanded(
      child: OrderPassagers(),
    ),
    '/info': Expanded(
      child: OrderInfo(),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<CarModel>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).carOrder,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: TabView(
                  height: MediaQuery.of(context).size.height *
                      (isDesktop(context) ? 0.93 : 0.80),
                  canScroll: false,
                  tabs: [
                    GestureDetector(
                      onTap: () {
                        counter.controller.animateTo(0);
                        counter.setBusy(false);
                      },
                      child: Tab(
                        child: Text(
                          S().request,
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize - 1),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        counter.controller.animateTo(1);
                        counter.setBusy(false);
                      },
                      child: Tab(
                        child: Text(
                          S().purchaseHistory,
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize - 1),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        counter.controller.animateTo(2);
                        counter.setBusy(false);
                      },
                      child: Tab(
                        child: Text(
                          S().myAddresses,
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize - 1),
                        ),
                      ),
                    ),
                  ],
                  tabBar: [
                    Stack(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            OrderStepper(),
                            map[counter.step],
                          ],
                        ),
                        (counter.order?.fromAddress == null &&
                                counter.order?.toAddress == null)
                            ? SizedBox()
                            : buildButton(counter)
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: OrderHistory(),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: MyAddressesList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildButton(CarModel counter) {
    return FutureProvider<bool>(
        create: (BuildContext context) => RestServices.checkConnection(),
        initialData: null,
        child: Consumer<bool>(builder: (context, value, child) {
          if (value == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return Positioned(
              bottom: 0.5,
              child: SnackButtons(
                child: counter.step == '/address' && !kIsWeb
                    ? ShowSelectedPlaces()
                    : null,
                leftText: S().select,
                rightText: S().cancel,
                functionLeft: !value ? null : counter.next,
                functionRight: !value ? null : counter.back,
              ));
        }));
  }
}
