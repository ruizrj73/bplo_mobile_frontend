// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_new, prefer_collection_literals, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lgu_bplo/utils/env.dart';

class FileAttachment {
  String applicationId;
  String type;
  List<XFile> files;
  List<String> url;

  FileAttachment(this.applicationId, this.type, this.files, this.url);
}

class FileAttachmentsList {
  List<FileAttachment> fileAttachments = [];

  FileAttachmentsList({this.fileAttachments});
}

class FileListTemp {
  List<XFile> fileList = [];

  FileListTemp({this.fileList});
}

class FileController extends GetxController {
  String folder_name = "bplo-attachment/" + Env.env;
  
  Rx<FileAttachmentsList> listFileAttachment = FileAttachmentsList().obs;
  Rx<FileListTemp> fileListTemp = FileListTemp().obs;

  Future<List<String>> uploadFile(List<XFile> _file, String _fileName) async {
    final cloudinary = Cloudinary.full(
      apiKey: Env.cloudinaryApiKey,
      apiSecret: Env.cloudinaryApiSecret,
      cloudName: Env.cloudinaryCloudName,
    );

    int fileNumber = 0;
    List<String> urls = [];

    for (var _f in _file) {
      if (_f.path != "") {
        final response = await cloudinary.uploadResource(
          CloudinaryUploadResource(
            filePath: _f.path,
            resourceType: CloudinaryResourceType.auto,
            folder: folder_name,
            fileName: _fileName + "/" + fileNumber.toString() + _f.name,
            progressCallback: (count, total) {
              print('Uploading file from file with progress: $count/$total');
            }
          )
        );
        
        fileNumber += 1;

        if(response.isSuccessful) {
          print('Get your file from with ${response.secureUrl}');  
          urls.add(response.secureUrl);
        }
      }
    }

    return urls;
  }  
}