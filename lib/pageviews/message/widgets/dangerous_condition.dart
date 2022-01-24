import 'package:flutter/material.dart';
import 'package:hse/core/model/message/condition_category.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';

class DangerousConditionCategoryItem extends StatefulWidget {
  final ConditionCategory item;
  final MessageModel model;
  final bool editable;

  const DangerousConditionCategoryItem(this.item, this.model,
      [this.editable = true]);

  @override
  _DangerousConditionCategoryItemState createState() =>
      _DangerousConditionCategoryItemState();
}

class _DangerousConditionCategoryItemState
    extends State<DangerousConditionCategoryItem> {

  @override
  Widget build(BuildContext context) {
    var conditions = '';

    for (var e in widget.item.conditions) {
      if (widget.item.conditions.first == e) {
        conditions = conditions + e.langValue;
      } else {
        conditions = conditions + ', ' + e.langValue;
      }
    }
    var contains = false;
    if( widget.model.entity.dangerousConditionCategories != null) {
      for (var c in widget.model.entity.dangerousConditionCategories) {
        if (c.id == widget.item.id) {
          contains = true;
          break;
        } else {
          contains = false;
        }
      }
    }
    var content = Column(
      children: [
        Row(
          children: [
            Image.asset('assets/images/alert.png', width: 48, height: 48,),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
                  widget.item.langValue.toUpperCase(),
                  style:
                  generalFontStyle.copyWith(color: appBlackColor, fontSize: 16),
                )),
            Icon(
              contains
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              size: 32,
              color: contains ? appGreenColor : appDarkGrayColor,
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Divider(height: 1, thickness: 2,),
        Row(
          children: [
            SizedBox(
              width: 56,
            ),
            Expanded(
                child: Text(
                  conditions,
                  style: generalFontStyle.copyWith(
                      color: appDarkGrayColor, fontSize: 12),
                ))
          ],
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
    return Container(
        padding: EdgeInsets.zero,
        child: widget.editable
            ? InkWell(
          child: content,
          onTap: () {
            if (contains) {
              setState(() {
                widget.model.entity.dangerousConditionCategories
                    .removeWhere((element) => element.id == widget.item.id);
              });
            } else if (!contains) {
              setState(() {
                widget.model.entity.dangerousConditionCategories.add(widget.item);
              });
            }
            print(widget.model.entity.dangerousConditionCategories.length);
          },
        )
            : content);
  }
}
