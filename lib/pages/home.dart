import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rich_chess_notes/core/read_notes.dart';
import 'package:rich_chess_notes/i18n/strings.g.dart';
import 'package:rich_chess_notes/pages/node_detail.dart';
import 'package:rich_chess_notes/utils/constants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rich_chess_notes/utils/filesystem.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:rich_chess_notes/widgets/common_drawer.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Directory? _currentDirectory;
  Directory? _baseDirectory;
  Future<List<RawFolderElement>> _contentFuture = Future.value([]);
  bool _contentIsReady = false;
  final ScrollController _scrollController = ScrollController();
  List<RawFolderElement>? _lastContentsState;

  @override
  void initState() {
    super.initState();
    _setupCurrentDirectory().then((_) => _reloadContent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _setupCurrentDirectory() async {
    final appSupportDir = await getApplicationSupportDirectory();
    final Directory notesDir = Directory(
      p.join(appSupportDir.path, notesRootFolderName),
    );
    await notesDir.create();
    _currentDirectory = notesDir;
    _baseDirectory = _currentDirectory;
    _contentFuture = readElements(_currentDirectory!);
  }

  Future<void> _reloadContent() async {
    setState(() {
      _contentIsReady = false;
      _lastContentsState = null;
      _contentFuture = readElements(_currentDirectory!);
    });
    _contentFuture.then((value) {
      final usedContent = _filterUnwantedFolders(value);

      setState(() {
        _lastContentsState = usedContent;
        _contentIsReady = true;
      });
    });
  }

  Future<String> _getNameOfFileToCreate() async {
    final newFileName = await showDialog<String>(
      context: context,
      builder: (innnerCtx) {
        TextEditingController textController = TextEditingController();
        return AlertDialog(
          title: Text(t.pages.home.new_filename_dialog.title),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: t.pages.home.new_filename_dialog.placeholder,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                textController.dispose();
                Navigator.of(context).pop(null);
              },
              child: Text(
                t.misc.buttons.cancel,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                final newName = textController.text.toString();
                textController.dispose();
                Navigator.of(context).pop(newName);
              },
              child: Text(
                t.misc.buttons.ok,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
    if (newFileName == null || newFileName.isEmpty) throw "User cancelled";
    if (newFileName.endsWith(".md")) return newFileName;
    return "$newFileName.md";
  }

  Future<void> _purposeCreateNote() async {
    try {
      final newNoteName = await _getNameOfFileToCreate();
      final existingContentsNames = _getCurrentNotesNames();
      final isOverwritingExistingFile = existingContentsNames.contains(
        newNoteName,
      );
      if (isOverwritingExistingFile) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.pages.home.create_note_errors.failed_creating_note),
          ),
        );
        return;
      }

      final filePath = p.join(_currentDirectory!.path, newNoteName);
      await File(filePath).create();

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return NoteDetailPage(filePath: filePath);
          },
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.misc.cancelled_by_user)));
      return;
    }
  }

  List<String> _getCurrentNotesNames() {
    if (_contentIsReady) {
      if (_lastContentsState == null) {
        throw "Current page content is not yet ready !";
      }
      return _lastContentsState!
          .where((elt) {
            return !elt.isFolder;
          })
          .toList()
          .map((elt) => elt.name.split(Platform.pathSeparator).last)
          .toList();
    } else {
      return [];
    }
  }

  List<RawFolderElement> _filterUnwantedFolders(
    List<RawFolderElement> elements,
  ) {
    final isAndroid = Platform.isAndroid;
    final isBaseFolder =
        (_currentDirectory?.path == _baseDirectory?.path) &&
        (_currentDirectory != null);

    final usedContent = (isAndroid && isBaseFolder)
        ? elements
              .where(
                (elt) =>
                    !elt.isFolder ||
                    elt.name.split(Platform.pathSeparator).last !=
                        "flutter_assets",
              )
              .toList()
        : elements;

    return usedContent;
  }

  Future<void> _handleFolderSelection(String name) async {
    if (name == parentFolder) {
      setState(() {
        _currentDirectory = _currentDirectory!.parent;
      });
      _reloadContent();
      return;
    }
    try {
      final matchingFile = File("${_currentDirectory!.path}/$name");
      if (!await FileSystemEntity.isDirectory(matchingFile.path)) {
        return;
      }
      setState(() {
        _currentDirectory = Directory(matchingFile.path);
      });
      _reloadContent();
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.pages.home.misc_errors.failed_opening_folder)),
      );
    }
  }

  Future<void> _handleNoteSelection(String path) async {
    try {
      if (!await FileSystemEntity.isFile(path)) {
        return;
      }
      _purposeViewNoteDetails(path);
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.pages.home.misc_errors.failed_opening_note)),
      );
    }
  }

  Future<void> _purposeViewNoteDetails(String filePath) async {
    try {
      if (!mounted) {
        return;
      }
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return NoteDetailPage(filePath: filePath);
          },
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.pages.home.misc_errors.failed_opening_note_details),
        ),
      );
    }
  }

  Future<void> _purposeDeleteFolder(String path) async {
    final name = path.split(Platform.pathSeparator).last;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t.pages.home.delete_folder_dialog.title),
          content: Text(t.pages.home.delete_folder_dialog.message(name: name)),
          actions: [
            TextButton(
              child: Text(
                t.misc.buttons.cancel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                t.misc.buttons.ok,
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteFolder(path);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteFolder(String path) async {
    try {
      final savedFolder = Directory(path);
      await savedFolder.delete(recursive: true);
      _reloadContent();
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.pages.home.misc_errors.failed_deleting_folder),
        ),
      );
    }
  }

  Future<void> _purposeRenameFolder(String path) async {
    showDialog(
      context: context,
      builder: (context) {
        String oldFolderName = path.split(Platform.pathSeparator).last;
        String securedName = secureFileItemName(oldFolderName);
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                t.pages.home.rename_folder_dialog.title(
                  oldFolderName: securedName,
                ),
              ),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: t.pages.home.rename_folder_dialog.name_placeholder,
                ),
                controller: TextEditingController(text: securedName),
                onChanged: (value) => securedName = secureFileItemName(value),
              ),
              actions: [
                TextButton(
                  child: Text(
                    t.misc.buttons.cancel,
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    t.misc.buttons.ok,
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _renameFolder(path, securedName.trim());
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _renameFolder(String path, String newName) async {
    try {
      final savedFolder = Directory(path);
      final newSavedFolder = Directory("${_currentDirectory!.path}/$newName");
      if (await newSavedFolder.exists()) {
        throw Exception(t.pages.home.rename_folder_errors.already_exists);
      }
      await savedFolder.rename(newSavedFolder.path);
      _reloadContent();
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.pages.home.rename_folder_errors.modification_error),
        ),
      );
    }
  }

  Future<void> _purposeDeleteNote(String path) async {
    final name = path.split(Platform.pathSeparator).last;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t.pages.home.delete_note_dialog.title),
          content: Text(t.pages.home.delete_note_dialog.message(name: name)),
          actions: [
            TextButton(
              child: Text(
                t.misc.buttons.cancel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                t.misc.buttons.ok,
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteNote(path);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteNote(String path) async {
    try {
      final savedNote = File(path);
      await savedNote.delete();
      _reloadContent();
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.pages.home.misc_errors.failed_deleting_note)));
    }
  }

  Future<void> _purposeRenameNote(String path) async {
    showDialog(
      context: context,
      builder: (context) {
        String oldFileName = path.split(Platform.pathSeparator).last;
        String baseName = p.basenameWithoutExtension(oldFileName);
        String securedName = secureFileItemName(baseName);
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                t.pages.home.rename_note_dialog.title(oldFileName: oldFileName),
              ),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: t.pages.home.rename_note_dialog.name_placeholder,
                ),
                controller: TextEditingController(text: securedName),
                onChanged: (value) => securedName = secureFileItemName(value),
              ),
              actions: [
                TextButton(
                  child: Text(
                    t.misc.buttons.cancel,
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    t.misc.buttons.ok,
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _renameNote(path, "${securedName.trim()}.md");
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _renameNote(String path, String newName) async {
    try {
      final savedNote = File(path);
      final newSavedNote = File("${_currentDirectory!.path}/$newName");
      if (await newSavedNote.exists()) {
        throw Exception(t.pages.home.rename_note_errors.already_exists);
      }
      await savedNote.rename(newSavedNote.path);
      _reloadContent();
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.pages.home.rename_note_errors.modification_error)),
      );
    }
  }

  Future<void> _purposeCreateFolder() async {
    String newName = "";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(t.pages.home.create_folder_dialog.title),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: t.pages.home.create_folder_dialog.placeholder,
                ),
                controller: TextEditingController(text: ""),
                onChanged: (value) {
                  newName = secureFileItemName(value);
                },
              ),
              actions: [
                TextButton(
                  child: Text(
                    t.misc.buttons.cancel,
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    t.misc.buttons.ok,
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _createFolder(newName);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _createFolder(String name) async {
    try {
      final usedName = name.trim();
      final newFolder = Directory("${_currentDirectory!.path}/$usedName");
      if (await newFolder.exists()) {
        throw Exception(t.pages.home.create_folder_errors.already_exists);
      }
      await newFolder.create();
      _reloadContent();
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.pages.home.create_folder_errors.creation_error),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var pathText = _currentDirectory?.path ?? "";
    if (_currentDirectory != null && _baseDirectory != null) {
      pathText = pathText.replaceFirst(
        _baseDirectory!.path,
        t.pages.home.misc.base_directory,
      );
    }

    final screenWidth = MediaQuery.sizeOf(context).width;

    final content = FutureBuilder<dynamic>(
      future: _contentFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var allItems = snapshot.data! as List<RawFolderElement>;
          if (_currentDirectory?.path != _baseDirectory?.path) {
            allItems = [
              RawFolderElement(name: parentFolder, content: "", isFolder: true),
              ...allItems,
            ];
          }
          allItems = _filterUnwantedFolders(allItems);
          return allItems.isEmpty && _currentDirectory == _baseDirectory
              ? Text(t.pages.home.misc.no_item)
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: allItems.length,
                    itemBuilder: (context, index) {
                      final currentItem = allItems[index];
                      final itemPath = currentItem.name;
                      final itemName = itemPath
                          .split(Platform.pathSeparator)
                          .last;
                      final isFolder = currentItem.isFolder;
                      final isParentFolder =
                          isFolder && itemPath == parentFolder;
                      if (isParentFolder) {
                        return GestureDetector(
                          onTap: () => _handleFolderSelection(parentFolder),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                size: 50,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                        );
                      } else if (isFolder) {
                        return GestureDetector(
                          onTap: () => _handleFolderSelection(itemName),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 2,
                            children: [
                              Icon(
                                Icons.folder,
                                size: 50,
                                color: Colors.amberAccent,
                              ),
                              Text(itemName),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        _purposeRenameFolder(itemPath),
                                    icon: Icon(Icons.abc),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        _purposeDeleteFolder(itemPath),
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () => _handleNoteSelection(itemPath),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Icon(
                                RemixIcon.fileTextFill,
                                size: 50,
                                color: Colors.blue,
                              ),
                              Text(itemName),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        _purposeRenameNote(itemPath),
                                    icon: Icon(Icons.abc),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        _purposeDeleteNote(itemPath),
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
        } else if (snapshot.hasError) {
          return Center(
            child: Icon(Icons.error, color: Colors.red, size: 120.0),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );

    return Scaffold(
      drawer: CommonDrawer(),
      appBar: AppBar(
        title: Text(t.pages.home.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.insert_drive_file_outlined),
            onPressed: () {
              _purposeCreateNote();
            },
          ),
          IconButton(onPressed: _purposeCreateFolder, icon: Icon(Icons.folder)),
          IconButton(onPressed: _reloadContent, icon: Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth,
            color: Colors.amberAccent,
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Text(
                  pathText,
                  softWrap: false,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Flexible(child: content),
        ],
      ),
    );
  }
}
