import 'package:hse/core/model/anthropometry/Anthropometry.dart';
import 'package:hse/core/model/placement/Placement.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/viewmodels/base_model.dart';

class Profile extends BaseModel {
  Anthropometry _anthropometry;
  Placement _placement;

  String index = '/assignment';

  Future<Anthropometry> get anthropometry async {
    if (_anthropometry != null) {
      return _anthropometry;
    } else {
      _anthropometry = await RestServices.getAnthropometry();
      return _anthropometry;
    }
  }

  Future<Placement> get placement async {
    _placement ??= await RestServices.getPlacement();
    return _placement;
  }
}
