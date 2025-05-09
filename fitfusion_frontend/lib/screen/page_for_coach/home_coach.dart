import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '/theme/theme.dart';

// Model cho thông tin học viên
class UserInfoModel {
  final String fullname;
  final String? gender;
  final double? height;
  final double? weight;
  final double? aimWeight;
  final int? age;
  final String? goal;
  final DateTime? aimDate;
  final List<String>? health;
  final List<String>? workOutDays;
  final String? password;

  UserInfoModel({
    required this.fullname,
    this.gender,
    this.height,
    this.weight,
    this.aimWeight,
    this.age,
    this.goal,
    this.aimDate,
    this.health,
    this.workOutDays,
    this.password
  });
}

// Model cho sự kiện
class Event {
  final String title;
  final String description;
  final DateTime time;
  final String? studentName;

  Event({
    required this.title,
    required this.description,
    required this.time,
    this.studentName,
  });
}

// Model cho yêu cầu thuê mới
class TrainingRequest {
  final String studentName;
  final List<String> schedule;
  final double fee;
  final int durationInMonths;
  final String? note;
  bool isAccepted;

  TrainingRequest({
    required this.studentName,
    required this.schedule,
    required this.fee,
    required this.durationInMonths,
    this.note,
    this.isAccepted = false,
  });
}

class HomeCoachScreen extends StatefulWidget {
  const HomeCoachScreen({Key? key}) : super(key: key);

  @override
  State<HomeCoachScreen> createState() => _HomeCoachScreenState();
}

class _HomeCoachScreenState extends State<HomeCoachScreen> {
  int _currentIndex = 0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> _events = {};

  // Danh sách học viên mẫu
  final List<UserInfoModel> _students = [
    UserInfoModel(
      fullname: "Nguyễn Văn A",
      gender: "Nam",
      height: 170,
      weight: 70,
      aimWeight: 65,
      age: 25,
      goal: "Giảm cân",
      aimDate: DateTime.now().add(const Duration(days: 90)),
      health: ["Khỏe mạnh"],
      workOutDays: ["Thứ 2", "Thứ 4", "Thứ 6"],
      password: "password123"
    ),
    UserInfoModel(
      fullname: "Trần Thị B",
      gender: "Nữ",
      height: 160,
      weight: 55,
      aimWeight: 50,
      age: 23,
      goal: "Tăng cơ",
      aimDate: DateTime.now().add(const Duration(days: 60)),
      health: ["Khỏe mạnh", "Đau đầu gối nhẹ"],
      workOutDays: ["Thứ 3", "Thứ 5", "Thứ 7"],
      password: "password456"
    ),
    UserInfoModel(
      fullname: "Phạm Văn C",
      gender: "Nam",
      height: 175,
      weight: 80,
      aimWeight: 72,
      age: 30,
      goal: "Giảm mỡ, tăng cơ",
      aimDate: DateTime.now().add(const Duration(days: 120)),
      health: ["Cao huyết áp nhẹ"],
      workOutDays: ["Thứ 2", "Thứ 3", "Thứ 5", "Thứ 7"],
      password: "password789"
    ),
  ];

  final List<TrainingRequest> _trainingRequests = [
    TrainingRequest(
      studentName: "Lê Thị D",
      schedule: ["Thứ 2", "Thứ 4", "Thứ 6"],
      fee: 2500000,
      durationInMonths: 3,
      note: "Muốn giảm cân 5kg trong 3 tháng",
    ),
    TrainingRequest(
      studentName: "Đỗ Văn E",
      schedule: ["Thứ 3", "Thứ 5", "Thứ 7"],
      fee: 3000000,
      durationInMonths: 6,
      note: "Tập trung vào phát triển cơ bụng và cơ tay",
    ),
    TrainingRequest(
      studentName: "Hoàng Thị F",
      schedule: ["Thứ 2", "Thứ 3", "Thứ 5", "Chủ nhật"],
      fee: 4000000,
      durationInMonths: 12,
      note: "Đã từng tập gym 1 năm nhưng gián đoạn 6 tháng, muốn quay lại",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    
    // Tạo sự kiện mẫu
    _generateSampleEvents();
  }

  void _generateSampleEvents() {
    // Tạo sự kiện cho tháng hiện tại
    final now = DateTime.now();
    for (var student in _students) {
      if (student.workOutDays != null) {
        for (int i = 0; i < 30; i++) {
          final day = DateTime(now.year, now.month, now.day + i);
          final weekday = DateFormat('EEEE').format(day);
          
          // Convert weekday to tiếng Việt
          String vnWeekday = "";
          switch(weekday) {
            case "Monday": vnWeekday = "Thứ 2"; break;
            case "Tuesday": vnWeekday = "Thứ 3"; break;
            case "Wednesday": vnWeekday = "Thứ 4"; break;
            case "Thursday": vnWeekday = "Thứ 5"; break;
            case "Friday": vnWeekday = "Thứ 6"; break;
            case "Saturday": vnWeekday = "Thứ 7"; break;
            case "Sunday": vnWeekday = "Chủ nhật"; break;
          }
          
          if (student.workOutDays!.contains(vnWeekday)) {
            final eventDay = DateTime(day.year, day.month, day.day);
            final event = Event(
              title: "Buổi tập với ${student.fullname}",
              description: "Mục tiêu: ${student.goal}",
              time: DateTime(day.year, day.month, day.day, 8 + i % 10, 0),
              studentName: student.fullname,
            );
            
            if (_events[eventDay] != null) {
              _events[eventDay]!.add(event);
            } else {
              _events[eventDay] = [event];
            }
          }
        }
      }
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  void _handleTrainingRequest(TrainingRequest request, bool accept) {
    setState(() {
      if (accept) {
        request.isAccepted = true;
        
        // Thêm học viên mới vào danh sách nếu chấp nhận
        _students.add(
          UserInfoModel(
            fullname: request.studentName,
            gender: null,
            height: null,
            weight: null,
            aimWeight: null,
            age: null,
            goal: request.note,
            aimDate: DateTime.now().add(Duration(days: request.durationInMonths * 30)),
            health: null,
            workOutDays: request.schedule,
            password: "default123"
          )
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đã chấp nhận yêu cầu từ ${request.studentName}"))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đã từ chối yêu cầu từ ${request.studentName}"))
        );
      }
      
      _trainingRequests.remove(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: Column(
            children: [
              AppBarCustom(),

              const Text("Home Coach", style: AppTextStyles.title1),

              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch của tôi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Học viên',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Yêu cầu mới',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildCalendarScreen();
      case 1:
        return _buildStudentsScreen();
      case 2:
        return _buildRequestsScreen();
      default:
        return _buildCalendarScreen();
    }
  }

  Widget _buildCalendarScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Lịch của tôi",
                      style: AppTextStyles.little_title_1,
                    ),
                  ),
                  TableCalendar(
                    firstDay: DateTime.utc(2022, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    eventLoader: _getEventsForDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    calendarStyle: CalendarStyle(
                      markerDecoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: AppColors.primaryHalf,
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonTextStyle: TextStyle(fontSize: 14),
                      formatButtonDecoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      formatButtonShowsNext: false,
                      titleCentered: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_selectedDay != null && _getEventsForDay(_selectedDay!).isNotEmpty)
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lịch cho ${DateFormat('dd/MM/yyyy').format(_selectedDay!)}:",
                        style: AppTextStyles.little_title_1,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _getEventsForDay(_selectedDay!).length,
                          itemBuilder: (context, index) {
                            final event = _getEventsForDay(_selectedDay!)[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title,
                                      style: AppTextStyles.coach_detail,
                                    ),
                                    Text(
                                      DateFormat('HH:mm').format(event.time),
                                      style: AppTextStyles.normal_nutri,
                                    ),
                                    Text(
                                      event.description,
                                      style: AppTextStyles.normal_nutri,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStudentsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Học viên của tôi",
            style: AppTextStyles.title1,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                final daysLeft = student.aimDate != null 
                    ? student.aimDate!.difference(DateTime.now()).inDays
                    : 0;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Text(
                        student.fullname.substring(0, 1),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      student.fullname,
                      style: AppTextStyles.coach_detail,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mục tiêu: ${student.goal ?? 'N/A'}",
                          style: AppTextStyles.normal_nutri,
                        ),
                        Text(
                          "Lịch tập: ${student.workOutDays?.join(', ') ?? 'N/A'}",
                          style: AppTextStyles.normal_nutri,
                        ),
                        Text(
                          "Thời hạn: còn $daysLeft ngày",
                          style: AppTextStyles.normal_nutri,
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.primary,
                    ),
                    onTap: () {
                      _showStudentDetails(student);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsScreen() {
    if (_trainingRequests.isEmpty) {
      return const Center(
        child: Text(
          "Không có yêu cầu thuê mới",
          style: AppTextStyles.title1,
        ),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Yêu cầu thuê mới",
            style: AppTextStyles.title1,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _trainingRequests.length,
              itemBuilder: (context, index) {
                final request = _trainingRequests[index];
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              request.studentName,
                              style: AppTextStyles.coach_detail,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 8),
                        _buildRequestInfoRow(
                          "Lịch tập:",
                          request.schedule.join(', '),
                        ),
                        _buildRequestInfoRow(
                          "Học phí:",
                          "${NumberFormat('#,###', 'vi_VN').format(request.fee)} VNĐ",
                        ),
                        _buildRequestInfoRow(
                          "Thời hạn:",
                          "${request.durationInMonths} tháng",
                        ),
                        if (request.note != null)
                          _buildRequestInfoRow("Ghi chú:", request.note!),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                foregroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
                                side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(color: AppColors.primary),
                                ),
                              ),
                              onPressed: () => _handleTrainingRequest(request, false),
                              child: const Text("Từ chối"),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: () => _handleTrainingRequest(request, true),
                              child: const Text("Chấp nhận"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: AppTextStyles.nutrition,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.normal_nutri,
            ),
          ),
        ],
      ),
    );
  }

  void _showStudentDetails(UserInfoModel student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Thông tin học viên: ${student.fullname}",
          style: AppTextStyles.coach_detail,
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoRow("Họ tên", student.fullname),
              _buildInfoRow("Giới tính", student.gender ?? "N/A"),
              _buildInfoRow("Tuổi", student.age?.toString() ?? "N/A"),
              _buildInfoRow("Chiều cao", student.height != null ? "${student.height} cm" : "N/A"),
              _buildInfoRow("Cân nặng", student.weight != null ? "${student.weight} kg" : "N/A"),
              _buildInfoRow("Cân nặng mục tiêu", student.aimWeight != null ? "${student.aimWeight} kg" : "N/A"),
              _buildInfoRow("Mục tiêu", student.goal ?? "N/A"),
              _buildInfoRow("Hạn đạt mục tiêu", student.aimDate != null 
                  ? DateFormat('dd/MM/yyyy').format(student.aimDate!)
                  : "N/A"),
              _buildInfoRow("Thời gian còn lại", student.aimDate != null 
                  ? "${student.aimDate!.difference(DateTime.now()).inDays} ngày"
                  : "N/A"),
              _buildInfoRow("Tình trạng sức khỏe", student.health != null 
                  ? student.health!.join(", ")
                  : "N/A"),
              _buildInfoRow("Lịch tập", student.workOutDays != null 
                  ? student.workOutDays!.join(", ")
                  : "N/A"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
            child: const Text("Đóng"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement editing student info
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Chức năng chỉnh sửa chưa được triển khai"))
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text("Chỉnh sửa"),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: AppTextStyles.nutrition,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.normal_nutri,
            ),
          ),
        ],
      ),
    );
  }
}