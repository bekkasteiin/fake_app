import 'package:flutter/cupertino.dart';
import 'package:hse/core/utils/routes.dart';

class AccessCategoryService {
  static List<String> accessList = <String>[];
  static Map<String, String> routeCodeMap = {
    '/tasks': 'TASK_ORDERS',
    '/food': 'EATING',
    '/ppe': 'PPE',
    '/testing': 'TESTING',
    '/admissions': 'ADMISSIONS',
    '/order': 'TRANSPORT_ORDER',
    'qr_scan_button': 'QR_PPE_SCAN',
    'notification_navigation_bar': 'NAVBAR_NOTIFICATION',
    'salary_navigation_bar': 'NAVBAR_SALARY',
    '/obligations': 'OBLIGATIONS',
    Routes.message: 'MESSAGE',
    Routes.behavioralAudit: 'BEHAVIORAL_AUDIT',
    Routes.risksManagement: 'RISKS_MANAGEMENT',
    Routes.auditManagement: 'AUDIT_MANAGEMENT',
  };

  static bool isAllowed(String code) {
    if (accessList != null) {
      return accessList.contains(code);
    }
  }

  static bool truncateAllowance() {
    accessList.clear();
    return true;
  }

  static bool addNewAllowance(List<String> code) {
    accessList.addAll(code);
    return true;
  }

  static bool getAllowanceByName(String route) {
    if (route == '/appeals') {
      return true;
    }
    return AccessCategoryService.isAllowed(routeCodeMap[route]);
  }
}
