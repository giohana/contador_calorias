import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenCameraController {
  final picker = ImagePicker();
  File? selectedImage;
  CroppedFile? cropped;

  getImage(ImageSource src) async {
    final pickedFile = await picker.pickImage(source: src);
    if (pickedFile != null) {
      cropped = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Camera',
          ),
          IOSUiSettings(
            title: 'Camera',
          ),
        ],
      );
    } else {
      cropped = null;
    }
  }

  Future<File?> cameraButton() async {
    PermissionStatus? cameraPermissionStatus = await Permission.camera.status;

    if (cameraPermissionStatus.isDenied) {
      Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.camera,
      ].request();
      cameraPermissionStatus = permissionStatus[Permission.storage];
    }
    cropped = null;
    selectedImage = null;
    await getImage(ImageSource.camera);
    selectedImage = File(cropped!.path);
    return selectedImage;
  }
}
