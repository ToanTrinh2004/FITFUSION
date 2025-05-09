import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/theme/theme.dart';

class CaloriesSummary extends StatelessWidget {
  final Map<String, dynamic> data;

  const CaloriesSummary({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final double calories = data['calories'].toDouble();
    final double protein = data['protein'].toDouble();
    final double carbs = data['carbs'].toDouble();
    final double fats = data['fats'].toDouble();
    final String note = data['note'];

    return Scaffold(
      body: Stack(
        children: [
          // Nền gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: appGradient,
            ),
          ),

          // Nội dung cuộn
          Padding(
            padding: const EdgeInsets.only(top: 100), // đẩy nội dung xuống dưới AppBar
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Thành phần dinh dưỡng",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              color: Colors.blue,
                              value: protein,
                              title: 'Protein',
                              radius: 60,
                              titleStyle: const TextStyle(color: Colors.white),
                            ),
                            PieChartSectionData(
                              color: Colors.orange,
                              value: carbs,
                              title: 'Carbs',
                              radius: 60,
                              titleStyle: const TextStyle(color: Colors.white),
                            ),
                            PieChartSectionData(
                              color: Colors.green,
                              value: fats,
                              title: 'Fats',
                              radius: 60,
                              titleStyle: const TextStyle(color: Colors.white),
                            ),
                          ],
                          sectionsSpace: 5,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildNutritionRow("Calories", calories, Colors.redAccent),
                  _buildNutritionRow("Protein", protein, Colors.blue),
                  _buildNutritionRow("Carbs", carbs, Colors.orange),
                  _buildNutritionRow("Fats", fats, Colors.green),
                  const SizedBox(height: 24),
                  Text(
                    "Ghi chú:",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    note,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color.fromARGB(179, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          ),

          // AppBar đặt lên đầu
          const Positioned(
            top: 25,
            left: 0,
            right: 0,
            child: AppBarCustom(),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(color: Colors.white))),
          Expanded(
            child: LinearProgressIndicator(
              value: (value > 100 ? 1 : value / 100),
              color: color,
              backgroundColor: Colors.white30,
              minHeight: 12,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 10),
          Text("${value.toInt()}g", style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
