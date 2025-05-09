import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc/create_item_bloc.dart';
import '../../../data/datasource/auth_local_datasource.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({super.key});

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final List<String> categories = [
    'elektronik',
    'pakaian',
    'buku',
    'mainan',
    'lainnya',
  ];
  final List<String> conditions = ['layak', 'rusak ringan', 'rusak berat'];

  String? selectedCategory;
  String? selectedCondition;
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final conditionController = TextEditingController();
  final locationController = TextEditingController();

  Uint8List? _imageBytes;
  bool isSubmitting = false;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true, // <-- penting untuk web agar dapat bytes
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
      });
    }
  }

  void _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate() || _imageBytes == null) {
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
        photo: _imageBytes!,
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
              const SnackBar(
                content: Text('Item berhasil ditambahkan!'),
                behavior: SnackBarBehavior.floating, // ← Ini kuncinya
                margin: EdgeInsets.all(16),
              ),
            );
            Navigator.pop(context, true);
          }

          if (state is CreateItemError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCategory,
                    items:
                        categories.map((cat) {
                          return DropdownMenuItem(value: cat, child: Text(cat));
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                        categoryController.text = value;
                      });
                    },
                    validator:
                        (value) => value == null ? 'Pilih kategori' : null,
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Kondisi',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCondition,
                    items:
                        conditions.map((cond) {
                          return DropdownMenuItem(
                            value: cond,
                            child: Text(cond),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCondition = value!;
                        conditionController.text = value;
                      });
                    },
                    validator:
                        (value) => value == null ? 'Pilih kondisi' : null,
                  ),

                  const SizedBox(height: 16),
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
                      child:
                          _imageBytes != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  _imageBytes!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              )
                              : const Center(child: Text("Pilih Foto")),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label:
                          isSubmitting
                              ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
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
        validator:
            (value) =>
                value == null || value.isEmpty ? '$label wajib diisi' : null,
      ),
    );
  }
}
