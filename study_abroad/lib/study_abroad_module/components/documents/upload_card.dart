import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/components/documents/upload_button.dart';
import 'package:utilities/theme/app_colors.dart';

class UploadCard extends StatefulWidget {
  const UploadCard({super.key});

  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset(
                  StudyAbroadAssetPath.upload,
                  height: 30,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Upload Additional Documents",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Documents which don't come under Application, Visa & Financial Type",
                  textAlign: TextAlign.center,
                  style:
                      Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.subtitle),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.subtitle,
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: () async {
                    await pickFile(context: context, docName: "Other Document");
                  },
                  child: const Text("Upload"),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
