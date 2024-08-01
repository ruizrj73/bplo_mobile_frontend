// ignore_for_file: missing_return, avoid_print, avoid_function_literals_in_foreach_calls, void_checks, no_leading_underscores_for_local_identifiers

import 'package:image_picker/image_picker.dart';
import 'package:lgu_bplo/controller/file_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/attach_file_dialog.dart';
import 'package:lgu_bplo/utils/db_scripts/db_scripts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

class LocalDB extends GetxController {
  Database _db;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initDatabase();
  }

  Future<Database> initDatabase() async {
    // Open the database and store the reference.
    _db = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'localData5'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(DBScripts().createBusinessApplicationTable());
        await db.execute(DBScripts().createAttachmentTable());
        await db.execute(DBScripts().createBusinessOwnerInfoTable());
        await db.execute(DBScripts().createBusinessContactInfoTable());
        await db.execute(DBScripts().createBusinessAddressInfoTable());
        await db.execute(DBScripts().createBusinessOwnerAddressInfoTable());
        await db.execute(DBScripts().createBusinessOperationInfoTable());
        await db.execute(DBScripts().createLineOfBusinessTable());
        await db.execute(DBScripts().createLineOfBusinessMeasurePaxTable());
        await db.execute(DBScripts().createBusinessFindingsTable());
        await db.execute(DBScripts().createBusinessNoticeToComplyTable());
        await db.execute(DBScripts().createBusinessRemarksTable());
        await db.execute(DBScripts().createLessorInfoTable());
        await db.execute(DBScripts().createBookkeeperInfoTable());
        await db.execute(DBScripts().createAccountingFirmInfoTable());
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return _db;
  }

  Future<Database> get database async {
    if (_db != null) return _db;
    // Instantiate db the first time it is accessed
    _db = await initDatabase();
    return _db;
  }

  Future<List<BusinessApplication>> localBusinessApplication({String baId = ""}) async {
    List<BusinessApplication> businessApplicationList = [];
    // Get a reference to the database.
    final db = await database;

    List<Map<String, dynamic>> _businessApplication;

    if (baId == "") {
      _businessApplication = await db.rawQuery("SELECT * FROM businessapplication");
    } else {
      _businessApplication = await db.rawQuery("SELECT * FROM businessapplication WHERE id = '$baId'");
    }

    if (_businessApplication != null && _businessApplication.isNotEmpty) {
      await Future.forEach(_businessApplication, (_ba) async {
        BusinessApplication _bussAppTemp = BusinessApplication.fromJson(_ba);

        await db.rawQuery("SELECT * FROM attachment WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.attachment = [];
            List<FileAttachment> fileAttachments = [];
            data.forEach((dta) {
              if (dta["xfile"] != null) {
                if (fileAttachments.isEmpty) {
                  FileAttachment _fa = FileAttachment(
                    _bussAppTemp.id,
                    dta["file_description"],
                    [XFile(dta["file_url"])], // [XFile.fromData(dta["xfile"])],
                    []
                  );
                  fileAttachments.add(_fa);
                } else {
                  FileAttachment _fa = fileAttachments.firstWhereOrNull((_f) => _f.type == dta["file_description"]);
                  if (_fa != null) {
                    _fa.files.add(XFile(dta["file_url"]));
                    // _fa.url.add(dta["file_url"]);
                  } else {
                    _fa = FileAttachment(
                      _bussAppTemp.id,
                      dta["file_description"],
                      [XFile(dta["file_url"])], // [XFile.fromData(dta["xfile"])],
                      []
                    );
                    fileAttachments.add(_fa);
                  }
                }
              } else {
                _bussAppTemp.attachment.add(AttachmentModel.fromJson(dta));
              }
            });

            fileController.listFileAttachment.value.fileAttachments = fileAttachments;
          }
        });

        await db.rawQuery("SELECT * FROM businessownerinfo WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.business_owner_info = [];
            data.forEach((dta) {
              _bussAppTemp.business_owner_info.add(BusinessOwnerInfoModel.fromJson(dta));
            });
          }
        });

        await db.rawQuery("SELECT * FROM businesscontactinfo WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.business_contact_info = [];
            data.forEach((dta) {
              _bussAppTemp.business_contact_info.add(BusinessContactInfoModel.fromJson(dta));
            });
          }
        });

        await db.rawQuery("SELECT * FROM businessaddressinfo WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.business_address_info = [];
            data.forEach((dta) {
              _bussAppTemp.business_address_info.add(BusinessAddressInfoModel.fromJson(dta));
            });
          }
        });

        await db.rawQuery("SELECT * FROM businessowneraddressinfo WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.business_owner_address_info = [];
            data.forEach((dta) {
              _bussAppTemp.business_owner_address_info.add(BusinessOwnerAddressInfoModel.fromJson(dta));
            });
          }
        });

        await db.rawQuery("SELECT * FROM businessoperationinfo WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, Object>> data) {
          if (data != null && data.isNotEmpty) {
            data.forEach((_arx) {
              _bussAppTemp.business_operation_info = BusinessOperationInfoModel.fromJson(_arx);
            });
          }
        });

        await db.rawQuery("SELECT * FROM lineofbusiness WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.line_of_business = [];
            data.forEach((dta) {
              _bussAppTemp.line_of_business.add(LineOfBusinessModel.fromJson(dta));
            });
          }
        });

        await db.rawQuery("SELECT * FROM lineofbusinessmeasurepax WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.line_of_business_measure_pax = [];
            data.forEach((dta) {
              _bussAppTemp.line_of_business_measure_pax.add(MeasurePaxModel.fromJson(dta));
            });
          }
        });

        await db.rawQuery("SELECT * FROM businessfindings WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.business_findings = [];
            data.forEach((dta) {
              _bussAppTemp.business_findings.add(BusinessFindingsModel.fromJson(dta));
            });
          }
        });

        await db.rawQuery("SELECT * FROM businessnoticetocomply WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, dynamic>> data) {
          if (data != null && data.isNotEmpty) {
            _bussAppTemp.business_notice_to_comply = [];
            data.forEach((dta) {
              _bussAppTemp.business_notice_to_comply.add(BusinessNoticeToComplyModel.fromJson(dta));
            });
          }
        });

        await db.rawQuery("SELECT * FROM businessremarks WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, Object>> data) {
          if (data != null && data.isNotEmpty) {
            data.forEach((_arx) {
              _bussAppTemp.business_remarks = BusinessRemarksModel.fromJson(_arx);
            });
          }
        });

        await db.rawQuery("SELECT * FROM lessorinfo WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, Object>> data) {
          if (data != null && data.isNotEmpty) {
            data.forEach((_arx) {
              _bussAppTemp.lessor_info = LessorInfoModel.fromJson(_arx);
            });
          }
        });

        await db.rawQuery("SELECT * FROM bookkeeperinfo WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, Object>> data) {
          if (data != null && data.isNotEmpty) {
            data.forEach((_arx) {
              _bussAppTemp.bookkeeper_info = BookkeeperInfoModel.fromJson(_arx);
            });
          }
        });

        await db.rawQuery("SELECT * FROM accountingfirminfo WHERE baId = '${_bussAppTemp.id}'").then((List<Map<String, Object>> data) {
          if (data != null && data.isNotEmpty) {
            data.forEach((_arx) {
              _bussAppTemp.accounting_firm_info = AccountingFirmInfoModel.fromJson(_arx);
            });
          }
        });

        businessApplicationList.add(_bussAppTemp);
      });
    }

    return businessApplicationList;
  }

  Future<void> localInsertBusinessApplication(BusinessApplication _businessApplication) async {
    return deleteBusinessApplication(_businessApplication).then((value) async {
      final db = await database;

      await db.insert(
        'businessapplication',
        _businessApplication.toJson(forLocalDb: true),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (_businessApplication.attachment != null && _businessApplication.attachment.isNotEmpty) {
        _businessApplication.attachment.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'attachment',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.business_owner_info != null && _businessApplication.business_owner_info.isNotEmpty) {
        _businessApplication.business_owner_info.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'businessownerinfo',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.business_contact_info != null && _businessApplication.business_contact_info.isNotEmpty) {
        _businessApplication.business_contact_info.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'businesscontactinfo',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.business_address_info != null && _businessApplication.business_address_info.isNotEmpty) {
        _businessApplication.business_address_info.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'businessaddressinfo',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.business_owner_address_info != null && _businessApplication.business_owner_address_info.isNotEmpty) {
        _businessApplication.business_owner_address_info.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'businessowneraddressinfo',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.business_operation_info != null) {
        Map<String, Object> _data = _businessApplication.business_operation_info.toJson();
        _data["baId"] = _businessApplication.id;

        await db.insert(
          'businessoperationinfo',
          _data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      if (_businessApplication.line_of_business != null && _businessApplication.line_of_business.isNotEmpty) {
        _businessApplication.line_of_business.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'lineofbusiness',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.line_of_business_measure_pax != null && _businessApplication.line_of_business_measure_pax.isNotEmpty) {
        _businessApplication.line_of_business_measure_pax.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'lineofbusinessmeasurepax',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.business_findings != null && _businessApplication.business_findings.isNotEmpty) {
        _businessApplication.business_findings.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'businessfindings',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.business_notice_to_comply != null && _businessApplication.business_notice_to_comply.isNotEmpty) {
        _businessApplication.business_notice_to_comply.forEach((_data) async {
          Map<String, Object> _datax = _data.toJson();
          _datax["baId"] = _businessApplication.id;

          await db.insert(
            'businessnoticetocomply',
            _datax,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }

      if (_businessApplication.business_remarks != null) {
        Map<String, Object> _data = _businessApplication.business_remarks.toJson();
        _data["baId"] = _businessApplication.id;

        await db.insert(
          'businessremarks',
          _data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      if (_businessApplication.lessor_info != null) {
        Map<String, Object> _data = _businessApplication.lessor_info.toJson();
        _data["baId"] = _businessApplication.id;

        await db.insert(
          'lessorinfo',
          _data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      if (_businessApplication.bookkeeper_info != null) {
        Map<String, Object> _data = _businessApplication.bookkeeper_info.toJson();
        _data["baId"] = _businessApplication.id;

        await db.insert(
          'bookkeeperinfo',
          _data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      if (_businessApplication.accounting_firm_info != null) {
        Map<String, Object> _data = _businessApplication.accounting_firm_info.toJson();
        _data["baId"] = _businessApplication.id;

        await db.insert(
          'accountingfirminfo',
          _data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await localBusinessApplication().then((value) {
        return value;
      });
    });
  }

  Future<void> deleteBusinessApplication(BusinessApplication _businessApplication) async {
    final db = await database;

    await db.delete(
      'businessapplication',
      where: 'id = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'attachment',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'businessownerinfo',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'businesscontactinfo',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'businessaddressinfo',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'businessowneraddressinfo',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'businessowneraddressinfo',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'lineofbusiness',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'lineofbusinessmeasurepax',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'businessfindings',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'businessnoticetocomply',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'businessremarks',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'lessorinfo',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'bookkeeperinfo',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
    
    await db.delete(
      'accountingfirminfo',
      where: 'baId = ?',
      whereArgs: [_businessApplication.id],
    );
  }

}