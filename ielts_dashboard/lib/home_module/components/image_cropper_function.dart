import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utilities/theme/app_colors.dart';

Future<XFile?> imageCropperFunction({XFile? imagePath}) async {
  if (imagePath == null) {
    return null;
  }

  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imagePath.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ],
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: AppColors.primaryColor,
        toolbarWidgetColor: AppColors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );

  if (croppedFile != null) {
    return XFile(croppedFile.path);
  } else {
    return null;
  }
}
