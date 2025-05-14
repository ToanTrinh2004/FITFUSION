import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/models/coach_model.dart';
import 'package:fitfusion_frontend/screen/page_for_coach/home_coach.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fitfusion_frontend/api/coach/post_coach.dart';

class DetailCoachScreen extends StatefulWidget {
  const DetailCoachScreen({super.key});

  @override
  State<DetailCoachScreen> createState() => _DetailCoachScreenState();
}

class _DetailCoachScreenState extends State<DetailCoachScreen> {
  final _formKey = GlobalKey<FormState>();

  String gender = '';
  String area = '';
  String field = '';

  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final introController = TextEditingController();
  final tuitionController = TextEditingController();

  @override
  void dispose() {
    ageController.dispose();
    phoneController.dispose();
    fullNameController.dispose();
    introController.dispose();
    tuitionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final coach = Coach(
        coachId: '', // Backend will generate or you may pass if known
        fullName: fullNameController.text.trim(),
        age: int.tryParse(ageController.text.trim()) ?? 0,
        gender: gender,
        major: field,
        tuitionFees: int.tryParse(tuitionController.text.trim()) ?? 0,
        introduction: introController.text.trim(),
      );

      final success = await UserInfoService.createCoachInfo(coach);

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeCoachScreen(coachInfo: coach,)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Failed to save information.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBarCustom(),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text('Thông tin Huấn luyện viên', style: AppTextStyles.subtitle),
                        ),
                        const SizedBox(height: 16),

                        const Text("Họ và tên", style: AppTextStyles.little_title_1),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: fullNameController,
                          decoration: const InputDecoration(
                            hintText: "Nhập họ tên",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Không được bỏ trống' : null,
                        ),
                        const SizedBox(height: 16),

                        const Text("Tuổi", style: AppTextStyles.little_title_1),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Nhập tuổi",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Không được bỏ trống' : null,
                        ),
                        const SizedBox(height: 16),

                        const Text("Giới tính", style: AppTextStyles.little_title_1),
                        DropdownButtonFormField<String>(
                          value: gender.isNotEmpty ? gender : null,
                          items: ['Male', 'Female', 'other']
                              .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                              .toList(),
                          onChanged: (value) => setState(() => gender = value ?? ''),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Chọn giới tính',
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Hãy chọn giới tính' : null,
                        ),
                        const SizedBox(height: 16),

                        const Text("Chuyên ngành", style: AppTextStyles.little_title_1),
                        DropdownButtonFormField<String>(
                          value: field.isNotEmpty ? field : null,
                          items: ['Gym', 'Yoga', 'Zumba', 'Crossfit']
                              .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                              .toList(),
                          onChanged: (value) => setState(() => field = value ?? ''),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Chọn chuyên ngành',
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Hãy chọn chuyên ngành' : null,
                        ),
                        const SizedBox(height: 16),

                        const Text("Học phí", style: AppTextStyles.little_title_1),
                        TextFormField(
                          controller: tuitionController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Nhập học phí",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Không được bỏ trống' : null,
                        ),
                        const SizedBox(height: 16),

                        const Text("Giới thiệu bản thân", style: AppTextStyles.little_title_1),
                        TextFormField(
                          controller: introController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: "Mô tả ngắn về bản thân bạn...",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Không được bỏ trống' : null,
                        ),
                        const SizedBox(height: 24),

                        Center(
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ButtonStyles.buttonTwo,
                            child: const Text("Lưu thông tin", style: AppTextStyles.textButtonTwo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
