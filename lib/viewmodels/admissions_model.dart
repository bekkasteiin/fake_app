import 'package:hse/core/model/check_points/CheckPoint.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/viewmodels/base_model.dart';

class CheckPointModel extends BaseModel {
  CheckPoint _checkpoints;

  Future<CheckPoint> get checkpoints async {
    _checkpoints ??= await RestServices.getCheckPoints();
    return _checkpoints;
  }
}
