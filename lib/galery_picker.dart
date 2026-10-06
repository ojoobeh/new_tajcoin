import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shimmer/main.dart';
import 'package:solar_datepicker/solar_datepicker.dart';
import 'package:webazin/webazin/utility/get.dart';

// import 'dart:html' as html;
void openPicker({
  required final Function(List<File> res) action,
  final Function(double size)? imageSize,
  final FileType? type,
  final List<String>? allowedExtensions,
  final int? maxFileSize,
  final bool? allowMultiple,
  final bool? onlyJpgPng,
  final int? maxDuration,
  final bool? usedCameraButton,
  final CropAspectRatio? cropAspectRatio,
  final bool? enableCropping,
}) async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: allowMultiple ?? false,
    type: type ?? FileType.image,
    initialDirectory: 'ddddd',

    allowedExtensions: allowedExtensions,
  );

  finalFiles.clear();
  cropCount = 0;
  final List<PlatformFile> files = result?.files ?? <PlatformFile>[];

  final int size = files.lastOrNull?.size ?? 0;

  if (onlyJpgPng ?? false) {
    List<String> justJpgPng = <String>[];
    for (int i = 0; i < files.length; i++) {
      String _p = (files[i].path ?? '').split('.').last;
      debugPrint(_p);
      if (_p.toLowerCase() == 'jpg' || _p.toLowerCase() == 'jpeg' || _p.toLowerCase() == 'png') {
        justJpgPng.add(_p);
      }
    }
    if (justJpgPng.length == files.length) {
      if (size < (maxFileSize ?? 1000000000)) {
        if ((enableCropping ?? true) && (type ?? FileType.image) == FileType.image) {
          cropper(
            files: files,
            cropAspectRatio: cropAspectRatio,
            action: () {
              action(finalFiles);
            },
          );
        } else {
          finalFiles.clear();
          for (int i = 0; i < files.length; i++) {
            finalFiles.add(File(files[i].path!));
          }
          action(finalFiles);
        }
      } else {
        snackbarRed(title: 'Error'.tr, subtitle: ("The file size must be less than {size} MB").replaceAll('size', ((maxFileSize ?? 10000000) ~/ 1000000).toString()).tr);
      }
    } else {
      snackbarRed(title: 'Error'.tr, subtitle: 'فرمت انتخابی قابل قبول نیست');
    }
  } else {
    if (size < (maxFileSize ?? 1000000000)) {
      if (enableCropping ?? true && (type ?? FileType.image) == FileType.image) {
        cropper(
          files: files,
          cropAspectRatio: cropAspectRatio,
          action: () {
            action(finalFiles);
          },
        );
      } else {
        finalFiles.clear();
        for (int i = 0; i < files.length; i++) {
          finalFiles.add(File(files[i].path!));
        }
        action(finalFiles);
      }
    } else {
      snackbarRed(title: 'Error'.tr, subtitle: ("The file size must be less than {size} MB").replaceAll('size', ((maxFileSize ?? 10000000) ~/ 1000000).toString()).tr);
    }
  }
}

int cropCount = 0;
List<File> finalFiles = <File>[];

void cropper({
  required final List<PlatformFile> files,
  required final VoidCallback action,
  final CropAspectRatio? cropAspectRatio,
}) async {
  final List<PlatformFile> images = files
      .where(
        (final PlatformFile element) => isWeb || (element.path?.isImageFileName ?? false),
      )
      .toList();
  if (cropCount == images.length) {
    action();
  } else {

    //todo IS_WEB
    String url = '';
    if (GetPlatform.isWeb) {
      // url = await getBlobByBytes(images.first.bytes!);
    }else{
      url=images.first.path??'';//
    }

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: url,
      aspectRatio: cropAspectRatio,
      compressQuality: 20,


      uiSettings: <PlatformUiSettings>[
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blueGrey, //
          toolbarWidgetColor: Colors.red,
          aspectRatioPresets: <CropAspectRatioPresetData>[
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(), //
          ],
          navBarLight: false,
          statusBarLight: false,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,

          showCropGrid: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: <CropAspectRatioPresetData>[
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        WebUiSettings(
          context: Get.context!,
        ),

      ],
    );
    if (croppedFile != null) {
      final File file = File(croppedFile.path);
      finalFiles.add(file);
      cropCount++;
      cropper(files: files, action: action, cropAspectRatio: cropAspectRatio);
    }
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (9, 16);

  @override
  String get name => '9x16 (customized)';
}
