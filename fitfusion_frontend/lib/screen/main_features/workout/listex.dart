import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
class WorkoutDayDetailScreen extends StatelessWidget {
  final int day;
  final UserInfoModel userInfo;

  const WorkoutDayDetailScreen({super.key, required this.day, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    List<String> exercises = [
      "Bước cao",
      "Bật nhảy",
      "Tập cơ bụng",
      "Đo sàn",
      "Chạm gót chân",
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3261E), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header có tên người dùng
              AppBarCustomHeader(fullname: userInfo.fullname),

              // Thông tin ngày tập
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                width: MediaQuery.of(context).size.width * 0.87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Text("11", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("bài tập"),
                      ],
                    ),
                    Text("Ngày $day", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Column(
                      children: [
                        Text("101", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("kalo"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              const Text("bài tập", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),

              // Danh sách bài tập
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            exercises[index],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text("00 : 20", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Nút quay lại
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB3261E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  child: const Text(
                    "QUAY LẠI",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
