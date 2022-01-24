import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/components/toggle/gf_toggle.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/types/gf_toggle_type.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/login_model.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/utils/UI_Helpers.dart';

//ввод имени пользователя и пароля
class Inputs extends StatefulWidget {
  Inputs({Key key}) : super(key: key);

  @override
  _InputsState createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  final _loginController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: "");
  List<SimCard> _simCard = <SimCard>[];
  String _mobileNumber = '';
  bool pop = false;

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    var mobileNumber = '';
    try {
      mobileNumber = await MobileNumber.mobileNumber;
      _simCard = await MobileNumber.getSimCards;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
    if (!mounted) return;
    setState(() {
      _mobileNumber = mobileNumber;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Platform.isAndroid) {
      MobileNumber.listenPhonePermission((isPermissionGranted) {
        if (isPermissionGranted) {
          initMobileNumberState();
        } else {}
      });
      initMobileNumberState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Login>(builder: (context, counter, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: TextFormField(
              controller: _loginController,
              decoration: InputDecoration(
                  hintText: S().enterLogin,
                  hintStyle: generalFontStyle.copyWith(
                      fontSize: defaultFontSize + 2, color: appGreyColor),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54))),
              // initialValue: counter.login,
              onSaved: (val) => counter.login = val,
              onChanged: (val) => counter.login = val,
              validator: (val) => (val.isEmpty ? S().loginValidate : null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: S().enterPassword,
                  hintStyle: generalFontStyle.copyWith(
                      fontSize: defaultFontSize + 2, color: appGreyColor),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: counter.obscure
                          ? Colors.grey[550]
                          : Theme.of(context).accentColor,
                      size: 30,
                    ),
                    onPressed: () {
                      counter.obscure = !counter.obscure;
                      counter.setBusy(false);
                    },
                  ),
                ),
                obscureText: counter.obscure,
                // initialValue: counter.password,
                onSaved: (val) => counter.password = val,
                onChanged: (val) => counter.password = val,
                validator: (val) => (val.isEmpty ? S().loginValidate : null),
                obscuringCharacter: '*',
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Toggle(),
          SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 8.0),
          //   child: InkWell(
          //     onTap: () => Get.toNamed('/reset'),
          //     child: Text('${S().forgetPassword}?', style: namingStyle),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          // GetPlatform.isAndroid
          //   ? InkWell(
          //     onTap: () async {
          //       await dialog(counter);
          //       if (pop) {
          //         setState(() {
          //           loader(true);
          //         });
          //         //Проверить разрешение телефона
          //         var hasPhonePermission = await MobileNumber.hasPhonePermission;
          //         var message = '';
          //         if(hasPhonePermission){
          //           if(_simCard.isNotEmpty) {
          //             //проверка наличии интернет
          //             var connect = await RestServices.checkConnection();
          //             if (connect) {
          //               var result = await counter.register(_simCard);
          //               setState(() {
          //                 if (result) {
          //                   counter.obscure = false;
          //                   _loginController.text = counter.login;
          //                   _passwordController.text = counter.password;
          //                 }
          //               });
          //               message = counter.registrationMessage;
          //             } else {
          //               message = S().timeOut;
          //             }
          //           } else {
          //             message = S().notSimCards;
          //           }
          //         } else {
          //           message = S().readPhoneNumbers;
          //         }
          //         setState(() {
          //           loader(false);
          //         });
          //         Get.snackbar(S().attention, message);
          //       }
          //     },
          //     child: Text('${S().registrationRequired}?', style: namingStyle),
          //   )
          //   : Container(),
        ],
      );
    });
  }

  Future dialog(Login counter) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Регистрация пользователя'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      'Регистрация - изменит текущий пароль, если он у вас есть. Вы уверены?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Нет'),
                onPressed: () {
                  Navigator.pop(context, false);
                  pop = false;
                },
              ),
              TextButton(
                child: const Text('Да'),
                onPressed: () {
                  Navigator.pop(context, true);
                  pop = true;
                },
              ),
            ],
          );
        });
  }

  // ignore: always_declare_return_types
  loader(bool val) {
    if (val) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CupertinoActivityIndicator(),
            ),
          ),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }
}

class Toggle extends StatelessWidget {
  const Toggle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceInfo = getDeviceInfo(context);
    var size = MediaQuery.of(context).size;
    var width = size.width * 0.6;
    var defaultFontSize = 16.0;
    if (deviceInfo == DeviceScreenType.desktop) {
      width = size.width * 0.45;
    }
    return Consumer<Login>(builder: (context, counter, _) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: width,
            child: Text(
              S().loginAgreement,
              style: generalFontStyle.copyWith(
                  color: Theme.of(context).accentColor,
                  fontSize: defaultFontSize - 5,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Container(
            height: 30,
            child: Transform.scale(
              scale: 1.4,
              child: GFToggle(
                onChanged: (val) {
                  counter.isAgree = val;
                  counter.setBusy(false);
                },
                enabledTrackColor: Theme.of(context).accentColor,
                value: counter.isAgree,
                type: GFToggleType.ios,
              ),
            ),
          )
        ],
      );
    });
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var defaultFontSize = 16.0;
    var size = MediaQuery.of(context).size;
    var width = size.width * 0.85;
    return Consumer<Login>(builder: (context, counter, _) {
      return Container(
        width: width,
        child: GFButton(
          onPressed: counter.isAgree
              ? () {
                  counter.singIn();
                }
              : null,
          text: S().signIn,
          textStyle: generalFontStyle.copyWith(
              color: Colors.white,
              fontSize: defaultFontSize + 10,
              fontWeight: FontWeight.bold),
          color: appGreenColor,
          size: 52,
          blockButton: true,
        ),
      );
    });
  }
}

// class ReqistrationButton extends StatefulWidget {
//   const ReqistrationButton({Key key}) : super(key: key);
//
//   @override
//   _ReqistrationButtonState createState() => _ReqistrationButtonState();
// }
//
// class _ReqistrationButtonState extends State<ReqistrationButton> {
//   List<SimCard> _simCard = <SimCard>[];
//   String _mobileNumber = '';
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initMobileNumberState() async {
//     if (!await MobileNumber.hasPhonePermission) {
//       await MobileNumber.requestPhonePermission;
//       return;
//     }
//     String mobileNumber = '';
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       mobileNumber = await MobileNumber.mobileNumber;
//       _simCard = await MobileNumber.getSimCards;
//     } on PlatformException catch (e) {
//       debugPrint("Failed to get mobile number because of '${e.message}'");
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _mobileNumber = mobileNumber;
//     });
//   }
//
//   Widget fillCards() {
//     List<Widget> components = _simCard
//         .map((SimCard sim) => Text(
//             'Sim Card Number: ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
//         .toList();
//     return Column(children: components);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Login>(builder: (context, counter, _) {
//       return Column(
//         children: [
//           InkWell(
//             onTap: () {
//               dialog(counter);
//               setState(() {});
//             },
//             child: Text('${S().registrationRequired}?', style: namingStyle),
//           ),
//           fillCards()
//         ],
//       );
//     });
//   }
//
//   dialog(Login counter) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(S().registrationRequired),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: const <Widget>[
//                   Text('.'),
//                   Text('Would you like to approve of this message?'),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('Нет'),
//                 onPressed: () => Navigator.pop(context, false),
//               ),
//               TextButton(
//                 child: const Text('Да'),
//                 onPressed: () => Navigator.pop(context, true),
//               ),
//             ],
//           );
//         }).then((exit) async {
//       if (exit != null && exit) {
//         MobileNumber.listenPhonePermission((isPermissionGranted) {
//           if (isPermissionGranted) {
//             initMobileNumberState();
//           } else {}
//         });
//
//         await initMobileNumberState();
//         // await counter.register();
//         counter.login = _mobileNumber.substring(_mobileNumber.length - 12);
//         counter.password = _mobileNumber;
//         setState(() {});
//       } else {
//         return;
//       }
//       setState(() {});
//     });
//   }
// }

/* Original RML 17/10/2020
class LoginButton extends StatelessWidget {
  GlobalKey<FormState> formKey;

  LoginButton(this.formKey, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultFontSize = 16.0;
    return Consumer<Login>(builder: (context, counter, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GFButton(
          onPressed: counter.isAgree
              ? () {
            formKey.currentState.save();
            counter.singIn();
          }
              : null,
          text: S().signIn,
          textStyle: generalFontStyle.copyWith(color: Colors.white, fontSize: defaultFontSize+2),
          color: appGreenColor,
          size: 52,
          blockButton: true,
        ),
      );
    });
  }
}
*/
