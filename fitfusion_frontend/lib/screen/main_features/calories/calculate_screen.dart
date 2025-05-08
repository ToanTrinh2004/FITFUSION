import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'calories_summary.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  List<Map<String, TextEditingController>> foodInputs = [
    {'food': TextEditingController(), 'gram': TextEditingController()},
  ];

  void _addFoodInput() {
    setState(() {
      foodInputs.add({'food': TextEditingController(), 'gram': TextEditingController()});
    });
  }

  void _calculateNutrition() {
    // Join all food entries into a string
    final foodString = foodInputs.map((input) {
      final food = input['food']!.text;
      final gram = input['gram']!.text;
      return "$food ${gram} gram";
    }).join(', ');

    print('Calling API with: $foodString');

    // Instead of real API, use mock result
    final mockData = {
      "calories": 845,
      "protein": 74,
      "carbs": 78,
      "fats": 35,
      "note":
          "Bữa ăn này cung cấp lượng protein khá cao, chủ yếu từ thịt lợn và thịt bò, rất tốt cho việc xây dựng và phục hồi cơ bắp..."
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CaloriesSummary(data: mockData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'TÍNH CALORIES',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: foodInputs.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: foodInputs[index]['food'],
                          decoration: const InputDecoration(labelText: 'Tên thực phẩm'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: foodInputs[index]['gram'],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Gram'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addFoodInput,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Thêm thực phẩm'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calculateNutrition,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Tính tổng dinh dưỡng'),
            ),
          ],
        ),
      ),
    );
  }
}
