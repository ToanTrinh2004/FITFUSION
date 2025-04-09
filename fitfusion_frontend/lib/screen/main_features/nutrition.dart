import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/theme/theme.dart';


class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int selectedDayIndex = 0; // Ngày đang được chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thanh tiêu đề + nút back
              _buildAppBar(context),

              // Thanh chọn ngày (CÓ THỂ CHỌN)
              _buildWeekSelector(),

              // Thông tin tổng quan
              _buildOverview(),

              // Danh sách bữa ăn
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildMealSection(title: "Bữa sáng", content: _sampleBreakfast()),
                      _buildMealSection(title: "Bữa trưa"),
                      _buildMealSection(title: "Bữa tối"),
                    ],
                  ),
                ),
              ),

              // Nút về trang chủ
              _buildHomeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Thanh tiêu đề
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          const Text("Chế độ dinh dưỡng", style: AppTextStyles.title),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 📌 Thanh chọn ngày (CÓ THỂ CHỌN)
  Widget _buildWeekSelector() {
    List<String> weekDays = ["S", "M", "T", "W", "T", "F", "S"];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (index) {
          bool isSelected = index == selectedDayIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDayIndex = index;
              });
            },
            child: Column(
              children: [
                Text(weekDays[index], style: AppTextStyles.little_title),
                const SizedBox(height: 5),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: isSelected ? AppColors.primary : AppColors.primaryHalf,
                  child: Text("${9 + index}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // 📌 Thông tin tổng quan
  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoBox("1700", "calo", Colors.red),
            _buildInfoBox("87g", "protein", Colors.blue),
            _buildInfoBox("51g", "chất béo", Colors.orange),
            _buildInfoBox("240g", "carbs", Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  // 📌 Phần bữa ăn
  Widget _buildMealSection({required String title, Widget? content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.little_title),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: content ?? const SizedBox(height: 60),
          ),
        ],
      ),
    );
  }

  // 📌 Nội dung mẫu cho bữa sáng
  Widget _sampleBreakfast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🍞 Bánh mì ốp la với rau sống", style: AppTextStyles.little_title_1),
        const SizedBox(height: 5),
        const Text("• 2 quả trứng gà\n• 1 ổ bánh mì\n• 50g rau sống\n• 10 bơ thực vật", style: AppTextStyles.normal),
        const SizedBox(height: 10),
        const Text("🔹 Cách chuẩn bị", style: AppTextStyles.little_title_1),
        const Text("Chiên trứng với bơ, sau đó cho rau sống và trứng vào bánh mì."),
        const SizedBox(height: 10),
        const Text("💪 Lợi ích sức khỏe", style: AppTextStyles.little_title_1),
        const Text("Bánh mì ốp la cung cấp năng lượng và protein giúp no lâu."),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButton("Đổi thực đơn với AI"),
            _buildButton("Chỉnh sửa thực đơn"),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyles.buttonTwo,
      child: Text(text, style: AppTextStyles.textButtonTwo),
    );
  }

  // 📌 Nút Trang Chủ
  Widget _buildHomeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ButtonStyles.buttonTwo,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(child: Text("TRANG CHỦ", style: AppTextStyles.textButtonTwo)),
        ),
      ),
    );
  }
}
