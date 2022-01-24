import 'package:hse/core/model/bpm/abstract_bmp_entity.dart';
import 'package:hse/viewmodels/base_model.dart';

abstract class AbstractBpmModel<T extends AbstractBpmEntity> extends BaseModel {
  T entity;
  List<T> entities;

  Future getEntities();

  Future createEntity();

  Future saveEntity();

  Future<bool> validateRequiredFields();

  Future<void> openEntity(T entity);
}
