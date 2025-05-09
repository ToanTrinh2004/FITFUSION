import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/theme/theme.dart';


class MyCoachList extends StatelessWidget {
  const MyCoachList({super.key});

  final List<Map<String, dynamic>> _myCoaches = const [
    {
      'name': 'Tran Thi B',
      'gender': 'Nữ',
      'age': '28',
      'field': 'Yoga',
      'region': 'Hồ Chí Minh',
      'zaloLink': 'https://zalo.me/0364820490',
      'startDate': '15/04/2025',
      'endDate': '15/07/2025',
      'schedule': [
        {'day': 'Thứ 2', 'time': '18:00 - 19:30'},
        {'day': 'Thứ 4', 'time': '18:00 - 19:30'},
        {'day': 'Thứ 6', 'time': '17:30 - 19:00'},
      ]
    },
  ];

  void _showScheduleModal(BuildContext context, Map<String, dynamic> coach) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lịch tập với HLV ${coach['name']}",
                style: AppTextStyles.subtitle
              ),
              const SizedBox(height: 16),
              ...List.generate(
                (coach['schedule'] as List).length,
                (index) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        coach['schedule'][index]['day'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(coach['schedule'][index]['time']),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ButtonStyles.buttonTwo,
                  child: const Text("Đóng", style: AppTextStyles.text,)
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMessageScreen(BuildContext context, Map<String, dynamic> coach) {
    // Mở màn hình nhắn tin với HLV
    // Đây là chức năng có thể phát triển sau
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đang nhắn tin với HLV ${coach['name']}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_myCoaches.isEmpty) {
      return const Center(
        child: Text(
          "Bạn chưa thuê HLV nào",
          style: AppTextStyles.text,
        ),
      );
    }
    
    return ListView.builder(
      itemCount: _myCoaches.length,
      itemBuilder: (context, index) {
        final coach = _myCoaches[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tên: ${coach['name']}", style: AppTextStyles.little_title_1),
                    Text("Giới tính: ${coach['gender']}", style: AppTextStyles.normal_nutri),
                    Text("Tuổi: ${coach['age']}", style: AppTextStyles.normal_nutri),
                    Text("Chuyên ngành: ${coach['field']}", style: AppTextStyles.normal_nutri),
                    Text("Khu vực: ${coach['region']}", style: AppTextStyles.normal_nutri),
                    Text("Thời gian thuê: ${coach['startDate']} - ${coach['endDate']}", 
                         style: AppTextStyles.forgotPassword),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.message, color: Colors.blue),
                    onPressed: () => _showMessageScreen(context, coach),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month, color: Colors.green),
                    onPressed: () => _showScheduleModal(context, coach),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}