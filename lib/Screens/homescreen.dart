import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:filemanager/Provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:open_file/open_file.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../Functionality/Icons.dart';
import '../cosnt.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
    gettingpermision();
  }

  void gettingpermision() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
  }

  final FileManagerController controller = FileManagerController();

  var _openResult = 'Unknown';

  List<int> i = [];

  TextEditingController con = TextEditingController();

  late List<FileSystemEntity> files;

  Future<void> openFile(String path) async {
    String? filePath = path;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      filePath = result.files.single.path;
    } else {
      // User canceled the picker
    }
    final _result = await OpenFile.open(filePath);
    print(_result.message);
    setState() {
      _openResult = "type=${_result.type}  message=${_result.message}";
    }
  }

  GetIcons getIcons = GetIcons();
  List<String> filepaths = [];
  int value = 0;

  int k = 0;
  @override
  Widget build(BuildContext context) {
    String path;
    int LinearSearch(String dir, String target) {
      var directory = Directory(dir);
      files = directory.listSync();
      for (var filess in files) {
        for (int j = 0; j < files.length; j++) {
          if (files[j].toString().toLowerCase().contains(target)) {
            if (i.contains(j)) {
            } else {
              i.add(j);
            }
          }
        }
      }
      return -1;
    }

    final sp = Provider.of<SelectionProvider>(context, listen: true);
    return ControlBackButton(
      controller: controller,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkcolorr,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () => createFolder(context),
                icon: const Icon(MaterialIcons.create_new_folder),
              ),
              IconButton(
                onPressed: () => sort(context),
                icon: const Icon(Icons.sort_rounded),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Visibility(
                    visible: sp.getselected() == 0 ? false : true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sp.value.toString(),
                          style: const TextStyle(fontSize: 25),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Share.shareFiles(filepaths);
                            },
                            child: const Icon(Icons.share)),
                      ],
                    )),
              ),
            ],
            title: ValueListenableBuilder<String>(
              valueListenable: controller.titleNotifier,
              builder: (context, title, _) => Text(title),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextFormField(
                  onFieldSubmitted: (con) {
                    LinearSearch(controller.getCurrentPath,
                        con.toString().toLowerCase());
                  },
                  controller: con,
                  style: const TextStyle(
                    color: darkcolorr,
                    fontSize: 21,
                  ),
                  cursorColor: darkcolorr,
                  decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: () {
                          i = [];
                          con.clear();
                        },
                        child: Visibility(
                            visible: i.isEmpty ? false : true,
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.redAccent,
                            )),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: darkcolorr,
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 0.1,
                        color: darkcolorr,
                      )),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.1, color: darkcolorr))),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: FileManager(
                    emptyFolder: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(image: AssetImage('images/empty.png')),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Folder Empty',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    controller: controller,
                    builder: (context, snapshot) {
                      final List<FileSystemEntity> entities = snapshot;

                      if (i.isEmpty) {
                        return ListView.builder(
                            itemCount: entities.length,
                            itemBuilder: (context, index) {
                              FileSystemEntity entity = entities[index];
                              return Card(
                                child: ListTile(
                                  leading: FileManager.isFile(entity)
                                      ? getIcons.getfileIcon(
                                          FileManager.getFileExtension(entity))
                                      : const Icon(Icons.folder,
                                          size: 50, color: darkcolorr),
                                  title: Text(FileManager.basename(entity)),
                                  trailing: Visibility(
                                    visible:
                                        sp.getselected() == 0 ? false : true,
                                    child: InkWell(
                                      onTap: () {
                                        if (sp.selectedlist.contains(
                                            FileManager.basename(entity))) {
                                          path =
                                              '${controller.getCurrentPath}/${FileManager.basename(entity)}.${FileManager.getFileExtension(entity)}';
                                          filepaths.remove(path);
                                          sp.remove(
                                              FileManager.basename(entity));
                                        } else {
                                          path =
                                              '${controller.getCurrentPath}/${FileManager.basename(entity)}.${FileManager.getFileExtension(entity)}';
                                          filepaths.add(path);
                                          sp.selected(
                                              FileManager.basename(entity));
                                        }
                                      },
                                      child: sp.selectedlist.contains(
                                              FileManager.basename(entity))
                                          ? const Icon(
                                              Icons.check_box,
                                              color: darkcolorr,
                                            )
                                          : const Icon(
                                              Icons.check_box_outline_blank,
                                              color: darkcolorr),
                                    ),
                                  ),
                                  subtitle: subtitle(entity),
                                  onLongPress: () {
                                    path =
                                        '${controller.getCurrentPath}/${FileManager.basename(entity)}.${FileManager.getFileExtension(entity)}';
                                    filepaths.add(path);
                                    sp.selected(FileManager.basename(entity));
                                  },
                                  onTap: () async {
                                    if (sp.value == 0) {
                                      if (FileManager.isDirectory(entity)) {
                                        // open the folder
                                        controller.openDirectory(entity);

                                        // get date of file
                                      } else if (FileManager.isFile(entity)) {
                                        openFile(
                                            '${controller.getCurrentPath}/${FileManager.basename(entity)}.${FileManager.getFileExtension(entity)}');
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Temporary_Screen(data:controller.getCurrentPath+FileManager.basename(entity))));
                                      }
                                    } else {
                                      if (sp.selectedlist.contains(
                                          FileManager.basename(entity))) {
                                        sp.remove(FileManager.basename(entity));
                                      } else {
                                        filepaths.add(
                                            '${controller.getCurrentPath}/${FileManager.basename(entity)}.${FileManager.getFileExtension(entity)}');
                                        sp.selected(
                                            FileManager.basename(entity));
                                      }
                                    }
                                  },
                                ),
                              );
                            });
                      } else if (i.isNotEmpty) {
                        return ListView.builder(
                            itemCount: i.length,
                            itemBuilder: (context, index) {
                              FileSystemEntity entity = files[i[index]];
                              return ListTile(
                                leading: FileManager.isFile(entity)
                                    ? getIcons.getfileIcon(
                                        FileManager.getFileExtension(entity))
                                    : const Icon(Icons.folder,
                                        size: 50, color: darkcolorr),
                                title: Text(FileManager.basename(entity)),
                                subtitle: subtitle(entity),
                                onLongPress: () {
                                  filepaths.add(
                                      '${controller.getCurrentPath}/${FileManager.basename(entity)}.${FileManager.getFileExtension(entity)}');
                                  sp.selected(FileManager.basename(entity));
                                },
                                onTap: () async {
                                  if (sp.value == 0) {
                                    if (FileManager.isDirectory(entity)) {
                                      // open the folder
                                      controller.openDirectory(entity);

                                      // get date of file
                                    } else if (FileManager.isFile(entity)) {
                                      openFile(
                                          '${controller.getCurrentPath}/${FileManager.basename(entity)}.${FileManager.getFileExtension(entity)}');
                                    }
                                  }
                                },
                              );
                            });
                      }
                      return const Text('hy');
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            int size = snapshot.data!.size;

            return Text(
              "${FileManager.formatBytes(size)}",
            );
          }
          return Text(
            "${snapshot.data!.modified}".substring(0, 10),
          );
        } else {
          return const Text("");
        }
      },
    );
  }

  sort(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: const Text("Name"),
                  onTap: () {
                    controller.sortBy(SortBy.name);
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("Size"),
                  onTap: () {
                    controller.sortBy(SortBy.size);
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("Date"),
                  onTap: () {
                    controller.sortBy(SortBy.date);
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("type"),
                  onTap: () {
                    controller.sortBy(SortBy.type);
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  createFolder(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController folderName = TextEditingController();
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: TextField(
                    controller: folderName,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Create Folder
                      await FileManager.createFolder(
                          controller.getCurrentPath, folderName.text);
                      // Open Created Folder
                      controller.setCurrentPath =
                          "${controller.getCurrentPath}/${folderName.text}";
                    } catch (e) {}

                    Navigator.pop(context);
                  },
                  child: const Text('Create Folder'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
