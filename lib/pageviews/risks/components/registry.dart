import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/risks/widgets/risks_item.dart';
import 'package:hse/viewmodels/bpm_models/risks_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:hse/generated/l10n.dart';

class RisksManagementRegistry extends StatefulWidget {
  final RisksModel risksModel;
  final UserInfoModel userModel;

  const RisksManagementRegistry(this.risksModel, this.userModel);

  @override
  _RisksManagementRegistryState createState() => _RisksManagementRegistryState();
}

class _RisksManagementRegistryState extends State<RisksManagementRegistry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Scrollbar(
              child: ListView.separated(
                  itemBuilder: (_, i) => InkWell(
                    child: RisksItem(widget.risksModel.entities[i]),
                    onTap: () async {
                      await widget.risksModel
                          .openEntity(widget.risksModel.entities[i])
                          .then((_) {
                        setState(() {
                          print('back2');
                        });
                      });
                    },
                  ),
                  separatorBuilder: (context, index) {
                    return Divider(height: 1,);
                  },
                  itemCount: widget.risksModel.entities.length),
            )),
        SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: GFButton(
                onPressed: () async {
                  await widget.risksModel
                      .synchronize(widget.userModel)
                      .then((value) => setState(() {
                    // model.rebuild();
                  }));
                },
                text: S.current.sync.toUpperCase(),
                textStyle: generalFontStyle.copyWith(
                    color: Colors.white,
                    fontSize: defaultFontSize + 10,
                    fontWeight: FontWeight.bold),
                color: appGreenColor,
                size: 52,
                blockButton: true,
              ),
            ))
      ],
    );
  }
}