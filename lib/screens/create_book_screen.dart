import 'dart:io';

import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/local_book.dart';
import 'package:anaquel/logic/local_books_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Creando libro"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
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
                label: const Text('Título'),
                hint: "Título",
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El título es requerido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: _authorController,
                label: const Text('Autor'),
                hint: "Autor",
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El autor es requerido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: _descriptionController,
                label: const Text('Descripción'),
                hint: "Descripción",
                minLines: 3,
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "La descripción es requerida";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: _genresController,
                label: const Text('Géneros'),
                hint: "Géneros",
                maxLines: 1,
                description: const Text("Separados por coma"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Los géneros son requeridos";
                  }
                  return null;
                },
              ),
              const FDivider(),
              FButton(
                onPress: () {
                  if (_imageFile == null) return;
                  if (!_formKey.currentState!.validate()) return;
                  _saveImage(_titleController.text).then(
                    (value) {
                      context.read<LocalBooksBloc>().add(
                            AddLocalBook(
                              localBook: LocalBook(
                                id: const Uuid().v4(),
                                coverUrl: value,
                                title: _titleController.text,
                                author: _authorController.text,
                                description: _descriptionController.text,
                                genres: _genresController.text
                                    .split(",")
                                    .map((e) => e.trim())
                                    .toList(),
                              ),
                            ),
                          );
                    },
                  );
                  context.pop();
                },
                style: FButtonStyle.primary,
                label: const Text("Crear libro"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
