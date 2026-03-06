import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ScanProductPage extends StatefulWidget {
  const ScanProductPage({super.key});

  @override
  State<ScanProductPage> createState() => _ScanProductPageState();
}

class _ScanProductPageState extends State<ScanProductPage> {
  CameraController? _controller;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        setState(() {
          _error = "No camera available on this device.";
          _isLoading = false;
        });
        return;
      }

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    } on CameraException catch (e) {
      setState(() {
        _error = "Camera error: ${e.description}";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Unexpected error: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      final image = await _controller!.takePicture();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Picture saved: ${image.path}")));
    } catch (e) {
      print("Capture error: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Camera")),
        body: Center(
          child: Text(
            _error!,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Scan Ingredient")),
      body: Column(
        children: [
          Expanded(child: CameraPreview(_controller!)),

          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _takePicture,
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
