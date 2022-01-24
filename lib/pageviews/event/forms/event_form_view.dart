import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/model/event/events.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/bsa/widgets/status_widget.dart';
import 'package:hse/pageviews/event/widgets/files_widget.dart';
import 'package:hse/viewmodels/bpm_models/event_model.dart';
import 'package:provider/provider.dart';
import 'package:hse/generated/l10n.dart';

class EventFormView extends StatefulWidget {
  const EventFormView({Key key}) : super(key: key);

  @override
  _EventFormViewState createState() => _EventFormViewState();
}

class _EventFormViewState extends State<EventFormView> {
  EventManagement event;
  EventModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<EventModel>(context);
    event = model.entity;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('LT' +
            '-' +
            '${model.entity?.regNumber == null ? ' Не зарегистрирован ' : formatFullRestNotMilSec(model.entity.initDate)}' +
            '${model.entity.regNumber == null ? '' : '№ ${model.entity.regNumber}'}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BsaStatusWidget(model.entity.status),
            info(),
            probability(),
            photos(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: GFButton(
                onPressed: () => Get.back(),
                text: S.current.back.toUpperCase(),
                textStyle: generalFontStyle.copyWith(
                    color: Colors.white,
                    fontSize: defaultFontSize + 10,
                    fontWeight: FontWeight.bold),
                color: appGreenColor,
                size: 52,
                blockButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget info() {
    return ExpansionTile(
      title: Text(S.current.generalInformation),
      initiallyExpanded: true,
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        FieldBones(
          placeholder: S.current.basisDoc,
          textValue: model.entity.supportDocument?.supportDocNumber ?? '',
        ),
        FieldBones(
            placeholder: S.current.planningPeriod,
            textValue:
            '${formatFullRestNotMilSec(model.entity.planDateFrom)} - ${formatFullRestNotMilSec(model.entity.planDateTo)}'),
        FieldBones(
            placeholder: S.current.actualPeriod,
            textValue:
            '${formatFullRestNotMilSec(model.entity.actualDateFrom)} - ${formatFullRestNotMilSec(model.entity.actualDateTo)}'),
        FieldBones(
          placeholder: S.current.priority,
          textValue: model.entity?.sevirity?.langValue ?? '',
        ),
        FieldBones(
            placeholder: S.current.controlling,
            textValue:
            "${model.entity?.supervisor?.lastName ?? ""} ${model.entity?.supervisor?.firstName ?? ""} ${model.entity?.supervisor?.middleName ?? ""}"),
        FieldBones(
            placeholder: S.current.observer,
            textValue:
            "${model.entity?.observer?.lastName ?? ""} ${model.entity?.observer?.firstName ?? ""} ${model.entity?.observer?.middleName ?? ""}"),
        FieldBones(
          placeholder: S.current.eventDescription,
          textValue: model.entity?.eventDescription ?? '',
        ),
        FieldBones(
          placeholder: S.current.comment,
          textValue: model.entity?.comment ?? '',
        ),
      ],
    );
  }

  Widget probability() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.completionPercent),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        Row(
          children: [
            Text(
              '${model.entity?.finishPercent?.toInt() ?? 0}% завершено',
              style: generalFontStyle,
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: appLightOrangeColor,
                  inactiveTrackColor: Colors.black12,
                  trackHeight: 30.0,
                  tickMarkShape: RoundSliderTickMarkShape(),
                  thumbColor: appLightPurpleColor,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 17.0),
                ),
                child: Slider(
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  value: model.entity?.finishPercent?.toDouble() ?? 0.0,
                  onChanged: (newCommission) {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget photos() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.photoFixation),
      children: [
        EventFilesWidgetSlider(model, false),
      ],
    );
  }
}