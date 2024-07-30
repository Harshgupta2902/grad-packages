import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:study_abroad/study_abroad_module/controller/get_documents_list.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/components/message_scaffold.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/http_apis.dart';

final prefs = GetStorage();
final _getDocumentController = Get.put(GetDocumentsListController());
FilePickerResult? filePickerResult;
File? pickerFile;
PlatformFile? file;
String? fileName;
int? fileSize;

Future<PlatformFile?> pickFiles(BuildContext context, bool format,
    {required String docName}) async {
  try {
    final allowedExtensions =
        format ? ['docx', 'doc'] : ['docx', 'doc', 'xlsx', 'pdf', 'jpeg', 'jpg', 'png', 'txt'];

    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: false,
    );

    if (filePickerResult != null && filePickerResult?.files.isNotEmpty == true) {
      file = filePickerResult?.files.first;
      final fileExtension = path.extension(file!.name).replaceAll('.', '');
      if (allowedExtensions.contains(fileExtension)) {
        debugPrint("file:::::::::::$file");
        httpApi(
          endpoint: APIEndPoints.documentUpload,
          file: file!,
          additionalFields: {
            'subcategory_name': docName,
          },
        ).then((value) {
          Map<String, dynamic> responseBody = jsonDecode(value.body);
          final status = responseBody['status'].toString();
          debugPrint('status: $status');
          if (status == "1") {
            _getDocumentController.getDocuments();
            _getDocumentController.update();
            messageScaffold(
              context: context,
              content: "$docName is Uploaded",
              messageScaffoldType: MessageScaffoldType.error,
            );
          }
        });
        return file;
      } else {
        Future.delayed(
          Duration.zero,
          () => messageScaffold(
            context: context,
            content: "Please select a file with a valid extension",
            messageScaffoldType: MessageScaffoldType.error,
          ),
        );
        throw Exception('Invalid file extension');
      }
    } else {
      debugPrint('Please select a file');
      throw Exception('No file selected');
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
    rethrow;
  } catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
}

pickFile({context, bool formatChange = false, required String docName}) async {
  return await pickFiles(context, formatChange, docName: docName);
}
