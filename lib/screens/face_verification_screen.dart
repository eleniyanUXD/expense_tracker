import 'package:flutter/material.dart';

class FaceVerificationScreen extends StatefulWidget {
  const FaceVerificationScreen({super.key});

  @override
  State<FaceVerificationScreen> createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen> {
  bool isProcessing = false;

  Future<void> verifyFace() async {
    setState(() {
      isProcessing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    bool faceMatched = true;

    setState(() {
      isProcessing = false;
    });

    if (faceMatched) {
      Navigator.pop(context, true);
    } else {
      Navigator.pop(context, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.face, size: 120, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                "Face Verification",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 30),
              isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => verifyFace(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          backgroundColor: const Color.fromARGB(255, 3, 6, 167),
                        ),
                        child: const Text(
                          'Start Face Scan',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              const Text(
                "Align your face in the camera",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
