import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class VirtualAssistantPage extends StatefulWidget {
  const VirtualAssistantPage({super.key});

  @override
  State<VirtualAssistantPage> createState() => _VirtualAssistantPageState();
}

class _VirtualAssistantPageState extends State<VirtualAssistantPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isMe': false,
      'text': 'Halo, Yanuar! Saya Vira, asisten virtual KlinikTap. Ada yang bisa saya bantu hari ini?',
      'time': '09:00',
    },
    {
      'isMe': true,
      'text': 'Bagaimana cara melihat jadwal dokter anak?',
      'time': '09:01',
    },
    {
      'isMe': false,
      'text': 'Anda dapat melihat jadwal dokter spesialis anak melalui menu "Reservasi Poli" di halaman Dasbor utama, lalu pilih poli "Anak".',
      'time': '09:01',
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        'isMe': true,
        'text': _messageController.text,
        'time': '09:05', // dummy time
      });
      _messageController.clear();
    });

    // Simulate typing delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'isMe': false,
          'text': 'Maaf, untuk saat ini saya masih dalam tahap pembelajaran. Silakan hubungi Call Center kami di 1500-123 untuk bantuan lebih lanjut.',
          'time': '09:05',
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.primarySurface,
                  child: Icon(Icons.support_agent_rounded, color: AppColors.primary),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('KlinikTap Assistant', style: AppTextStyles.h3),
                Text('Selalu Aktif', style: AppTextStyles.caption.copyWith(color: AppColors.success)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['isMe'] as bool;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isMe) ...[
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primarySurface,
                          child: Icon(Icons.support_agent_rounded, size: 16, color: AppColors.primary),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isMe ? AppColors.primary : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isMe ? 20 : 0),
                              bottomRight: Radius.circular(isMe ? 0 : 20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['text'] as String,
                                style: AppTextStyles.body.copyWith(
                                  color: isMe ? Colors.white : AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message['time'] as String,
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 10,
                                  color: isMe ? Colors.white.withValues(alpha: 0.7) : AppColors.textHint,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 8),
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.border,
                          child: Text('YA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Chat Input Area
          Container(
            padding: EdgeInsets.only(
              left: 20, right: 20, top: 16,
              bottom: MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Ketik pesan...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
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
