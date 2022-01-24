import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hse/core/utils/routes.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/layout/main_layout.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/pageviews/car_order/car_order_page_view.dart';
import 'package:hse/pageviews/event/event_page_view.dart';
import 'package:hse/pageviews/loading_page.dart';
import 'package:hse/pageviews/login/login_page_view.dart';
import 'package:hse/pageviews/login/reset/reset_page_view.dart';
import 'package:hse/pageviews/message/message_page_view.dart';
import 'package:hse/pageviews/news/news_page_view.dart';
import 'package:hse/pageviews/obligations/obligations_page_view.dart';
import 'package:hse/pageviews/bsa/bsa_page_view.dart';
import 'package:hse/pageviews/profile/profile_page_view.dart';
import 'package:hse/pageviews/test_page_view.dart';
import 'package:hse/pageviews/ticket/ticket_management_pageview.dart';
import 'package:hse/viewmodels/bpm_models/event_model.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';
import 'package:hse/viewmodels/bpm_models/risks_model.dart';
import 'package:hse/viewmodels/calendar_model.dart';
import 'package:hse/viewmodels/home_model.dart';
import 'package:hse/viewmodels/bpm_models/ticket_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

import 'core/utils/globals.dart';
import 'generated/l10n.dart';
import 'layout/update_layout.dart';
import 'pageviews/appeals/appeals_page_view.dart';
import 'pageviews/check_points/checkpoint_page_view.dart';
import 'pageviews/food/food_page_view.dart';
import 'pageviews/hello/hello_view.dart';
import 'pageviews/login/pin/pin_page_view.dart';
import 'pageviews/notifications/notifications_page_view.dart';
import 'pageviews/payment/payment_page_view.dart';
import 'pageviews/ppe/ppe_page_view.dart';
import 'pageviews/ppe/ppe_widgets.dart';
import 'pageviews/risks/risks_page_view.dart';
import 'pageviews/settings/change_password_page.dart';
import 'pageviews/settings/settings_page_view.dart';
import 'viewmodels/bpm_models/bsa_model.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void setOverrideForDesktop() {
 // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  // if (kIsWeb) return;
  //
  if (Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  } else if (Platform.isFuchsia) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  setOverrideForDesktop();
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    print(error);
    print(stackTrace);
    // if (!kIsWeb) {
    //   FirebaseCrashlytics.instance.recordError(error, stackTrace);
    // }
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize
    await Firebase.initializeApp();

    // Else only enable it in non-debug builds.
    // You could additionally extend this to allow users to opt-in.
    // await FirebaseCrashlytics.instance
    //     .setCrashlyticsCollectionEnabled(!kDebugMode);
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError(errorDetails);
    };
  }

  Future onSelectNotification(String payload) async {
    await showDialog(
      context: context,
      builder: (_) {
        return  AlertDialog(
          title: Text('PayLoad'),
          content: Text('Payload : $payload'),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // if (kIsWeb) {
    //   return;
    // }
    _initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserInfoModel()),
          ChangeNotifierProvider(create: (_) => Home()),
          ChangeNotifierProvider(create: (_) => CalendarModel()),
          ChangeNotifierProvider(create: (_) => MessageModel()),
          ChangeNotifierProvider(create: (_) => BsaModel()),
          ChangeNotifierProvider(create: (_) => RisksModel()),
          ChangeNotifierProvider(create: (_) => EventModel()),
          ChangeNotifierProvider(create: (_) => TicketModel()),
        ],
        child: Consumer<UserInfoModel>(builder: (context, counter, _) {
          return GetMaterialApp(
            builder: (BuildContext context, Widget child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                  textScaleFactor: 1.0,
                ),
                child: child,
              );
            },
            supportedLocales: const [
              Locale('ru'),
              Locale('en'),
              Locale('kk'),
            ],
            debugShowCheckedModeBanner: false,
            locale: counter.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate,
            ],
            initialRoute: '/hello',
            theme: ThemeData(
              primaryColor: appBlueColor,
              textTheme: TextTheme(
                button: generalFontStyle.copyWith(),
                caption: generalFontStyle.copyWith(),
                headline1: generalFontStyle.copyWith(),
                headline2: generalFontStyle.copyWith(),
                headline3: generalFontStyle.copyWith(),
                headline4: generalFontStyle.copyWith(),
                headline5: generalFontStyle.copyWith(),
                headline6: generalFontStyle.copyWith(),
                subtitle1: generalFontStyle.copyWith(),
                subtitle2: generalFontStyle.copyWith(),
              ),
            ),
            getPages: [
              GetPage(name: '/home', page: () => MainLayout()),
              GetPage(name: '/test', page: () => TestPage()),
              GetPage(name: '/login', page: () => LoginPageView()),
              GetPage(name: '/hello', page: () => HelloPage()),
              GetPage(name: '/reset', page: () => ResetPage()),
              GetPage(name: '/profile', page: () => ProfilePage()),
              GetPage(name: '/loading', page: () => LoadingPage()),
              GetPage(name: '/pin_create', page: () => PinPage(true)),
              GetPage(name: '/pin', page: () => PinPage(false)),
              GetPage(name: '/ppe', page: () => PpePage()),
              GetPage(name: '/ppeFullList', page: () => PpeFullListPage()),
              GetPage(name: '/admissions', page: () => CheckPointPageView()),
              GetPage(name: '/news', page: () => NewsViewPage()),
              GetPage(name: '/carOrder', page: () => CarOrderPage()),
              GetPage(name: '/payment', page: () => PaymentPageView()),
              GetPage(name: '/appeals', page: () => AppealsPage()),
              GetPage(name: '/settings', page: () => SettingsPage()),
              GetPage(name: '/notifications', page: () => NotificationsPage()),
              GetPage(
                  name: '/changePassword', page: () => ChangePasswordPage()),
              GetPage(name: '/food', page: () => FoodPageView()),
              GetPage(name: '/obligations', page: () => ObligationsPageView()),
              GetPage(name: '/update', page: () => UpdateRequiedLayout()),
              GetPage(name: Routes.message, page: () => MessagePageView()),
              GetPage(name: Routes.behavioralAudit, page: () => BsaPageView()),
              GetPage(name: Routes.risksManagement, page: () => RisksManagementPageView()),
              GetPage(name: Routes.ticketManagement, page: () => TicketManagementPageView()),
              GetPage(name: Routes.productionControl, page: () => TicketManagementPageView()),
              GetPage(name: Routes.eventsManagement, page: () => EventPageView()),
              GetPage(name: Routes.auditGovManagement, page: () => EventPageView()),
              GetPage(name: Routes.covid, page: () => EventPageView()),
            ],
          );
        }));
  }
}
