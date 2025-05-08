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
      appBar: AppBar(
        title: const Text('Tóm tắt dinh dưỡng'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Thành phần dinh dưỡng", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: protein,
                      title: 'Protein',
                      radius: 60,
                    ),
                    PieChartSectionData(
                      color: Colors.orange,
                      value: carbs,
                      title: 'Carbs',
                      radius: 60,
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: fats,
                      title: 'Fats',
                      radius: 60,
                    ),
                  ],
                  sectionsSpace: 5,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildNutritionRow("Calories", calories, Colors.redAccent),
            _buildNutritionRow("Protein", protein, Colors.blue),
            _buildNutritionRow("Carbs", carbs, Colors.orange),
            _buildNutritionRow("Fats", fats, Colors.green),
            const SizedBox(height: 20),
            Text("Ghi chú:", style: Theme.of(context).textTheme.titleLarge),
            Text(note, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label)),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              color: color,
              backgroundColor: Colors.grey[200],
              minHeight: 10,
            ),
          ),
          const SizedBox(width: 10),
          Text("${value.toInt()}g"),
        ],
      ),
    );
  }
}
