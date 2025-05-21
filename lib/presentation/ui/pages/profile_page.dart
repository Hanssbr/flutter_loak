import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/data/datasource/auth_remote_datasource.dart';

class UpdateProfilePage extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhone;
  final String? initialPhotoUrl;

  const UpdateProfilePage({
    super.key,
    required this.initialName,
    required this.initialEmail,
    required this.initialPhone,
    this.initialPhotoUrl,
  });

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  Uint8List? _photoBytes;
  String? _photoFilename;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.initialName);
    emailController = TextEditingController(text: widget.initialEmail);
    phoneController = TextEditingController(text: widget.initialPhone);

    // Jika ada initialPhotoUrl, kamu bisa ambil gambarnya dengan cara lain
    // atau biarkan kosong dulu
    // Misal nanti kamu mau load gambar dari URL dan convert ke Uint8List
  }

  Future<void> _pickPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _photoBytes = result.files.single.bytes;
        _photoFilename = result.files.single.name;
      });
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    try {
      // Ambil token dari local datasource
      final token = await AuthLocalDatasource().getToken();
      if (token == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Token tidak ditemukan")));
        setState(() => isSubmitting = false);
        return;
      }

      // Update profile pakai authRemoteDatasource
      await AuthRemoteDatasource().updateProfile(
        token: token,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        photoBytes: _photoBytes,
        photoFilename: _photoFilename,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile berhasil diupdate"),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal update profile: $e")));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickPhoto,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 2),
                        color: Colors.grey[100],
                      ),
                      child: ClipOval(
                        child:
                            _photoBytes != null
                                ? Image.memory(
                                  _photoBytes!,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                )
                                : widget.initialPhotoUrl != null
                                ? Image.network(
                                  widget.initialPhotoUrl!,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.person,
                                            size: 80,
                                            color: Colors.grey,
                                          ),
                                )
                                : const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              _buildField('Name', nameController),
              _buildField('Email', emailController),
              _buildField('Phone', phoneController),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : _submit,
                  child:
                      isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
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
