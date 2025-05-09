import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/user_info_model.dart';
import '../api/auth/auth_service.dart'; // Import your API service

// Mock data for initial display
final UserInfoModel mockUser = UserInfoModel(
  fullname: "Nguyen Van A",
  gender: "Nam",
  height: 170.0,
  weight: 65.0,
  aimWeight: 60.0,
  age: 30,
  goal: "Giảm cân",
  health: "Khỏe mạnh",
  workOutDays: 4,
  password: "password123"
)..calculateBMI()
 ..calculateBMIAim()
 ..calculateWeightLossPercentage();

class setProfile extends StatefulWidget {
  const setProfile({super.key});

  @override
  State<setProfile> createState() => _setProfileState();
}

class _setProfileState extends State<setProfile> {
  late TextEditingController nameController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with mock data
    nameController = TextEditingController(text: mockUser.fullname);
    genderController = TextEditingController(text: mockUser.gender);
    ageController = TextEditingController(text: mockUser.age?.toString() ?? "");
    heightController = TextEditingController(text: mockUser.height?.toString() ?? "");
    weightController = TextEditingController(text: mockUser.weight?.toString() ?? "");
    passwordController = TextEditingController(text: mockUser.password);
  }

  @override
  void dispose() {
    // Clean up controllers
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarCustom(),
                const SizedBox(height: 20),
                
                // Profile header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Thông tin cá nhân',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'BMI hiện tại: ${mockUser.bmi.toStringAsFixed(1)} (${mockUser.bmiStatus})',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Form fields with better styling
                _buildInputField(
                  context,
                  label: 'Họ và tên',
                  controller: nameController,
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 15),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        label: 'Giới tính',
                        controller: genderController,
                        icon: Icons.people_outline,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInputField(
                        context,
                        label: 'Tuổi',
                        controller: ageController,
                        icon: Icons.cake_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 15),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        label: 'Chiều cao (cm)',
                        controller: heightController,
                        icon: Icons.height_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInputField(
                        context,
                        label: 'Cân nặng (kg)',
                        controller: weightController,
                        icon: Icons.fitness_center_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 15),
                
                _buildInputField(
                  context,
                  label: 'Mật khẩu',
                  controller: passwordController,
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                
                const SizedBox(height: 30),
                
                // Goal section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mục tiêu hiện tại',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoRow('Mục tiêu', mockUser.goal ?? 'Chưa thiết lập', textColor: Colors.black),
                      _buildInfoRow('Cân nặng mục tiêu', '${mockUser.aimWeight?.toString() ?? ""} kg', textColor: Colors.black),
                      _buildInfoRow('BMI mục tiêu', mockUser.bmiAim.toStringAsFixed(1), textColor: Colors.black),
                      _buildInfoRow('Số ngày tập/tuần', '${mockUser.workOutDays ?? 0} ngày', textColor: Colors.black),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Save button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      // Show save confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã lưu thông tin thành công!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Lưu thông tin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.red.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color textColor = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: textColor == Colors.black ? Colors.black87 : Colors.white70,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}