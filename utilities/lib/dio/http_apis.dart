import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

Future<http.Response> httpApi({
  required String endpoint,
  PlatformFile? file,
  XFile? image,
  required Map<String, String>? additionalFields,
}) async {
  final uri = Uri.parse("https://www.gradding.com/api/mobile-api/v1/$endpoint");
  final prefs = GetStorage();
  var token = prefs.read('TOKEN');

  try {
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path!,
        filename: path.basename(file.path!),
      ));
    }
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: path.basename(image.path),
      ));
    }

    if (additionalFields != null) {
      request.fields.addAll(additionalFields);
      debugPrint(additionalFields.toString());
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      debugPrint('Api $endpoint Run successfully');
      return response;
    } else {
      debugPrint('Api $endpoint failed with status: ${response.statusCode}');
      throw Exception('Failed to upload file');
    }
  } catch (e) {
    debugPrint('Exception during file upload: $e');
    throw Exception('Failed to upload file');
  }
}
