import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/components/documents/all_documents.dart';
import 'package:study_abroad/study_abroad_module/controller/get_documents_list.dart';
import 'package:utilities/components/custom_tab_bar.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/try_again.dart';
import 'package:utilities/form_fields/custom_text_fields.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _getDocumentsController = Get.put(GetDocumentsListController());

class DocumentsCenter extends StatefulWidget {
  const DocumentsCenter({super.key});

  @override
  State<DocumentsCenter> createState() => _DocumentsCenterState();
}

class _DocumentsCenterState extends State<DocumentsCenter> with SingleTickerProviderStateMixin {
  final TextEditingController _searchTextController = TextEditingController();
  int? initialIndex;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getDocumentsController.getDocuments();
    _searchTextController.addListener(_onSearchTextChanged);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _searchTextController.addListener(_onSearchTextChanged);
    _searchTextController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    _getDocumentsController.filterDocuments(text: _searchTextController.text);
    if (_searchTextController.text.isNotEmpty) {
      _tabController.index = 0;
    }
    if (_searchTextController.text.isEmpty) {
      setState(() {
        _getDocumentsController.filteredDocs = _getDocumentsController.state?.result;
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const GraddingAppBar(
          backButton: true,
        ),
        body: _getDocumentsController.obx(
          (state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 12, showShadow: false),
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: DefaultTabController(
                initialIndex: initialIndex ?? 0,
                length: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Documents",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Upload and track all your documents right here!",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.cadetGrey),
                      ),
                    ),
                    const SizedBox(height: 6),
                    CustomTabBar(
                      tabController: _tabController,
                      tabAlignment: TabAlignment.start,
                      borderRadius: 14,
                      tabList: const [
                        "All Documents",
                        "Application",
                        "Visa",
                        "Financial",
                        "Additional Documents",
                      ],
                      isScrollable: true,
                      horizontalPadding: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomTextFormField(
                        controller: _searchTextController,
                        hintText: "Search Document by Name or Type",
                        suffix: const Icon(
                          Icons.search,
                          color: AppColors.aluminium,
                        ),
                      ),
                    ),
                    Flexible(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          AllDocuments(
                            result: _getDocumentsController.filteredDocs,
                          ),
                          AllDocuments(
                            result: _getDocumentsController
                                .filterOutAdditionalAndFinancial(state?.result),
                            isSingle: true,
                          ),
                          AllDocuments(
                            result: _getDocumentsController.filterVisaDocuments(state?.result),
                            isSingle: true,
                          ),
                          AllDocuments(
                            result: _getDocumentsController.filterFinancialDocuments(state?.result),
                            isSingle: true,
                          ),
                          AllDocuments(
                            result: state?.result,
                            isOther: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          onError: (error) => TryAgain(
            onTap: () => _getDocumentsController.getDocuments(),
          ),
        ),
      ),
    );
  }
}
