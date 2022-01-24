import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/companents/widgets/loader_widget.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/model/event/event.dart';
import 'package:hse/core/model/ticket/ticket_history.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/ticket/widgets/content_tile.dart';
import 'package:hse/pageviews/ticket/widgets/event_item.dart';
import 'package:hse/viewmodels/bpm_models/ticket_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatefulWidget {
  final TicketModel model;

  const ScanQrPage(this.model);

  @override
  _ScanQrPageState createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  Color color = appDarkGrayColor.withOpacity(0.3);
  List<String> qrDataList;
  var checkValidQr = false;
  var validLengthNatId = false;
  var checkValidNatId = false;
  var isQr = true;
  var conn;
  UserInfoModel userModel;

  @override
  void initState() {
    setState(() {
      widget.model.index = 1;
      widget.model.createEntity();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TicketModel>(context);
    userModel = Provider.of<UserInfoModel>(context);
    return Column(
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  getStepTitleByIndex(widget.model.index),
                  style: generalFontStyle.copyWith(
                      fontSize: defaultButtonTextFontSize,
                      color: appDarkGrayColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CustomStepper(
                  functions: [
                    () {},
                    () {},
                    () {},
                    () {},
                  ],
                  current: model.index ?? 1,
                ),
              ),
            ],
          ),
          model.index == 2
              ? Divider(
                  indent: 16,
                  endIndent: 16,
                  height: 1,
                )
              : SizedBox(),
          Expanded(child: _contentByStep(model: model, index: model.index)),
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 26),
              width: MediaQuery.of(context).size.width/2.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  border: Border.all(color: appGreenColor, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GFButton(
                      onPressed:
                          checkValidQr || validLengthNatId ? _onwards : null,
                      text: model.index == 4
                          ? 'Регистрация'.toUpperCase()
                          : 'Далее'.toUpperCase(),
                      textStyle: generalFontStyle.copyWith(
                          color: Colors.white,
                          fontSize: defaultAccordionTitleFontSize,
                          fontWeight: FontWeight.bold),
                      color: appGreenColor,
                      size: 52,
                      blockButton: true,
                    ),
                  ),
                  Expanded(
                    child: GFButton(
                      onPressed: () {
                        if (model.index == null || model.index == 1) {
                          Get.back();
                        } else if (model.index == 3) {
                          if (isQr) {
                            if (!conn) {
                              setState(() {
                                model.index = 1;
                              });
                            } else {
                              setState(() {
                                model.index = 2;
                              });
                            }
                          } else {
                            if (conn && checkValidNatId) {
                              setState(() {
                                model.index = 2;
                              });
                            } else {
                              setState(() {
                                model.index = 1;
                              });
                            }
                          }
                        } else if (model.index == 2) {
                          setState(() {
                            model.index = 1;
                            // qrDataList = null;
                            color = appDarkGrayColor.withOpacity(0.3);
                          });
                        } else if (model.index == 4) {
                          setState(() {
                            model.index = 3;
                          });
                        }
                      },
                      text: 'Отменить'.toUpperCase(),
                      textStyle: generalFontStyle.copyWith(
                          color: appGreenColor,
                          fontSize: defaultAccordionTitleFontSize,
                          fontWeight: FontWeight.bold),
                      color: Colors.white,
                      size: 52,
                      blockButton: true,
                      borderShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(11.0),
                            bottomRight: Radius.circular(11.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
    );
  }

  Widget _contentByStep({TicketModel model, int index}) {
    if (index == null || index == 1) {
      return Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoSegmentedControl(
                  onValueChanged: (value) async {
                    if (value == 0) {
                      isQr = true;
                      model.entity.commentNid = null;
                      model.entity.nationalId = null;
                    } else {
                      isQr = false;
                      model.entity.nationalId = null;
                      model.entity.issuedTo = null;
                      qrDataList = null;
                      checkValidQr = false;
                      color = appDarkGrayColor.withOpacity(0.3);
                    }
                    validLengthNatId = false;
                    checkValidQr = false;
                    setState(() {});
                  },
                  children: <int, Widget>{
                    0: Padding(
                        padding: EdgeInsets.all(8.0), child: Text('По QR-код')),
                    1: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('По ИИН сотрудника')),
                  },
                  groupValue: isQr ? 0 : 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: isQr ? 0 : 16),
              child: isQr
                  ? Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.6,
                          height: MediaQuery.of(context).size.height /2.6,
                          decoration: BoxDecoration(
                              border: Border.all(width: 5, color: color)),
                          // height: 100,
                          padding: EdgeInsets.all(5),
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: (result != null && qrDataList != null)
                              ? Text(
                                  'Сотрудник: ${model.entity.issuedTo.firstName}',
                                  style: generalFontStyle.copyWith(height: 1.5),
                                )
                              : null,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: qrDataList != null
                              ? FlatButton(
                                  color: appGreyColor,
                                  child: Text(
                                    'Сбросить данные',
                                  ),
                                  onPressed: () async {
                                    await _restart();
                                  },
                                )
                              : SizedBox(),
                        )
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 10),
                      child: ListView(
                        children: [
                          FieldBones(
                            placeholder: 'ИИН',
                            isRequired: true,
                            textValue: widget.model.entity.nationalId ?? '',
                            isTextField: true,
                            maxLength: 12,
                            validate: (String val) {
                              if (val.trim().isEmpty) {
                                return null;
                              }
                              if (val.trim().length != 12) {
                                return 'ИИН должен из 12 цифр';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (String val) {
                              if (val.trim().length == 12) {
                                validLengthNatId = true;
                              } else {
                                validLengthNatId = false;
                              }
                              if (val.trim().isEmpty) {
                                widget.model.entity.nationalId = null;
                              } else {
                                widget.model.entity.nationalId = val;
                              }
                              setState(() {});
                            },
                            icon: Icons.keyboard_hide_outlined,
                            iconTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                          FieldBones(
                            placeholder: 'Комментарий',
                            textValue: widget.model.entity.commentNid ?? '',
                            isTextField: true,
                            onChanged: (val) {
                              widget.model.entity.commentNid = val;
                            },
                            icon: Icons.keyboard_hide_outlined,
                            iconTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          )
                        ],
                      ),
                    ),
            ),
          )
        ],
      );
    } else if (index == 2) {
      return FutureBuilder<List<TicketHistory>>(
          future: model.getTicketHistoryByPGId(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TicketHistory>> snapshot) {
            if (snapshot.data == null) {
              return LoaderWidget();
            }
            return snapshot.data.isEmpty
                ? Text('нет данных')
                : Scrollbar(
                    child: ListView.separated(
                        itemBuilder: (_, i) => InkWell(
                              child: EventItem(snapshot.data[i]),
                              onTap: () async {
                                // await widget.bsaModel
                                //     .openEntity(widget.bsaModel.entities[i])
                                //     .then((_) => setState(() {
                                //   print('back2');
                                // }));
                              },
                            ),
                        separatorBuilder: (context, index) {
                          return Divider(height: 1);
                        },
                        itemCount: snapshot.data.length),
                  );
          });
    } else if (index == 3) {
      return ListView(
        children: [
          ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            childrenPadding: EdgeInsets.symmetric(horizontal: 24),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            initiallyExpanded: true,
            title: Text(
              'Информация',
              style: generalFontStyle.copyWith(
                  fontSize: defaultAccordionTitleFontSize,
                  fontWeight: FontWeight.bold),
            ),
            children: [
              ContentTile(
                title: 'Тип мероприятия',
                content: 'Изъять талон',
                // type: widget.model.myCard.type
              ),
              ContentTile(
                title: 'Дата',
                content: formatFullRestNotMilSec(DateTime.now()),
              ),
              ContentTile(
                title: 'Инициатор',
                content: userModel.assign.person.firstName +
                    ' ' +
                    userModel.assign.person.lastName[0] +
                    '.' +
                    userModel.assign.person.middleName[0] +
                    '. ' +
                    '(' +
                    userModel.assign.person.nationalIdentifier +
                    ')',
              ),
              FieldBones(
                placeholder: 'Комментарий',
                // textValue: ,
                hintText: 'введите',
                isTextField: true,
                textValue: widget.model.entity.comment,
                onChanged: (String val) {
                  widget.model.entity.comment = val;
                  setState(() {});
                },
                icon: Icons.keyboard_hide_outlined,
                iconTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                // selector: () {
                //   bottomsha
                // },
              ),
            ],
          )
        ],
      );
    } else if (index == 4) {
      return ListView(
        children: [
          ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            childrenPadding: EdgeInsets.symmetric(horizontal: 24),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            initiallyExpanded: true,
            title: Text(
              'Информация',
              style: generalFontStyle.copyWith(
                  fontSize: defaultAccordionTitleFontSize,
                  fontWeight: FontWeight.bold),
            ),
            children: [
              ContentTile(
                title: 'Тип мероприятия',
                content: 'Изъять талон',
                // type: widget.model.myCard.type
              ),
              ContentTile(
                title: 'Дата',
                content: formatFullRestNotMilSec(DateTime.now()),
              ),
              ContentTile(
                title: 'Инициатор',
                content: userModel.assign.person.firstName +
                    ' ' +
                    userModel.assign.person.lastName[0] +
                    '.' +
                    userModel.assign.person.middleName[0] +
                    '. ' +
                    '(' +
                    userModel.assign.person.nationalIdentifier +
                    ')',
              ),
              ContentTile(
                title: 'ФИО нарушителя',
                content: model.entity.issuedTo?.firstName ?? '',
              ),
              FieldBones(
                placeholder: 'Комментарий',
                textValue: model.entity.comment ?? '',
              ),
            ],
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Future _onwards() async {
    conn = await RestServices.checkConnection();
    if (widget.model.index == null || widget.model.index == 1) {
      // model.entity.commentNid =
      if (conn) {
        if (isQr) {
          setState(() {
            widget.model.index = 2;
          });
        } else {
          var checkResponse = await widget.model.checkPersonByNId();
          checkValidNatId = checkResponse.status;
          if (checkValidNatId) {
            var person = Person();
            person.id = checkResponse.id;
            person.firstName = checkResponse.fullName +
                ' (' +
                widget.model.entity.nationalId +
                ')';
            widget.model.entity.issuedTo = person;
            setState(() {
              widget.model.index = 2;
            });
          } else {
            await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(S.current.attention),
                    content: Column(
                      children: [
                        Text(
                            'Сотрудник с ИИН ${widget.model.entity.nationalId} не определен, данные не загружены'),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Хотите продолжить?',
                          style: generalFontStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('Да'),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                      CupertinoDialogAction(
                        child: Text('Отмена'),
                        onPressed: () => Navigator.pop(context, false),
                      )
                    ],
                  );
                }).then((exit) async {
              if (exit == null || !exit) return;
              if (exit) {
                //yes
                setState(() {
                  widget.model.index = 3;
                });
              }
            });
            ;
          }
        }
      } else {
        //нет интернета
        setState(() {
          widget.model.index = 3;
        });
      }
    } else if (widget.model.index == 2) {
      setState(() {
        widget.model.index = 3;
      });
    } else if (widget.model.index == 3) {
      setState(() {
        widget.model.index = 4;
      });
    } else if (widget.model.index == 4) {
      await widget.model.saveEntity().then((value) async {
        // await widget.model.createEntity();
        result = null;
        qrDataList = null;
        color = appDarkGrayColor.withOpacity(0.3);
        setState(() {
          widget.model.index = 1;
        });
        await _restart();
        setState(() {});
      });
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
        // var isValidQr = true;
        if (result != null) {
          color = appGreenColor;
          // print(result.code);
          qrDataList = result.code.split(' ');
          if (qrDataList.length == 5 && qrDataList[2].length == 12) {
            checkValidQr = true;
            var person = Person();
            person.id = qrDataList[3];
            person.firstName = qrDataList[0] +
                ' ' +
                qrDataList[1] +
                ' (' +
                qrDataList[2] +
                ')';
            widget.model.entity.issuedTo = person;
            widget.model.entity.nationalId = qrDataList[2];
            // widget.model.
          } else {
            color = appDarkGrayColor.withOpacity(0.3);
            qrDataList = null;
            checkValidQr = false;
            // isValidQr = false;
            showDialog(
              barrierDismissible: false,
              barrierColor: appBlackColor.withOpacity(0.4),
              context: context,
              // insetPadding: EdgeInsets.all(10),
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.add_alert_outlined,
                        color: appRedColor,
                        size: 40,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'QR-код не распознан.',
                        style: generalFontStyle.copyWith(
                            fontSize: defaultAccordionTitleFontSize - 2),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        'Сканировать повторно',
                        style: generalFontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: defaultAccordionTitleFontSize - 2),
                      ),
                      // color: appRedColor,
                    )
                  ],
                  // ele vation: 24,
                );
              },
            ).then((exit) async {
              if (exit == null || !exit) return;
              if (exit) {
                //yes
                await _restart();
              }
            });
          }
        } else {
          color = appDarkGrayColor.withOpacity(0.3);
        }
      });
      if (result != null) {
        await controller.pauseCamera();
      } else {
        // await controller.resumeCamera();
        setState(() {
          checkValidQr = false;
        });
      }
    });
  }

  Future _restart() async {
    await controller.resumeCamera();
    qrDataList = null;
    checkValidQr = false;
    color = appDarkGrayColor.withOpacity(0.3);
    setState(() {
      widget.model.index = 1;
    });
  }

  String getStepTitleByIndex(int index) {
    var title = '';
    if (index == 1) {
      title = 'Отсканируйте QR код';
    } else if (index == 2) {
      title = 'Просмотрите историю';
    } else if (index == 3) {
      title = 'Создайте мероприятие';
    } else if (index == 4) {
      title = 'Подтвердите';
    }
    return title;
  }
}
