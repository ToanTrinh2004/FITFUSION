// screen/main_features/coach/coachScreen.dart
import 'package:flutter/material.dart';
import '../../../api/coach/coachService.dart';
import '../../../models/coach_model.dart';
import 'contactCoach.dart';
import 'my_coach.dart';
import '../../../widgets/tabbar.dart';
import '../../../theme/theme.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> with SingleTickerProviderStateMixin {
  double _age = 60;
  String _selectedGender = "Tất cả";
  String _selectedField = "Tất cả";
  String _selectedRegion = "Tất cả";
  late TabController _tabController;

  List<Coach> _allCoaches = [];
  List<Coach> _filteredCoaches = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchCoaches();
  }

  void _fetchCoaches() async {
    try {
      final coaches = await CoachService.fetchAllCoaches();
      setState(() {
        _allCoaches = coaches;
        _filteredCoaches = coaches;
      });
    } catch (e) {
      print('Error fetching coaches: $e');
    }
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
                      setModalState(() => tempAge = value);
                    },
                  ),
                  const Text("Giới tính"),
                  DropdownButton<String>(
                    value: tempGender,
                    isExpanded: true,
                    items: ["Tất cả", "Male", "Female"].map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (newValue) => setModalState(() => tempGender = newValue!),
                  ),
                  const Text("Lĩnh vực"),
                  DropdownButton<String>(
                    value: tempField,
                    isExpanded: true,
                    items: ["Tất cả", "Gym", "Yoga", "Fitness", "yoga and fitness"].map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (newValue) => setModalState(() => tempField = newValue!),
                  ),
                  const Text("Khu vực"),
                  DropdownButton<String>(
                    value: tempRegion,
                    isExpanded: true,
                    items: ["Tất cả", "Hà Nội", "Hồ Chí Minh", "Đà Nẵng"].map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (newValue) => setModalState(() => tempRegion = newValue!),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
        final matchesAge = coach.age <= _age;
        final matchesGender = _selectedGender == "Tất cả" || coach.gender == _selectedGender;
        final matchesField = _selectedField == "Tất cả" || coach.major.contains(_selectedField);
        final matchesRegion = true; // No region in API yet
        return matchesAge && matchesGender && matchesField && matchesRegion;
      }).toList();
    });
  }

  Widget _buildCoachList() {
    return ListView.builder(
      itemCount: _filteredCoaches.length,
      itemBuilder: (context, index) {
        final coach = _filteredCoaches[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CoachDetailScreen(coach: {
                'name': coach.fullName,
                'gender': coach.gender,
                'age': coach.age.toString(),
                'field': coach.major,
                'region': 'Hà Nội',
                'introduction' : coach.introduction
              });
            }));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3))],
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Icon(Icons.person, color: Colors.white)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tên: ${coach.fullName}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("Giới tính: ${coach.gender}", style: const TextStyle(fontSize: 13)),
                    Text("Tuổi: ${coach.age}", style: const TextStyle(fontSize: 13)),
                    Text("Chuyên ngành: ${coach.major}", style: const TextStyle(fontSize: 13)),
                    Text("Khu vực: Hà Nội", style: const TextStyle(fontSize: 13)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              AppBarCustom(),
              const SizedBox(height: 10),
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(color: Colors.white),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.red[700],
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(text: "Danh sách HLV"),
                    Tab(text: "HLV của tôi"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _tabController.index == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: const Icon(Icons.tune, color: Colors.white, size: 28), onPressed: _showFilterModal),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('HLV của tôi', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(width: 40),
                        ],
                      ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCoachList(),
                    const MyCoachList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
