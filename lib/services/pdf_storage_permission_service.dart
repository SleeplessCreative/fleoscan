import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class StoragePermission {
  Permission permission = Permission.storage;
  PermissionStatus permissionStatus;

  Future getStatus() async {
    permissionStatus = await permission.status;
  }

  Future<bool> getPermission() async {
    await getStatus();
    if (permissionStatus == PermissionStatus.undetermined) {
      await permission.request();
      await getStatus();
    }
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }
    return false;
  }
}
