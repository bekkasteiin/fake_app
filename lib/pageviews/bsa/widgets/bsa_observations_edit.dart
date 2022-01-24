import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/model/bsa/observation.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/bsa/widgets/observation_item.dart';
import 'package:hse/viewmodels/bpm_models/bsa_model.dart';
import 'package:hse/generated/l10n.dart';

class BsaObservationsEdit extends StatefulWidget {
  BsaModel model;
  AbstractDictionary category;
  BsaObservationsEdit(this.model, this.category);

  @override
  _BsaObservationsEditState createState() => _BsaObservationsEditState();
}

class _BsaObservationsEditState extends State<BsaObservationsEdit> {
  var size;
  Observation observation;
  var isNew = false;

  ScrollController scrollController;

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(hideKeyboard);
    var result = widget.model.chekObservation(widget.category, true);
    if (result is Observation) {
      observation = result;
    } else {
      observation = Observation();
      isNew = true;
    }
    observation.observationCategory = widget.category;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(observation.observationCategory.langValue),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            info(),
            savedCancelButton(),
          ],
        ),
      ),
    );
  }

  Widget info() {
    return observation.id == null
        ? ExpansionTile(
            title: Text(S.current.observationCategory),
            initiallyExpanded: true,
            childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            children: [
              FieldBones(
                placeholder: S.current.situationType,
                textValue:
                    observation?.observationKindSitutation?.langValue ?? '',
                icon: Icons.arrow_drop_down_circle_outlined,
                iconColor: appBlueColor,
                selector: () => situation(),
              ),
              FieldBones(
                placeholder: S.current.severityConsequences,
                textValue:
                    observation?.observationSevirityConsequences?.langValue ??
                        '',
                icon: Icons.arrow_drop_down_circle_outlined,
                iconColor: appBlueColor,
                selector: () => consequences(),
              ),
              FieldBones(
                placeholder: S.current.dangerType,
                textValue: observation?.observationKindDanger?.langValue ?? '',
                icon: Icons.arrow_drop_down_circle_outlined,
                iconColor: appBlueColor,
                selector: () => danger(),
              ),
              FieldBones(
                  placeholder: S.current.comment,
                  textValue: observation?.comment ?? '',
                  isTextField: true,
                  maxLines: 3,
                  onChanged: (val) {
                    observation.comment = val;
                  }),
            ],
          )
        : ExpansionTile(
            title: Text(S.current.observationCategory),
            initiallyExpanded: true,
            childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            children: [
              FieldBones(
                placeholder: S.current.situationType,
                textValue:
                    observation?.observationKindSitutation?.langValue ?? '',
              ),
              FieldBones(
                placeholder: S.current.severityConsequences,
                textValue:
                    observation?.observationSevirityConsequences?.langValue ??
                        '',
              ),
              FieldBones(
                placeholder: S.current.dangerType,
                textValue: observation?.observationKindDanger?.langValue ?? '',
              ),
              FieldBones(
                placeholder: S.current.comment,
                textValue: observation.comment ?? '',
              ),
            ],
          );
  }

  Widget savedCancelButton() {
   return Container(
     child:  observation.id == null
         ? Container(
       margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(11.0),
           border: Border.all(color: appGreenColor, width: 2)),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Expanded(
             child: GFButton(
               onPressed: () async {
                 var validate =
                 await widget.model.validateObservation(observation);
                 if (validate) {
                   observation.isChecked = true;
                   if (isNew) {
                     widget.model.entity.observations.add(observation);
                   } else {
                     var index = widget.model
                         .getIndexByObservationCategory(
                         observation.observationCategory);
                     widget.model.entity.observations[index] = observation;
                   }
                   Get.back();
                 }
               },
               text: S.current.confirm.toUpperCase(),
               textStyle: generalFontStyle.copyWith(
                   color: Colors.white,
                   fontSize: defaultFontSize + 4,
                   fontWeight: FontWeight.bold),
               color: appGreenColor,
               size: 52,
               blockButton: true,
             ),
           ),
           Expanded(
             child: GFButton(
               onPressed: () {
                 Get.back();
               },
               text: S.current.canceling.toUpperCase(),
               textStyle: generalFontStyle.copyWith(
                   color: appGreenColor,
                   fontSize: defaultFontSize + 4,
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
     )
         : Padding(
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
   );
  }

  danger() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0.6,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: size.height * (0.7),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 5,
                    width: size.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appBlueColor.withOpacity(0.4),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    S.current.chooseSituation,
                    style: generalFontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultFontSize + 2),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: appWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, i) {
                          var current = false;
                          return InkWell(
                            child: ObservationItem(
                                widget.model.kindDanger[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                observation.observationKindDanger =
                                    widget.model.kindDanger[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              height: 1,
                            ),
                        itemCount: widget.model.kindDanger?.length ?? 0),
                  ),
                ),
              ],
            ),
          );
        });
  }

  consequences() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0.6,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: size.height * (0.7),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 5,
                    width: size.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appBlueColor.withOpacity(0.4),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    S.current.chooseSituation,
                    style: generalFontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultFontSize + 2),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: appWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, i) {
                          var current = false;
                          return InkWell(
                            child: ObservationItem(
                                widget.model.kindConsequences[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                observation.observationSevirityConsequences =
                                    widget.model.kindConsequences[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(height: 1),
                        itemCount: widget.model.kindConsequences?.length ?? 0),
                  ),
                ),
              ],
            ),
          );
        });
  }

  situation() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0.6,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: size.height * (0.7),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 5,
                    width: size.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appBlueColor.withOpacity(0.4),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    S.current.chooseDangerSource,
                    style: generalFontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultFontSize + 2),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: appWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, i) {
                          var current = false;
                          return InkWell(
                            child: ObservationItem(
                                widget.model.kindSituation[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                observation.observationKindSitutation =
                                    widget.model.kindSituation[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(height: 1),
                        itemCount: widget.model.kindSituation?.length ?? 0),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
