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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;

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
              _buildWeekSelector(screenWidth, isSmallScreen),

              // Thông tin tổng quan
              _buildOverview(screenWidth, isSmallScreen),

              // Danh sách bữa ăn
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      _buildMealSection(
                        title: "Bữa sáng", 
                        content: _sampleBreakfast(screenWidth, isSmallScreen),
                        screenWidth: screenWidth,
                      ),
                      _buildMealSection(title: "Bữa trưa", screenWidth: screenWidth),
                      _buildMealSection(title: "Bữa tối", screenWidth: screenWidth),
                    ],
                  ),
                ),
              ),

              // Nút về trang chủ
              _buildHomeButton(context, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Thanh tiêu đề
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: 8,
      ),
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
  Widget _buildWeekSelector(double screenWidth, bool isSmallScreen) {
    List<String> weekDays = ["S", "M", "T", "W", "T", "F", "S"];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: 8,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
              child: Container(
                width: screenWidth * 0.12,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: Column(
                  children: [
                    Text(weekDays[index], style: AppTextStyles.little_title),
                    const SizedBox(height: 5),
                    CircleAvatar(
                      radius: isSmallScreen ? 14 : 16,
                      backgroundColor: isSelected ? AppColors.primary : AppColors.primaryHalf,
                      child: Text("${9 + index}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 12 : 14,
                          )),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // 📌 Thông tin tổng quan
  Widget _buildOverview(double screenWidth, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoBox("1700", "calo", Colors.red, isSmallScreen),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox("87g", "protein", Colors.blue, isSmallScreen),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox("51g", "chất béo", Colors.orange, isSmallScreen),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox("240g", "carbs", Colors.green, isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value, String label, Color color, bool isSmallScreen) {
    return Column(
      children: [
        Text(
          value, 
          style: TextStyle(
            color: color, 
            fontWeight: FontWeight.bold, 
            fontSize: isSmallScreen ? 16 : 18
          )
        ),
        Text(
          label, 
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 14
          )
        ),
      ],
    );
  }

  // 📌 Phần bữa ăn
  Widget _buildMealSection({required String title, Widget? content, required double screenWidth}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04, 
        vertical: 8
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.little_title),
          const SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(screenWidth * 0.03),
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
  Widget _sampleBreakfast(double screenWidth, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🍞 Bánh mì ốp la với rau sống", style: AppTextStyles.little_title_1),
        const SizedBox(height: 5),
        const Text("• 2 quả trứng gà\n• 1 ổ bánh mì\n• 50g rau sống\n• 10g bơ thực vật", style: AppTextStyles.normal),
        const SizedBox(height: 10),
        const Text("🔹 Cách chuẩn bị", style: AppTextStyles.little_title_1),
        const Text("Chiên trứng với bơ, sau đó cho rau sống và trứng vào bánh mì."),
        const SizedBox(height: 10),
        const Text("💪 Lợi ích sức khỏe", style: AppTextStyles.little_title_1),
        const Text("Bánh mì ốp la cung cấp năng lượng và protein giúp no lâu."),
        const SizedBox(height: 5),
        Wrap(
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
          children: [
            _buildButton("Đổi thực đơn với AI", screenWidth, isSmallScreen),
            _buildButton("Chỉnh sửa thực đơn", screenWidth, isSmallScreen),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String text, double screenWidth, bool isSmallScreen) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyles.buttonTwo.copyWith(
        minimumSize: MaterialStateProperty.all(
          Size(
            screenWidth * (isSmallScreen ? 0.4 : 0.43),
            isSmallScreen ? 36 : 40,
          ),
        ),
      ),
      child: Text(
        text, 
        style: AppTextStyles.textButtonTwo.copyWith(
          fontSize: isSmallScreen ? 12 : 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 📌 Nút Trang Chủ
  Widget _buildHomeButton(BuildContext context, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 10,
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ButtonStyles.buttonTwo.copyWith(
          minimumSize: MaterialStateProperty.all(
            Size(screenWidth * 0.9, 48),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(child: Text("TRANG CHỦ", style: AppTextStyles.textButtonTwo)),
        ),
      ),
    );
  }
}