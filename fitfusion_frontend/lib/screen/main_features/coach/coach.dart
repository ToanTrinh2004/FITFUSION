import 'package:fitfusion_frontend/screen/main_features/coach/contactCoach.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CoachScreen(),
  ));
}

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  double _age = 60;
  String _selectedGender = "Tất cả";
  String _selectedField = "Tất cả";
  String _selectedRegion = "Tất cả";

  final List<Map<String, String>> _allCoaches = [
    {
      'name': 'Nguyen Van A',
      'gender': 'Nam',
      'age': '25',
      'field': 'Gym',
      'region': 'Hà Nội',
    },
    {
      'name': 'Tran Thi B',
      'gender': 'Nữ',
      'age': '28',
      'field': 'Yoga',
      'region': 'Hồ Chí Minh',
    },
    {
      'name': 'Le Van C',
      'gender': 'Nam',
      'age': '30',
      'field': 'Fitness',
      'region': 'Đà Nẵng',
    },
  ];

  List<Map<String, String>> _filteredCoaches = [];

  @override
  void initState() {
    super.initState();
    _filteredCoaches = _allCoaches;
  }

  void _showFilterModal() {
    double tempAge = _age;
    String tempGender = _selectedGender;
    String tempField = _selectedField;
    String tempRegion = _selectedRegion;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const Text("Bộ lọc", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Tuổi"),
                  Slider(
                    value: tempAge,
                    min: 18,
                    max: 60,
                    divisions: 42,
                    label: tempAge.round().toString(),
                    onChanged: (value) {
                      setModalState(() {
                        tempAge = value;
                      });
                    },
                  ),
                  const Text("Giới tính"),
                  DropdownButton<String>(
                    value: tempGender,
                    isExpanded: true,
                    items: ["Tất cả", "Nam", "Nữ"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setModalState(() {
                        tempGender = newValue!;
                      });
                    },
                  ),
                  const Text("Lĩnh vực"),
                  DropdownButton<String>(
                    value: tempField,
                    isExpanded: true,
                    items: ["Tất cả", "Gym", "Yoga", "Fitness"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setModalState(() {
                        tempField = newValue!;
                      });
                    },
                  ),
                  const Text("Khu vực"),
                  DropdownButton<String>(
                    value: tempRegion,
                    isExpanded: true,
                    items: ["Tất cả", "Hà Nội", "Hồ Chí Minh", "Đà Nẵng"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setModalState(() {
                        tempRegion = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _age = tempAge;
                          _selectedGender = tempGender;
                          _selectedField = tempField;
                          _selectedRegion = tempRegion;
                          _filterCoaches();
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Áp dụng", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _filterCoaches() {
    setState(() {
      _filteredCoaches = _allCoaches.where((coach) {
        bool matchesAge = double.parse(coach["age"]!) <= _age;
        bool matchesGender = _selectedGender == "Tất cả" || coach["gender"] == _selectedGender;
        bool matchesField = _selectedField == "Tất cả" || coach["field"] == _selectedField;
        bool matchesRegion = _selectedRegion == "Tất cả" || coach["region"] == _selectedRegion;
        return matchesAge && matchesGender && matchesField && matchesRegion;
      }).toList();
    });
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              AppBarCustom(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Danh sách HLV',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.tune, color: Colors.white, size: 28),
                      onPressed: _showFilterModal,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredCoaches.length,
                  itemBuilder: (context, index) {
                    final coach = _filteredCoaches[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CoachDetailScreen(coach: coach),
                          ),
                        );
                      },
                      child: Container(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tên: ${coach['name']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text("Giới tính: ${coach['gender']}", style: const TextStyle(fontSize: 13)),
                                Text("Tuổi: ${coach['age']}", style: const TextStyle(fontSize: 13)),
                                Text("Chuyên ngành: ${coach['field']}", style: const TextStyle(fontSize: 13)),
                                Text("Khu vực: ${coach['region']}", style: const TextStyle(fontSize: 13)),
                              ],
                            )
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
    );
  }
}
