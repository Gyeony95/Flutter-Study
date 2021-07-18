import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gyeony_diary/util/navigator_manage.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  factory PermissionManager() => _instance;

  static final _instance = PermissionManager.private();

  final _navigatorKey = NavigatorManager().navigatorKey;

  @visibleForTesting
  PermissionManager.private();

  Future<bool> checkPermission(Permission permission) async {
    try {
      final permissionStatus = await permission.status;
      debugPrint('ghghgh permission '+permissionStatus.toString());
      final permissionCheck = await permission.request();
      if (Platform.isAndroid) {
        //GHGHGH SDK 버전업
        if (permissionStatus == PermissionStatus.denied){
          if(permissionCheck == PermissionStatus.permanentlyDenied){
            await _showAppSettingPopup();
            return false;
          }else if(permissionCheck == PermissionStatus.denied){
            await Fluttertoast.showToast(
              msg: '권한이 거부되었습니다.',
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 3,
            );
            return false;
          }

          // final isGranted = await permission.request().isGranted;
          // if (!isGranted) {
          //   await Fluttertoast.showToast(
          //     msg: '권한이 거부되었습니다.',
          //     toastLength: Toast.LENGTH_LONG,
          //     timeInSecForIosWeb: 3,
          //   );
          //   return false;
          // }
        } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
          await _showAppSettingPopup();
          return false;
        }
      }
      // iOS
      else {

        // //GHGHGH SDK 버전업
        // if (permissionStatus == PermissionStatus.denied) {
        //   // if (permissionStatus == PermissionStatus.undetermined) {
        //   final isGranted = await permission.request().isGranted;
        //   if (!isGranted) {
        //     // await Fluttertoast.showToast(
        //     //   msg: '권한이 거부되었습니다.',
        //     //   toastLength: Toast.LENGTH_LONG,
        //     //   timeInSecForIosWeb: 3,
        //     // );
        //     return false;
        //   }
        // }

        if (permissionStatus == PermissionStatus.denied) {
          // await _showAppSettingPopup();
          // return false;
          if(permissionCheck == PermissionStatus.permanentlyDenied){
            await _showAppSettingPopup();
            return false;
          }else if(permissionCheck == PermissionStatus.denied){
            await Fluttertoast.showToast(
              msg: '권한이 거부되었습니다.',
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 3,
            );
            return false;
          }
        }else if (permissionStatus == PermissionStatus.permanentlyDenied) {
          await _showAppSettingPopup();
          return false;
        }
      }
    } catch (e) {
      await Fluttertoast.showToast(
        msg: '권한 요청에 실패했습니다.',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 3,
      );
      return false;
    }
    return true;
  }

  Future<void> _showAppSettingPopup() => showCupertinoDialog(
    context: _navigatorKey.currentState.overlay.context,
    builder: (context) => CupertinoAlertDialog(
      title: Text('권한'),
      content: Text('접근 권한이 없어 해당 기능을 사용할 수 없습니다.\n권한을 허용하시려면 설정을 눌러주세요.' ,textAlign: TextAlign.left,),
      actions: <Widget>[
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text('취소'),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: Text('설정'),
          onPressed: () async {
            Navigator.pop(context);
            await openAppSettings();
          },
        ),
      ],
    ),
  );
}
