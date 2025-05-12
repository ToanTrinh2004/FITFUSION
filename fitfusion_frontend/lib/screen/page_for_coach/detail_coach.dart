import 'package:fitfusion_frontend/screen/page_for_coach/home_coach.dart';
import 'package:flutter/material.dart';
import '/theme/theme.dart';
import '/widgets/tabbar.dart';

class DetailCoachScreen extends StatefulWidget {
  const DetailCoachScreen({super.key});

  @override
  State<DetailCoachScreen> createState() => _DetailCoachScreenState();
}

class _DetailCoachScreenState extends State<DetailCoachScreen> {
  final _formKey = GlobalKey<FormState>();

  String gender = '';
  String age = '';
  String phone = '';
  String area = '';
  String field = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                          child: Text(
                            'Thông tin Huấn luyện viên',
                            style: AppTextStyles.subtitle,
                          ),
                        ),

                        const Text("Giới tính", style: AppTextStyles.little_title_1),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          value: gender.isNotEmpty ? gender : null,
                          items: ['Nam', 'Nữ', 'Khác']
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() => gender = value ?? ''),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Chọn giới tính',
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Text("Tuổi", style: AppTextStyles.little_title_1),
                        const SizedBox(height: 4),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Nhập tuổi",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) => age = value,
                        ),
                        const SizedBox(height: 16),

                        const Text("Số điện thoại", style: AppTextStyles.little_title_1),
                        const SizedBox(height: 4),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: "Nhập số điện thoại",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) => phone = value,
                        ),
                        const SizedBox(height: 16),

                        const Text("Khu vực", style: AppTextStyles.little_title_1),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          value: area.isNotEmpty ? area : null,
                          items: ['Hà Nội', 'TP.HCM', 'Đà Nẵng', 'Cần Thơ']
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() => area = value ?? ''),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Chọn khu vực hoạt động',
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Text("Chuyên ngành", style: AppTextStyles.little_title_1),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          value: field.isNotEmpty ? field : null,
                          items: ['Gym', 'Yoga', 'Zumba', 'Crossfit']
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() => field = value ?? ''),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Chọn chuyên ngành',
                          ),
                        ),
                        const SizedBox(height: 24),

                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // xử lý dữ liệu
                              }
                              Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (_) => HomeCoachScreen()));                       
                              },
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
