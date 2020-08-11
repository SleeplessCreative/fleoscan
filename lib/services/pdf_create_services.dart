import 'dart:io';

import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/datamodels/save_pdf_properties.dart';
import 'package:fleoscan/services/pdf_module/pdf_file_name.dart';
import 'package:fleoscan/services/pdf_module/pdf_pages.dart';
import 'package:fleoscan/services/pdf_storage_permission_service.dart';
import 'package:injectable/injectable.dart';
import 'package:pdf/widgets.dart' as pw;

@lazySingleton
class CreatePdfService {
  final StoragePermission storagePermission = locator<StoragePermission>();

  pw.Document pdf;

  Future startPdfService(SavePdfProperties savePdfProperties) async {
    pdf = await generatePage(savePdfProperties);
    savePdf(savePdfProperties.flightNumber);
  }

  Future savePdf(String flightNumber) async {
    if (await storagePermission.getPermission()) {
      String externalPath = '/storage/emulated/0';
      String folderName = '/FleoScan';
      String fileName = FileName().getFileName(flightNumber);

      await Directory('$externalPath$folderName').create(recursive: true);
      String savePath = externalPath + folderName + fileName;

      File newFile = File(savePath);
      newFile.writeAsBytesSync(pdf.save());
    }
  }
}
