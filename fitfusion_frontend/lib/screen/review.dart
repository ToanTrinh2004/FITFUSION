import '../widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ReviewApp extends StatelessWidget {
  const ReviewApp({super.key});

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const AppBarCustom(),
                  const SizedBox(height: 30),
                  
                  // App Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Fit",
                              style: AppTextStyles.title.copyWith(
                                fontSize: 32,
                                color: Colors.black,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 0,
                                    color: Color(0xFFB3261E),
                                  ),
                                ],
                              ),
                            ),
                            TextSpan(
                              text: "AI",
                              style: AppTextStyles.title.copyWith(
                                fontSize: 32,
                                color: const Color(0xFFB3261E),
                                shadows: const [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // About Us Title
                  Text(
                    "GIỚI THIỆU VỀ FITFUSION",
                    style: AppTextStyles.title.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // About Us Content
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "FitFusion là giải pháp toàn diện cho sức khỏe và thể hình của bạn, kết hợp công nghệ AI tiên tiến để mang lại trải nghiệm tập luyện cá nhân hóa tốt nhất.",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Features Title
                  Text(
                    "TÍNH NĂNG CHÍNH",
                    style: AppTextStyles.title.copyWith(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Features
                  _buildFeatureCard(
                    context,
                    icon: Icons.fitness_center,
                    title: "Quản lý cân nặng",
                    description: "Theo dõi tiến trình, đặt mục tiêu và nhận phân tích chi tiết về sự thay đổi cân nặng của bạn.",
                  ),
                  
                  _buildFeatureCard(
                    context,
                    icon: Icons.directions_run,
                    title: "Hướng dẫn tập luyện",
                    description: "Thư viện bài tập đa dạng với video hướng dẫn chi tiết, được điều chỉnh theo mục tiêu và khả năng của bạn.",
                  ),
                  
                  _buildFeatureCard(
                    context,
                    icon: Icons.person,
                    title: "Thuê huấn luyện viên",
                    description: "Kết nối với các huấn luyện viên chuyên nghiệp để nhận hướng dẫn cá nhân và động lực tập luyện.",
                  ),
                  
                  _buildFeatureCard(
                    context,
                    icon: Icons.local_fire_department,
                    title: "Theo dõi calories",
                    description: "Tính toán chính xác lượng calories tiêu thụ và đốt cháy với công nghệ AI tiên tiến.",
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Our Mission
                  Text(
                    "SỨ MỆNH CỦA CHÚNG TÔI",
                    style: AppTextStyles.title.copyWith(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 15),
                  
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "Chúng tôi tin rằng mọi người đều xứng đáng có một cuộc sống khỏe mạnh và hạnh phúc. FitFusion cam kết cung cấp công cụ dễ tiếp cận, hiệu quả và được cá nhân hóa để giúp bạn đạt được mục tiêu sức khỏe của mình.",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Version information
                  Text(
                    "Phiên bản 1.0.0",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 10),
                  
                  Text(
                    "© 2025 FitFusion. Bản quyền thuộc về chúng tôi.",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFB3261E).withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 255, 255, 255),
              size: 30,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
                    fontSize: 14,
                    height: 1.4,
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