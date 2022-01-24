import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/event/widgets/event_item.dart';
import 'package:hse/viewmodels/bpm_models/event_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:hse/generated/l10n.dart';

class EventRegistry extends StatefulWidget {
  final EventModel eventModel;
  final UserInfoModel userModel;

  const EventRegistry(this.eventModel, this.userModel);

  @override
  _EventRegistryState createState() => _EventRegistryState();
}

class _EventRegistryState extends State<EventRegistry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Scrollbar(
              child: ListView.separated(
                  itemBuilder: (_, i) => InkWell(
                    child: EventItem(widget.eventModel.entities[i]),
                    onTap: () async {
                      await widget.eventModel
                          .openEntity(widget.eventModel.entities[i])
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
                  itemCount: widget.eventModel.entities.length),
            ),),
        SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: GFButton(
                onPressed: () async {
                  await widget.eventModel
                      .synchronize(widget.userModel)
                      .then((value) => setState(() {
                    // model.rebuild();
                  }),);
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
            ),),
      ],
    );
  }
}