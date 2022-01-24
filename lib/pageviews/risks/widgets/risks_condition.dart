import 'package:flutter/material.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/bpm_models/risks_model.dart';

class RisksConditionCategoryItem extends StatefulWidget {
  final AbstractDictionary item;
  final RisksModel model;
  final bool editable;

  const RisksConditionCategoryItem(this.item, this.model, [this.editable = true]);

  @override
  _RisksConditionCategoryItemState createState() => _RisksConditionCategoryItemState();
}

class _RisksConditionCategoryItemState extends State<RisksConditionCategoryItem> {
  @override
  Widget build(BuildContext context) {
    var contains = false;
    if(widget.model.entity.riskManageability != null) {
      for (var c in widget.model.entity.riskManageability) {
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
        ListTile(
          title: Text(
            widget.item.langValue.toUpperCase(),
            style: generalFontStyle.copyWith(color: appBlackColor, fontSize: 16),),
          trailing:  Icon(
            contains
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank,
            size: 35,
            color: appGreenColor,
          ),
        ),
      ],);
    return Container(
        padding: EdgeInsets.zero,
        child: widget.editable
            ? InkWell(
          child: content,
          onTap: () {
            if (contains) {
              setState(() {
                widget.model.entity.riskManageability
                    .removeWhere((element) => element.id == widget.item.id);
              });
            } else if (!contains) {
              setState(() {
                widget.model.entity.riskManageability.add(widget.item);
              });
            }
          },
        )
            : content);
  }
}
