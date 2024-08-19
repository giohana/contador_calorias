import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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
    }
  }

  Future<void> cameraButton() async {
    PermissionStatus? cameraPermissionStatus = await Permission.camera.status;
    PermissionStatus? storagePermissionStatus = await Permission.storage.status;

    if (cameraPermissionStatus.isGranted && storagePermissionStatus.isGranted) {
      getImage(ImageSource.camera);
      // TODO(giohana): aqui tinha setState aqui caso de erro
      selectedImage = File(cropped!.path);
    }
    await verifyAndroidVersion();
    if (storagePermissionStatus.isDenied) {
      Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.storage,
      ].request();
      storagePermissionStatus = permissionStatus[Permission.storage];
    }

    if (cameraPermissionStatus.isDenied) {
      Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.camera,
        Permission.videos,
        Permission.photos
      ].request();
      await verifyAndroidVersion();

      cameraPermissionStatus = permissionStatus[Permission.camera];
    }

    if (storagePermissionStatus!.isGranted &&
        cameraPermissionStatus!.isGranted) {
      getImage(ImageSource.camera);
      // TODO(giohana): aqui tinha setState aqui caso de erro
      selectedImage = File(cropped!.path);
    }
  }

  Future<void> galleryButton() async {
    PermissionStatus? storagePermissionStatus = await Permission.storage.status;
    PermissionStatus? photosPermissionStatus = await Permission.photos.status;
    PermissionStatus? videosPermissionStatus = await Permission.videos.status;

    if (storagePermissionStatus.isDenied ||
        photosPermissionStatus.isDenied ||
        videosPermissionStatus.isDenied) {
      Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.storage,
        Permission.videos,
        Permission.photos
      ].request();
      storagePermissionStatus = permissionStatus[Permission.storage];
      photosPermissionStatus = permissionStatus[Permission.photos];
      videosPermissionStatus = permissionStatus[Permission.videos];
    }
    getImage(ImageSource.gallery);
    // TODO(giohana): aqui tinha setState aqui caso de erro
    selectedImage = File(cropped!.path);
  }

  Future<void> verifyAndroidVersion() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    if (storageStatus.isGranted) {
      print("granted");
    }
    if (storageStatus.isDenied) {
      print("denied");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    if (storageStatus.isDenied) {
      await [
        Permission.storage,
      ].request();
    }
  }
}
