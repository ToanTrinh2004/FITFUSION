import 'package:fitfusion_frontend/screen/main_features/workout/ExerciseDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';

class WorkoutDayDetailScreen extends StatelessWidget {
  final int day;
  final UserInfoModel userInfo;

  const WorkoutDayDetailScreen({super.key, required this.day, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    // Exercise data with name and duration
    List<Map<String, String>> exercises = [
      {"name": "Nhảy", "duration": "20s", "gif": "assets/exercises/nhay.gif"},
      {"name": "Gập chân", "duration": "20s", "gif": "assets/exercises/gapchan.gif"},
      {"name": "Gập cơ bụng", "duration": "20s","gif": "assets/exercises/gapcobung.gif"},
      {"name": "con bọ", "duration": "20s","gif": "assets/exercises/conbo.gif"},
      {"name": "Chạm gót chân", "duration": "20s", "gif": "assets/exercises/taychamgot.gif"},
      {"name": "Nâng chân", "duration": "20s", "gif": "assets/exercises/nangchan.gif"},
      {"name": "Plank", "duration": "20s", "gif": "assets/exercises/plank.gif"},
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
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
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
                    return InkWell(
                      onTap: () {
                        // Navigate to exercise detail screen when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailScreen(
                              exerciseName: exercises[index]["name"]!,
                              duration: exercises[index]["duration"]!,
                              imagePath: exercises[index]["gif"]!,
                            ),
                          ),
                        );
                      },
                      child: Container(
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
                              exercises[index]["name"]!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "00 : ${exercises[index]["duration"]!.replaceAll('s', '')}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
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