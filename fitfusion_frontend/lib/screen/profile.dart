import 'package:fitfusion_frontend/screen/home.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/user_info_model.dart';
import '../api/userInfo/fetch_user.dart';
import '../api/userInfo/put_user.dart';

class SetProfile extends StatefulWidget {
  const SetProfile({super.key});

  @override
  State<SetProfile> createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  late TextEditingController nameController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController passwordController;

  UserInfoModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await FetchUser.getUserInfo(context);
      final loadedUser = UserInfoModel.fromJson(userData!);

      loadedUser.calculateBMI();
      loadedUser.calculateBMIAim();
      loadedUser.calculateWeightLossPercentage();

      setState(() {
        user = loadedUser;
        nameController = TextEditingController(text: user?.fullname ?? "");
        genderController = TextEditingController(text: user?.gender ?? "");
        ageController = TextEditingController(text: user?.age?.toString() ?? "");
        heightController = TextEditingController(text: user?.height?.toString() ?? "");
        weightController = TextEditingController(text: user?.weight?.toString() ?? "");
        passwordController = TextEditingController(text: user?.password ?? "");
        isLoading = false;
      });
    } catch (e) {
      print("Lỗi khi load user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không thể tải thông tin người dùng")),
      );
    }
  }

  Future<void> _saveUserData() async {
    if (user == null) return;

    final updatedUser = UserInfoModel(
      fullname: nameController.text.isNotEmpty ? nameController.text : user!.fullname,
      gender: genderController.text.isNotEmpty ? genderController.text : user!.gender,
      age: int.tryParse(ageController.text) ?? user!.age,
      height: double.tryParse(heightController.text) ?? user!.height,
      weight: double.tryParse(weightController.text) ?? user!.weight,
      password: user!.password,
      goal: user!.goal,
      aimWeight: user!.aimWeight,
    );

    updatedUser.calculateBMI();
    updatedUser.calculateBMIAim();
    updatedUser.calculateWeightLossPercentage();

    final success = await UpdateUserInfoService.updateUserInfo(updatedUser);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã lưu thông tin thành công!'), backgroundColor: Colors.green),
      );
       Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(userInfo : updatedUser)),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lưu thông tin thất bại!'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(gradient: appGradient),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarCustom(),
                      const SizedBox(height: 20),
                      _buildHeader(),
                      const SizedBox(height: 30),
                      _buildFormFields(),
                      const SizedBox(height: 30),
                      _buildGoalInfo(),
                      const SizedBox(height: 30),
                      _buildSaveButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Center(
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
              child: Icon(Icons.person, size: 60, color: Colors.red.shade700),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Thông tin cá nhân',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'BMI hiện tại: ${user?.bmi.toStringAsFixed(1)} (${user?.bmiStatus})',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildInputField(label: 'Họ và tên', controller: nameController, icon: Icons.person_outline),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildInputField(label: 'Giới tính', controller: genderController, icon: Icons.people_outline),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildInputField(
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
                label: 'Chiều cao (cm)',
                controller: heightController,
                icon: Icons.height_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildInputField(
                label: 'Cân nặng (kg)',
                controller: weightController,
                icon: Icons.fitness_center_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildGoalInfo() {
    return Container(
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red.shade700),
          ),
          const SizedBox(height: 10),
          _buildInfoRow('Mục tiêu', user?.goal ?? 'Chưa thiết lập', textColor: Colors.black),
          _buildInfoRow('Cân nặng mục tiêu', '${user?.aimWeight?.toString() ?? ""} kg', textColor: Colors.black),
          _buildInfoRow('BMI mục tiêu', user?.bmiAim.toStringAsFixed(1) ?? '', textColor: Colors.black),
          _buildInfoRow('Số ngày tập/tuần', '${user?.workOutDays ?? 0} ngày', textColor: Colors.black),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade700,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 5,
        ),
        onPressed: _saveUserData,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.save, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Lưu thông tin',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
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
        style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color textColor = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: textColor == Colors.black ? Colors.black87 : Colors.white70)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}
