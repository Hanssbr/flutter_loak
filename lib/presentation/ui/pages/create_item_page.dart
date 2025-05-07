import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/bloc/create_item_bloc.dart';
import '../../../data/datasource/auth_local_datasource.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({super.key});

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final conditionController = TextEditingController();
  final locationController = TextEditingController();

  File? _imageFile;
  bool isSubmitting = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  void _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate() || _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field termasuk foto harus diisi")),
      );
      return;
    }

    final token = await AuthLocalDatasource().getToken();

    context.read<CreateItemBloc>().add(
          CreateEvent(
            name: nameController.text,
            description: descriptionController.text,
            category: categoryController.text,
            condition: conditionController.text,
            location: locationController.text,
            photo: _imageFile!,
            token: token!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Barang')),
      body: BlocConsumer<CreateItemBloc, CreateItemState>(
        listener: (context, state) {
          setState(() => isSubmitting = state is CreateItemLoading);

          if (state is CreateItemSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item berhasil ditambahkan!')),
            );
            Navigator.pop(context);
          }

          if (state is CreateItemError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildField('Nama Barang', nameController),
                  _buildField('Deskripsi', descriptionController),
                  _buildField('Kategori', categoryController),
                  _buildField('Kondisi', conditionController),
                  _buildField('Lokasi', locationController),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[100],
                      ),
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover)
                          : const Center(child: Text("Pilih Foto")),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: isSubmitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Kirim'),
                      onPressed: isSubmitting ? null : () => _submit(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? '$label wajib diisi' : null,
      ),
    );
  }
}
