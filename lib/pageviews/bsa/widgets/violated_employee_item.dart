import 'package:flutter/material.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class ViolatedEmployeeBsaItem extends StatelessWidget {
  final Person person;
  final bool current;
  final bool editable;
  final bool isPop;
  final Function onTapPop;
  final Function remove;

  const ViolatedEmployeeBsaItem(
      {@required this.person,
        this.current = false,
        this.onTapPop,
        this.remove,
        this.editable = true,
        this.isPop = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: current ? appBlueColor.withOpacity(0.2) : null,
      child: ListTile(
        leading: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              color: appBlueColor, borderRadius: BorderRadius.circular(25)),
          child: Icon(Icons.person, color: appWhiteColor),
          // person.photo?.id != null
          //     ? Image.network(Kinfolk.getFileUrl(person.photo.id))
          //     :
        ),
        contentPadding: EdgeInsets.zero,
        title: Text(person.firstName + ' ' + person.lastName,
          style: generalFontStyle.copyWith(fontSize: defaultFontSize - 1),),
        subtitle: Text('ИИН: ${person.nationalIdentifier}'),
           onTap: onTapPop,
        trailing: isPop
            ? current
            ? Icon(Icons.check_circle_outline, color: appBlueColor)
            : null
            : editable
            ? IconButton(
          icon: Icon(Icons.remove_circle_outline_outlined, color: appRedColor,),
          onPressed: remove,
        )
            : null,
      ),
    );
  }
}