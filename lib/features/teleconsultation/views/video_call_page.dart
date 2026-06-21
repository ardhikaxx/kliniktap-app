import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_text_styles.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Mock Video Feed (Doctor)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade900, Colors.black87],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, size: 80, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Text('dr. Sarah Maida, Sp.A', style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 24)),
                    const SizedBox(height: 8),
                    Text('02:45', style: AppTextStyles.body.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),
          
          // Mock Self Camera
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            right: 20,
            child: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white38, width: 2),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
              ),
              child: const Center(
                child: Icon(Icons.person_outline, color: Colors.white54, size: 40),
              ),
            ),
          ),
          
          // Controls
          Positioned(
            bottom: 40, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(Icons.mic_off_rounded, Colors.white24, Colors.white, () {}),
                _buildControlButton(Icons.videocam_off_rounded, Colors.white24, Colors.white, () {}),
                _buildControlButton(Icons.call_end_rounded, Colors.red, Colors.white, () {
                  Get.back();
                  Get.snackbar('Sesi Berakhir', 'Panggilan telekonsultasi telah selesai.', backgroundColor: Colors.white);
                }, size: 64),
                _buildControlButton(Icons.flip_camera_ios_rounded, Colors.white24, Colors.white, () {}),
                _buildControlButton(Icons.chat_rounded, Colors.white24, Colors.white, () {}),
              ],
            ),
          ),
          
          // Top Bar (Back button)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color bgColor, Color iconColor, VoidCallback onTap, {double size = 48}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }
}
