import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_result_new.dart';

///
/// Handle asset loading for docs
class DocsLoader {
  ///
  ///load md docs as [String]
  static Future<ResultF<String>> loadMDDoc(
      String relativePath, BuildContext context) async {
    try {
      final data = await rootBundle.loadString(
        relativePath,
      );
      return Ok(data);
    } catch (e, s) {
      return Err(Failure(message: e, stackTrace: s));
    }
  }
}
