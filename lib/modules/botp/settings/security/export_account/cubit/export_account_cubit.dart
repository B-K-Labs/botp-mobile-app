import 'dart:io';
import 'dart:ui' as ui;
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/security/export_account/cubit/export_account_state.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class SecurityExportAccountCubit extends Cubit<SecurityExportAccountState> {
  bool _isSavingQrImage = false;

  SecurityExportAccountCubit() : super(SecurityExportAccountState()) {
    _readPrivateKey();
  }

  // Load private key only
  _readPrivateKey() async {
    final accountData = await UserData.getCredentialAccountData();
    emit(state.copyWith(
        privateKey: accountData!.privateKey,
        loadUserDataStatus: LoadUserDataStatusSuccess()));
  }

  flipQrImage() =>
      emit(state.copyWith(isHiddenQrImage: !state.isHiddenQrImage));
  saveQrImage(GlobalKey qrImageKey) async {
    if (_isSavingQrImage) return;
    _isSavingQrImage = true;
    // PermissionStatus res;
    // res = await Permission.storage.request();
    // if (res.isGranted) {
    try {
      final boundary = qrImageKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      // Increase the QR image size (padding with white space ?)
      final image = await boundary.toImage(pixelRatio: 5.0);
      final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        // Save temporarily the image
        final directory = (await getTemporaryDirectory()).path;
        final imgFile =
            File('$directory/${DateTime.now()}_${"qr"}.png'); // From dart:io
        imgFile.writeAsBytes(pngBytes);
        // Save image to user gallery
        await GallerySaver.saveImage(imgFile.path,
            albumName: "BOTP Authenticator");
        emit(state.copyWith(saveQrImageStatus: RequestStatusSuccess()));
      }
    } on Exception catch (e) {
      emit(state.copyWith(saveQrImageStatus: RequestStatusFailed(e)));
    }
    _isSavingQrImage = false;
    emit(state.copyWith(saveQrImageStatus: const RequestStatusInitial()));
  }
}
