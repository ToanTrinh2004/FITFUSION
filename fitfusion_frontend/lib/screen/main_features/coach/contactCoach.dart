import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart'; // AppBarCustom nằm ở đây

class CoachDetailScreen extends StatelessWidget {
  final Map<String, String> coach;

  const CoachDetailScreen({super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: appGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text("Thông tin cá nhân:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  Text("Họ và Tên : ${coach['name']}", style: const TextStyle(fontSize: 14)),
                  Text("Giới tính : ${coach['gender']}", style: const TextStyle(fontSize: 14)),
                  Text("Tuổi : ${coach['age']}", style: const TextStyle(fontSize: 14)),
                  Text("Lĩnh vực chuyên ngành : ${coach['field']}", style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 12),

                  Text(
                    "Mô tả :\nXin chào các bạn mình là ${coach['name']!.split(' ').last}, với 2 năm kinh nghiệm trong việc làm PT bla bla ……",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Liên Hệ", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
