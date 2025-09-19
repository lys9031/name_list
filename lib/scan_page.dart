import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'receipt_parser.dart';
import 'edit_receipt_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

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
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller!.initialize();
    setState(() {});
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
                  // 1) 사진 촬영
                  final file = await _controller!.takePicture();

                  // 2) 크롭: 영수증 영역을 선택
                  final cropped = await ImageCropper().cropImage(
                    sourcePath: file.path,
                    uiSettings: [
                      AndroidUiSettings(
                        toolbarTitle: '영수증 영역 지정',
                        toolbarColor: Colors.deepPurple,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false,
                      ),
                      IOSUiSettings(
                        title: '영수증 영역 지정',
                      ),
                      // WebUiSettings를 사용하는 경우, 웹 실행 환경에 맞게 설정하세요.
                    ],
                  );

                  // 사용자가 크롭을 취소한 경우 종료
                  if (cropped == null) return;

                  // 3) ML Kit 텍스트 인식
                  final inputImage = InputImage.fromFilePath(cropped.path);
                  final textRecognizer = TextRecognizer();
                  final recognizedText =
                      await textRecognizer.processImage(inputImage);
                  await textRecognizer.close();

                  // 4) 인식된 텍스트를 영수증 데이터로 파싱
                  final receipt = parseReceipt(recognizedText.text);

                  // 5) 편집 페이지로 이동
                  if (!mounted) return;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EditReceiptPage(receipt: receipt),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('스캔 중 오류 발생: $e')),
                  );
                }
              },
              child: const Icon(Icons.camera),
            ),
    );
  }
}
