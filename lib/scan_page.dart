import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    // 사용 가능한 카메라 목록을 가져와 첫 번째 카메라를 선택합니다.
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize();
    setState(() {}); // 초기화가 완료되었음을 알리기 위해 상태 갱신
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('스캔')),
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // 카메라 프리뷰 표시
                  return CameraPreview(_controller!);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
      floatingActionButton: _controller == null
          ? null
          : FloatingActionButton(
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final file = await _controller!.takePicture();
                  // TODO: 다음 단계에서 OCR 처리 및 크롭 화면으로 이동합니다.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('촬영 완료: ${file.path}')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('촬영 중 오류 발생: $e')),
                  );
                }
              },
              child: const Icon(Icons.camera),
            ),
    );
  }
}
