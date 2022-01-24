import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hse/core/service/firebase/PushNotificationService.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/hive_service.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/core/utils/local_icon_data.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/utils/UI_Helpers.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key key}) : super(key: key);

  Future<bool> init(UserInfoModel counter) async {
    await Hive.initFlutter();
    await HiveService.register();
    await initializeDateFormatting('ru', null);

    var settings = await HiveService.getBox('settings');

    String url = await settings.get('url');

//    var path = (await getApplicationDocumentsDirectory()).path;
    var endPoint = url == 'default' || url == null ? endpointUrl : url;

    await Kinfolk()
        .initializeBaseVariables(endPoint, endpointClient, endpointSecret);
    if (!kIsWeb) {
      RestServices.getAppVersion();

      developer.log('Phone init permission: ${await Permission.phone.status}',
          name: 'PSC');
      if (await Permission.storage.request().isGranted) {
        developer.log(
            'Phone requested permission: ${await Permission.phone.status}',
            name: 'PSC');
      }
    }

    String locale;
    locale = settings.get('locale');
    bool auth = settings.get('authorized') ?? false;
    counter.auth = auth ?? false;
    counter.setBusy(false);
    var locale2 = Locale(locale ?? 'ru');
    counter.locale = locale2;
    counter.localeCode = locale;
    await S.load(locale2);
    await settings.close();
    await PushNotificationService().initialise();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<UserInfoModel>(context);
    var deviceInfo = getDeviceInfo(context);
    var size = MediaQuery.of(context).size;
    //var width = 300.0;
    var width = size.width * 0.85;
    var height = size.height * 0.9;
    var imageSize = GFSize.MEDIUM;
    var isDesktop = false;
    if (deviceInfo == DeviceScreenType.desktop) {
      isDesktop = true;
      width = size.width * 0.4;
      height = size.height * 0.8;
      imageSize *= 4;
    }
    return FutureBuilder(
      future: init(counter),
      builder: (ctx, snap) {
        // if (counter.auth == null) {
        //   return Center(child: GFLoader(type: GFLoaderType.circle));
        // }
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                height: height,
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    GFImageOverlay(
                      height: isDesktop ? 60 : imageSize * 3,
                      width: isDesktop ? 160 : imageSize * 3,
                      colorFilter: ColorFilter.mode(
                          Colors.transparent, BlendMode.color),
                      image: AssetImage(LocalIconData.logoIsa),
                    ),
                    Text(
                      'ТОО UCO',
                      style: !isDesktop
                          ? generalFontStyle.copyWith(
                          fontSize: defaultFontSize + 2)
                          : generalFontStyle.copyWith(
                          fontSize: defaultFontSize + 2),
                    ),
                    SizedBox(
                      height: 120,
                    ),
                    Text(
                      S().loginTitle,
                      style: !isDesktop
                          ? generalFontStyle.copyWith(
                          fontSize: defaultFontSize + 10,
                          fontWeight: FontWeight.bold)
                          : generalFontStyle.copyWith(
                          fontSize: defaultFontSize + 10,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width,
                      child: GFButton(
                        onPressed: () => Get.toNamed('/login'),
                        color: appGreenColor,
                        text: S().singInSystem,
                        textStyle: !isDesktop
                            ? generalFontStyle.copyWith(
                            color: Colors.white,
                            fontSize: defaultFontSize + 10,
                            fontWeight: FontWeight.bold)
                            : generalFontStyle.copyWith(
                            color: Colors.white,
                            fontSize: defaultFontSize + 10,
                            fontWeight: FontWeight.bold),
                        size: 52,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
