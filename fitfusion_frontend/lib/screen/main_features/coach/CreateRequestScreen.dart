import 'package:fitfusion_frontend/api/contract/request_service.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/theme/theme.dart';


class CreateRequestScreen extends StatefulWidget {
  final Map<String, dynamic> coach;

  const CreateRequestScreen({super.key, required this.coach});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDuration = '1 tháng';
  final List<String> _durations = ['1 tháng', '3 tháng', '6 tháng', '12 tháng'];
  
  // Schedule management
  final List<Map<String, String>> _schedule = [];
  final List<String> _days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
  String _selectedDay = 'monday';
  TimeOfDay _selectedTime = TimeOfDay(hour: 20, minute: 0); // 8:00 PM

  // Fee calculation
  double _fee = 0; // Will be set based on coach's tuition fee and duration
  
  bool _isLoading = false;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    // Initialize fee based on coach's tuition fee if available
   _fee = double.tryParse(widget.coach['tuitionFees'] ?? '') ?? 1500000;

    _updateFee();
  }

  void _updateFee() {
    // Base fee from coach data
    double baseFee = double.tryParse(widget.coach['tuitionFees'] ?? '') ?? 1500000;
    
    switch (_selectedDuration) {
      case '1 tháng':
        _fee = baseFee;
        break;
      case '3 tháng':
        _fee = 3*baseFee ;
        break;
      case '6 tháng':
        _fee = 6*baseFee ;
        break;
      case '12 tháng':
        _fee = 12*baseFee;
        break;
    }
    setState(() {});
  }
  String formatMoney(int amount) {
    if (amount < 1000) return amount.toString();
    final String amountStr = amount.toString();
    final int length = amountStr.length;
    String result = '';
    for (int i = 0; i < length; i++) {
      if ((length - i) % 3 == 0 && i != 0) {
        result += '.';
      }
      result += amountStr[i];
    }
    return result;
  }
  void _addScheduleSlot() {
    // Check if this day and time combination already exists
    bool exists = _schedule.any((slot) => 
        slot['day'] == _selectedDay && slot['time'] == _formatTimeOfDay(_selectedTime));
        
    if (!exists) {
      setState(() {
        _schedule.add({
          'day': _selectedDay,
          'time': _formatTimeOfDay(_selectedTime)
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thời gian này đã được thêm vào'))
      );
    }
  }
  
  void _removeScheduleSlot(int index) {
    setState(() {
      _schedule.removeAt(index);
    });
  }
  
  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    // Format the TimeOfDay to a string in HH:MM format
    String hour = timeOfDay.hour.toString().padLeft(2, '0');
    String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _submitRequest() async {
    if (_schedule.isEmpty) {
      setState(() {
        _errorMessage = 'Vui lòng thêm ít nhất một khoảng thời gian trong lịch trình';
      });
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Mock customer ID - in a real app, you would get this from user authentication
      final String customerId = '64fe85b0a7e23c4a6f1e9a23'; 
      
      // Get coach ID from the coach data
      final String coachId = widget.coach['coachId'] ?? '64fe85b0c7e23c4a6f1e9a23';
      
      // Use the RequestService to make the API call
      final response = await RequestService.createRequest(
        customerId: customerId,
        coachId: coachId,
        duration: _selectedDuration,
        schedule: _schedule,
        fee: _fee,
      );
      
      if (response['statusCode'] == 201) {
        // Request created successfully
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Yêu cầu đã được gửi thành công!'))
          );
          Navigator.pop(context); // Go back to previous screen
        }
      } else {
        // Handle error
        setState(() {
          _errorMessage = 'Không thể gửi yêu cầu: ${response['error'] ?? response['message'] ?? 'Unknown error'}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Create Request", style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        )),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: appGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
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
                    // Coach info section
                    Text("Thông tin HLV", style: AppTextStyles.subtitle),
                    SizedBox(height: screenHeight * 0.01),
                    Text("Họ và tên: ${widget.coach['name'] ?? 'N/A'}", style: AppTextStyles.coach_detail),
                    Text("Lĩnh vực: ${widget.coach['field'] ?? 'N/A'}", style: AppTextStyles.coach_detail),
                    if (widget.coach['specialization'] != null)
                      Text("Chuyên môn: ${widget.coach['specialization']}", style: AppTextStyles.coach_detail),
                    SizedBox(height: screenHeight * 0.02),
                  
                    // Duration selection
                    Text("Chọn thời lượng thuê", style: AppTextStyles.subtitle),
                    SizedBox(height: screenHeight * 0.01),
                    DropdownButtonFormField<String>(
                      value: _selectedDuration,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      items: _durations.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDuration = newValue!;
                          _updateFee();
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    
                    // Schedule section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Đặt lịch trình", style: AppTextStyles.subtitle),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        
                        // Day selection
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedDay,
                                decoration: InputDecoration(
                                  labelText: 'Day',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                                items: _days.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedDay = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            
                            // Time selection
                            ElevatedButton.icon(
                              icon: Icon(Icons.access_time),
                              label: Text(_formatTimeOfDay(_selectedTime)),
                              onPressed: _showTimePicker,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: screenHeight * 0.01),
                        
                        // Add schedule button
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: _addScheduleSlot,
                            icon: Icon(Icons.add, color: Colors.red),
                            label: Text("Thêm buổi tập", 
                              style: AppTextStyles.textButtonOne,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.06,
                                vertical: screenHeight * 0.012,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: screenHeight * 0.02),
                    
                    // Display selected schedule slots
                    if (_schedule.isNotEmpty) ...[
                      Text("Lịch trình đã chọn", style: AppTextStyles.subtitle),
                      SizedBox(height: screenHeight * 0.01),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: List.generate(_schedule.length, (index) {
                            final slot = _schedule[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${slot['day']} at ${slot['time']}', 
                                    style: AppTextStyles.coach_detail),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeScheduleSlot(index),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                    
                    // Fee information
                    Text("Thông tin về lệ phí", style: AppTextStyles.subtitle),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Tổng lệ phí: ${formatMoney(_fee.toInt())} VND",
                      style: AppTextStyles.coach_detail,
                    ),
                    Text(
                      "Cho ${_selectedDuration} thuê huấn luyện viên",
                      style: AppTextStyles.coach_detail,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    
                    // Error message
                    if (_errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    
                    // Submit button
                    Center(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textPrimary,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: screenHeight * 0.015,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text("Gửi yêu cầu", style: AppTextStyles.textButtonOne),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}