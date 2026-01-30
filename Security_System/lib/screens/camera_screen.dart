import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool isRegisterMode = true;
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _controller.initialize().then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _captureAndSend() async {
    if (!_controller.value.isInitialized || isLoading) return;

    setState(() => isLoading = true);

    try {
      final XFile image = await _controller.takePicture();
      final Uint8List bytes = await image.readAsBytes();

      bool success;

      if (isRegisterMode) {
        if (nameController.text.isEmpty) {
          _showMessage("Please enter a name");
          setState(() => isLoading = false);
          return;
        }

        success = await ApiService.registerFace(
          bytes,
          nameController.text.trim(),
        );

        _showMessage(
            success ? "Face Registered Successfully" : "Registration Failed");
      } else {
        success = await ApiService.markAttendance(bytes);

        _showMessage(
            success ? "Attendance Marked" : "Face Not Recognized");
      }
    } catch (e) {
      _showMessage("Something went wrong");
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Face Attendance System"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: CameraPreview(_controller)),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(
                    isRegisterMode ? "Register Mode" : "Attendance Mode",
                  ),
                  value: isRegisterMode,
                  onChanged: (val) {
                    setState(() => isRegisterMode = val);
                  },
                ),

                if (isRegisterMode)
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Person Name",
                      border: OutlineInputBorder(),
                    ),
                  ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: isLoading ? null : _captureAndSend,
                  child: Text(
                    isRegisterMode
                        ? "Register Face"
                        : "Mark Attendance",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
