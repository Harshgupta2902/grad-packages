// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
// import 'package:study_abroad/study_abroad_module/components/documents/upload_button.dart';
// import 'package:utilities/components/gradding_app_bar.dart';
// import 'package:utilities/theme/app_box_decoration.dart';
// import 'package:utilities/theme/app_colors.dart';
//
// class UploadPage extends StatefulWidget {
//   const UploadPage({super.key, required this.docType});
//
//   final String docType;
//
//   @override
//   State<UploadPage> createState() => _UploadPageState();
// }
//
// class _UploadPageState extends State<UploadPage> {
//   // PlatformFile? localFile;
//   List<PlatformFile>? localFiles;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: GraddingAppBar(
//         backButton: true,
//         title: widget.docType,
//         showActions: false,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
//           child: Column(
//             children: [
//               const SizedBox(height: kToolbarHeight),
//               SvgPicture.asset(
//                 StudyAbroadAssetPath.upload,
//                 height: 40,
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 "Upload File From Device",
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 "Supported formats: docx, dox, xlsx, pdf, jpeg, jpg, png, txt",
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.boulder),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 "Size Limit: 10MB",
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.boulder),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(100, 40),
//                   backgroundColor: AppColors.whiteSmoke,
//                   foregroundColor: Colors.black,
//                 ),
//                 onPressed: () => pickFile(context: context),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SvgPicture.asset(StudyAbroadAssetPath.file),
//                     const SizedBox(width: 12),
//                     const Text("Select File"),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               if (localFiles != null) ...[
//                 Text("Selected files: ${localFiles!.length}"),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: localFiles!.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(localFiles![index].name),
//                       trailing: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             localFiles!.removeAt(index);
//                           });
//                         },
//                         child: const Icon(
//                           Icons.cancel,
//                           color: AppColors.aluminium,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> pickFile({required BuildContext context, bool formatChange = false}) async {
//     final files = await pickFiles(context, formatChange);
//     if (files != null) {
//       setState(() {
//         localFiles = files;
//       });
//     }
//   }
// }
