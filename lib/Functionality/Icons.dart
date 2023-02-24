import 'package:filemanager/cosnt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class GetIcons {
  Widget? getfileIcon(String path) {
    switch (path) {
      case "pdf":
        return const Icon(Icons.picture_as_pdf,size: 50,color: darkcolorr,);
        break;
      case "doc":
      case "docx":
        return const Icon(CupertinoIcons.doc,size: 50,color: darkcolorr);
        break;
      case "png":
      case "jpeg":
      case "jpg":
        return const Icon(Icons.image,size: 50,color: darkcolorr);
        break;
      case "xls":
        return const Icon(FontAwesome5Solid.file_excel,size: 50,color: darkcolorr);
        break;
      case "pptx":
        return const Icon(AntDesign.pptfile1,size: 50,color: darkcolorr);
        break;
      case "mp4":
      case "mkv":
        return const Icon(Foundation.video,size: 50,color: darkcolorr);
        break;
      case "mp3":
        return const Icon(Icons.audio_file,size: 50,color: darkcolorr);
        break;
      case "zip":
      case "winrar":
        return const Icon(Icons.folder_zip,size: 50,color: darkcolorr);
        break;
      default:
        return const Icon(Icons.feed_outlined,size: 50,color: darkcolorr);
    }
  }
}
