import 'dart:io';

import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/local_book.dart';
import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class CreateBookScreen extends StatefulWidget {
  const CreateBookScreen({super.key});

  @override
  State<CreateBookScreen> createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends State<CreateBookScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _genresController = TextEditingController();

  Future<String> _saveImage(String title) async {
    final String duplicateFilePath =
        (await getApplicationDocumentsDirectory()).path;
    final File newImage = File(_imageFile!.path);
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String newImagePath = '$duplicateFilePath/$title$timestamp.png';
    newImage.copy(newImagePath);
    return newImagePath;
  }

  Future createBook(BuildContext context) async {
    if (_imageFile == null) return;
    if (!_formKey.currentState!.validate()) return;

    final localBooksBloc = context.read<LocalBooksBloc>();
    final navigator = Navigator.of(context);

    String localBookCoverUrl = await _saveImage(_titleController.text);
    LocalBook localBook = LocalBook(
      id: const Uuid().v4(),
      coverUrl: localBookCoverUrl,
      title: _titleController.text,
      author: _authorController.text,
      description: _descriptionController.text,
      genres: _genresController.text.split(",").map((e) => e.trim()).toList(),
      status: 0,
    );

    localBooksBloc.add(AddLocalBook(localBook: localBook));
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("local_books_screens.create.title").tr(),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 260,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GestureDetector(
                    onTap: () async {
                      var status = await Permission.photos.request();
                      if (status.isGranted) {
                        _picker.pickImage(source: ImageSource.gallery).then(
                          (value) {
                            if (value != null) {
                              setState(() {
                                _imageFile = value;
                              });
                            }
                          },
                        );
                      }
                    },
                    child: AspectRatio(
                      aspectRatio: 0.625,
                      child: _imageFile != null
                          ? Image.file(
                              File(_imageFile!.path),
                              width: 150,
                              height: 240,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: AppColors.antiFlashWhite,
                              width: 150,
                              height: 240,
                              child: Center(
                                child: FAssets.icons.camera(),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: _titleController,
                label:
                    const Text("local_books_screens.create.fields.title").tr(),
                hint: "local_books_screens.create.fields.title".tr(),
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "local_books_screens.create.fields.title_required"
                        .tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: _authorController,
                label:
                    const Text("local_books_screens.create.fields.author").tr(),
                hint: "local_books_screens.create.fields.author".tr(),
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "local_books_screens.create.fields.author_required"
                        .tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: _descriptionController,
                label:
                    const Text("local_books_screens.create.fields.description")
                        .tr(),
                hint: "local_books_screens.create.fields.description".tr(),
                minLines: 3,
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "local_books_screens.create.fields.description_required"
                        .tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: _genresController,
                label:
                    const Text("local_books_screens.create.fields.genres").tr(),
                hint: "local_books_screens.create.fields.genres".tr(),
                maxLines: 1,
                description: const Text(
                        "local_books_screens.create.fields.genres_description")
                    .tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "local_books_screens.create.fields.genres_required"
                        .tr();
                  }
                  return null;
                },
              ),
              const FDivider(),
              FButton(
                onPress: () => createBook(context),
                style: FButtonStyle.primary,
                label: const Text("local_books_screens.create.create").tr(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
