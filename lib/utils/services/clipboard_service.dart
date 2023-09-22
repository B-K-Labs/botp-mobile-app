import 'package:flutter/services.dart';

Future<void> setClipboardData(String? textData) async =>
    await Clipboard.setData(ClipboardData(text: textData ?? ""));
