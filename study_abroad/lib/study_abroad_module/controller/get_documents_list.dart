import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/models/get_documents_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class GetDocumentsListController extends GetxController with StateMixin<GetDocumentsModel> {
  List<Result>? filteredDocs = RxList();

  getDocuments() async {
    const apiEndPoint = APIEndPoints.document;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("GetDocumentsList => getDocuments > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = GetDocumentsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
      filterDocuments(text: "");
    } catch (error) {
      debugPrint("---------- $apiEndPoint getDocuments End With Error ----------");
      debugPrint("GetDocumentsList => getDocuments > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getDocuments End ----------");
    }
  }

  filterDocuments({required String text}) {
    debugPrint("filter doc Started");
    final query = text.toLowerCase();
    final documents = state?.result ?? [];
    if (query.isEmpty) {
      filteredDocs = documents;
      debugPrint("query is empty and state is set to filterdoc");
    } else {
      final filtered = documents.where((docCategory) {
        final titleMatches = docCategory.title?.toLowerCase().contains(query) ?? false;

        final documentsMatch = (docCategory.documents)
                ?.any((doc) => doc.name?.toLowerCase().contains(query) ?? false) ??
            false;

        return titleMatches || documentsMatch;
      }).toList();
      filteredDocs = filtered;
      debugPrint("state is set to filterdoc with filter");
    }
  }

  List<Result>? filterOutAdditionalAndFinancial(List<Result>? documents) {
    // Filter out "Visa" and "Financial" sections
    return documents?.where((doc) => doc.title != "Visa" && doc.title != "Financial").toList();
  }

  List<Result>? filterVisaDocuments(List<Result>? documents) {
    // Filter only the section where the title is "VISA"
    return documents?.where((doc) => doc.title == "Visa").toList();
  }

  List<Result>? filterFinancialDocuments(List<Result>? documents) {
    // Filter only the section where the title is "Financial"
    return documents?.where((doc) => doc.title == "Financial").toList();
  }
}
