import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/model/bsa/bsa.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/bsa/widgets/bsa_observations_edit.dart';
import 'package:hse/pageviews/bsa/widgets/files_widget.dart';
import 'package:hse/pageviews/bsa/widgets/status_widget.dart';
import 'package:hse/pageviews/bsa/widgets/violated_employee_item.dart';
import 'package:hse/viewmodels/bpm_models/bsa_model.dart';
import 'package:hse/generated/l10n.dart';
import 'package:provider/provider.dart';

class BsaFormView extends StatefulWidget {
  const BsaFormView({Key key}) : super(key: key);

  @override
  _BsaFormViewState createState() => _BsaFormViewState();
}

class _BsaFormViewState extends State<BsaFormView> {
  BehaviorAudit behavior;
  BsaModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<BsaModel>(context);
    behavior = model.entity;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(S.current.bsa +
            '-' +
            '${model.entity?.regDateTime == null ? ' Не зарегистрирован ' : formatFullRestNotMilSec(model.entity.regDateTime)}' +
            '${model.entity.regNumber == null ? '' : '№ ${model.entity.regNumber}'}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BsaStatusWidget(model.entity.status),
            info(),
            auditList(),
            description(),
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
          placeholder: S.current.legalEntity,
          textValue: model.entity.organization.organizationName ?? '',
        ),
        FieldBones(
            placeholder: S.current.department,
            textValue: model.entity?.department?.departmentName ?? ''),
        FieldBones(
          placeholder: S.current.workplace,
          textValue: model.entity?.objectName?.langValue ?? '',
        ),
      ],
    );
  }

  Widget auditList() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.auditors),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        SizedBox(height: 8),
        ...model.entity.responsibles
            .map(
              (e) => ViolatedEmployeeBsaItem(
                person: e,
                editable: false,
              ),
            )
            .toList(),
        SizedBox(height: 8),
      ],
    );
  }

  Widget description() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.observationDescription),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        FieldBones(
          placeholder: S.current.workType,
          textValue: model.entity?.workType ?? '',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.auditDuration,
              style: generalFontStyle,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(8.0),
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: appDarkGrayColor, width: 0.5)),
              child: Text(
                model.entity?.duration.toString() ?? '',
                style: generalFontStyle.copyWith(color: appBlackColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.observed,
              style: generalFontStyle,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(8),
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: appDarkGrayColor, width: 0.5)),
              child: Text(model.entity?.watchedQuantity.toString() ?? '',
                  style: generalFontStyle.copyWith(color: appBlackColor),
                  textAlign: TextAlign.end),
            ),
          ],
        ),
        Column(
          children: model.entity.observations.map((e) {
            return Column(
              children: [
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BsaObservationsEdit(model, e.observationCategory),
                        ),
                      );
                    },
                    leading: Text(e.observationCategory.langValue,
                        style: generalFontStyle.copyWith(color: appBlackColor)),
                    trailing: Icon(Icons.check_box_outlined,
                        color: appGreenColor, size: 35)),
                Divider(
                  height: 1,
                )
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 15.0),
        FieldBones(
          placeholder: S.current.correctiveAction,
          textValue: model.entity?.actionDescription ?? '',
          isRequired: true,
        ),
        FieldBones(
          placeholder: S.current.employeesOffer,
          textValue: model.entity?.empComment ?? '',
        ),
      ],
    );
  }

  Widget photos() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.photoFixation),
      children: [
        BsaFilesWidgetSlider(model, false),
      ],
    );
  }
}
