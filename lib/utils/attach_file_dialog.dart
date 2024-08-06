// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:file_icon/file_icon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lgu_bplo/controller/file_controller.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

final FileController fileController = Get.find();
final ImagePicker _picker = ImagePicker();
final List<XFile> listFiles = [];
bool isListView = false;

Future<bool> attachFileDialog(BuildContext context, {String applicationId = "", String attachType = ""}) {
  isListView = false;
  FileAttachment _file = (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == attachType);
  if (_file != null) {
    fileController.fileListTemp.value.fileList = _file.files;
  } else {
    fileController.fileListTemp.value.fileList = [];
  }
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(builder: ((context, setState) {
        return  AlertDialog(
          titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 4),
          contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 4),
          actionsPadding: EdgeInsets.fromLTRB(16, 4, 16, 16),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "File Attachments",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: ThemeColor.secondary,
                  fontSize: 16
                )
              ),
              IconButton(
                onPressed: (() {
                  fileController.fileListTemp.value.fileList = [];
                  fileController.fileListTemp.refresh();
                  fileController.listFileAttachment.refresh();
                  Navigator.pop(context, false);
                }),
                icon: Icon(
                  MaterialIcons.close, 
                  color: ThemeColor.warning,
                ),
                iconSize: 25,
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 280,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: ThemeColor.disabled,
                      width: 2
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: isListView ? Axis.vertical : Axis.horizontal,
                    child: Obx(() => isListView ?
                    Column(
                      children: <Widget>[...(fileController.fileListTemp.value.fileList ?? []).map((key) => 
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: ThemeColor.secondary,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 170,
                                child: Row(
                                  children: [
                                    FileIcon(key.path, size: 40),
                                    Flexible(
                                      child: Text(
                                        key.path,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 12
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size(30, 28),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.black38,
                                  foregroundColor: ThemeColor.primaryText,
                                  shadowColor: Colors.black
                                ),
                                onPressed: () {
                                  fileController.fileListTemp.value.fileList.remove(key);
                                  fileController.fileListTemp.refresh();
                                },
                                child: Icon(Icons.delete, size: 18)
                              ),
                            ],
                          ),
                        )
                      )],
                    ) :
                    Row(
                      children: <Widget>[...(fileController.fileListTemp.value.fileList ?? []).map((key) => 
                        Container(
                          width: 200,
                          height: 200,
                          padding: EdgeInsets.all(8),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: FileIcon(key.path, size: 100),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: Colors.black38,
                                    foregroundColor: ThemeColor.primaryText,
                                    shadowColor: Colors.black
                                  ),
                                  onPressed: () {
                                    fileController.fileListTemp.value.fileList.remove(key);
                                    fileController.fileListTemp.refresh();
                                  },
                                  child: Icon(Icons.close)
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Text(
                                  key.name,
                                  style: TextStyle(
                                    fontSize: 12
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      )],
                    )),
                  ),
                ),
                SizedBox(
                  height: 23,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 25,
                        child: Checkbox(
                          value: isListView,
                          onChanged: (bool value) {
                            setState(() {
                              isListView = value ?? false;
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isListView = !isListView;
                          });
                        },
                        child: Text('List View', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: ThemeColor.primaryNavbarBg,
                    fixedSize: Size(MediaQuery.of(context).size.width / 3, 30),
                    foregroundColor: ThemeColor.primaryText,
                    shadowColor: Colors.black
                  ),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            child: Text('Photo Gallery'),
                            onPressed: () {
                              // close the options modal
                              Navigator.of(context).pop();
                              // get image from gallery
                              imgFromGallery();
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text('Camera'),
                            onPressed: () {
                              // close the options modal
                              Navigator.of(context).pop();
                              // get image from camera
                              imgFromCamera();
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text('Directory'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              fileFromDirectory();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Browse', style: TextStyle(fontWeight: FontWeight.w800))
                ),
                Obx(() => TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: (fileController.fileListTemp.value.fileList ?? []).isEmpty ? ThemeColor.disabled : ThemeColor.primary,
                    fixedSize: Size(MediaQuery.of(context).size.width / 3, 30),
                    foregroundColor: ThemeColor.primaryText,
                    shadowColor: Colors.black
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Save', style: TextStyle(fontWeight: FontWeight.w800))
                )),
              ],
            )
          ],
        );
      }));
    }
  );
}

imgFromCamera() {
  try {
    _picker.pickImage(source: ImageSource.camera, imageQuality: 25).then((value) {
      if (value != null) {
        List<XFile> temp = fileController.fileListTemp.value.fileList ?? [];
        temp.add(value);
        fileController.fileListTemp.value.fileList = temp;
        fileController.fileListTemp.refresh();
      }
    });
  } catch (e) {
    print(e);
  }
}

imgFromGallery() {
  try {
    _picker.pickImage(source: ImageSource.gallery, imageQuality: 25).then((value) {
      if (value != null) {
        List<XFile> temp = fileController.fileListTemp.value.fileList ?? [];
        temp.add(value);
        fileController.fileListTemp.value.fileList = temp;
        fileController.fileListTemp.refresh();
      }
    });
  } catch (e) {
    print(e);
  }
}

fileFromDirectory() {
  try {
    FilePicker.platform.pickFiles(allowMultiple: true).then((result) {
      result.paths.map((path) => File(path)).toList().forEach((_xfile) {
        List<XFile> temp = fileController.fileListTemp.value.fileList ?? [];
        temp.add(XFile(_xfile.path));
        fileController.fileListTemp.value.fileList = temp;
      });
      fileController.fileListTemp.refresh();
    });
  } catch (e) {
    print(e);
  }
}