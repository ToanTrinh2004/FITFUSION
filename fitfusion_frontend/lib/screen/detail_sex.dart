import 'package:flutter/material.dart';

class SexSelectionScreen extends StatefulWidget {
  const SexSelectionScreen({super.key});

  @override
  _SexSelectionScreenState createState() => _SexSelectionScreenState();
}

class _SexSelectionScreenState extends State<SexSelectionScreen> {
  String selectedGender = ""; // Biến lưu trạng thái giới tính đã chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF999999), Color(0xFFFFFFFF)], // Gradient nền
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Giới tính của bạn là gì?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Khung chứa các lựa chọn
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      genderButton("Nam", "assets/male.png"),
                      const SizedBox(width: 30),
                      genderButton("Nữ", "assets/female.png"),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Mô tả thêm
                  const Text(
                    "Chúng tôi sử dụng giới tính để thiết kế kế hoạch ăn kiêng tốt nhất cho bạn.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Nút tiếp tục
            ElevatedButton(
              onPressed: () {
                if (selectedGender.isNotEmpty) {
                  // Xử lý khi người dùng chọn giới tính
                  print("Bạn đã chọn giới tính: $selectedGender");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Màu nền nút
                foregroundColor: Colors.white, // Màu chữ
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("TIẾP TỤC", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm tạo button chọn giới tính
  Widget genderButton(String gender, String imagePath) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: isSelected ? Colors.blue : Colors.grey, width: 2),
            ),
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          const SizedBox(height: 10),
          Text(
            gender,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
