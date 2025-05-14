import 'package:fitfusion_frontend/api/contract/accept_request.dart';
import 'package:fitfusion_frontend/api/contract/fetch_request_service.dart';
import 'package:fitfusion_frontend/api/contract/fetch_contract_service.dart'; // Import contract service
import 'package:fitfusion_frontend/api/contract/reject_request.dart';
import 'package:fitfusion_frontend/widgets/calendar_widget.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/coach_model.dart';
import '../../models/contract_model.dart'; // Import contract model
import '../../models/training_request_model.dart';
import '../../theme/theme.dart';
import '../../widgets/student_list_widget.dart'; // Import StudentsListWidget
import '../../widgets/training_request_widget.dart';

class HomeCoachScreen extends StatefulWidget {
  final Coach coachInfo;

  const HomeCoachScreen({Key? key, required this.coachInfo}) : super(key: key);

  @override
  State<HomeCoachScreen> createState() => _HomeCoachScreenState();
}

class _HomeCoachScreenState extends State<HomeCoachScreen> {
  int _currentIndex = 0;
  List<TrainingRequest> _trainingRequests = [];
  List<ContractModel> _students = []; // Add students list
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTrainingRequests();
    _fetchContracts(); // Fetch contracts (students)
  }

  Future<void> _fetchTrainingRequests() async {
    setState(() {
      _isLoading = true;
    });

    try {
      debugPrint("[DEBUG] Fetching requests for coachId: ${widget.coachInfo.coachId}");
      final requests = await FetchRequest.fetchRequestsByCoachId(widget.coachInfo.coachId);
      setState(() {
        _trainingRequests = requests;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load training requests. $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchContracts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      debugPrint("[DEBUG] Fetching contracts for coachId: ${widget.coachInfo.coachId}");
      final contracts = await FetchContractService.fetchContractsByCoachId(widget.coachInfo.coachId);
      setState(() {
        _students = contracts;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load contracts. $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: Column(
            children: [
              const AppBarCustom(),
              const Text("Home Coach", style: AppTextStyles.title1),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _buildBody(),
              ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchTrainingRequests();
          _fetchContracts(); // Refresh contracts when the button is pressed
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0: // Lịch của tôi tab
        return ScheduleCalendar(
          contracts: _students, // Pass the contracts data to the calendar
        );
      case 1: // Học viên tab
        return StudentsListWidget(
          contracts: _students,
          onContractTap: (contract) {
            // Handle contract tap (e.g., navigate to student details)
            debugPrint("Tapped on contract with customer: ${contract.customerName}");
          },
        );
      case 2: // Yêu cầu mới tab
        return TrainingRequestsWidget(
          trainingRequests: _trainingRequests,
          onRefresh: _fetchTrainingRequests,
          onRequestAction: (request, accept) async {
            if (accept) {
              bool success = await AcceptRequestService.acceptRequest(request.id);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request accepted successfully!')),
                );
                _fetchTrainingRequests();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to accept request.')),
                );
              }
            } else {
              bool success = await RejectRequestService.rejectRequest(request.id);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request rejected successfully!')),
                );
                _fetchTrainingRequests();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to reject request.')),
                );
              }
            }
          },
        );
      default:
        return const Center(
          child: Text("Feature not implemented yet."),
        );
    }
  }
}