import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:utilities/components/gradding_app_bar.dart';

class PolicyViewer extends StatelessWidget {
  const PolicyViewer({super.key, this.title, this.policy});
  final String? title;
  final String? policy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GraddingAppBar(
        backButton: true,
        title: title,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Html(data: policy),
      ),
    );
  }
}
