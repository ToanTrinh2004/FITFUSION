import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/models/workout_model.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';

class CombinedWorkoutExerciseScreen extends StatefulWidget {
  final UserInfoModel userInfo;
  final WorkoutProgram program;

  const CombinedWorkoutExerciseScreen({
    super.key,
    required this.userInfo,
    required this.program,
  });

  @override
  State<CombinedWorkoutExerciseScreen> createState() => _CombinedWorkoutExerciseScreenState();
}

class _CombinedWorkoutExerciseScreenState extends State<CombinedWorkoutExerciseScreen> {
  int selectedDayIndex = 0;
  int currentExerciseIndex = -1; // -1 means we're in day view, >= 0 means we're in exercise view
  Timer? countdownTimer;
  bool isCounting = false;
  late int secondsRemaining;

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    if (isCounting || secondsRemaining <= 0) return;

    setState(() {
      isCounting = true;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
        setState(() {
          isCounting = false;
        });
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  void openExerciseDetail(int exerciseIndex) {
    countdownTimer?.cancel();
    
    final currentDay = widget.program.workoutDays[selectedDayIndex];
    final exercise = currentDay.exercises[exerciseIndex];
    
    setState(() {
      currentExerciseIndex = exerciseIndex;
      secondsRemaining = exercise.durationInSeconds;
      isCounting = false;
    });
  }

  void goToNextExercise() {
    countdownTimer?.cancel();
    
    final currentDay = widget.program.workoutDays[selectedDayIndex];
    
    if (currentExerciseIndex < currentDay.exercises.length - 1) {
      // Move to next exercise
      int nextExerciseIndex = currentExerciseIndex + 1;
      final nextExercise = currentDay.exercises[nextExerciseIndex];
      
      setState(() {
        currentExerciseIndex = nextExerciseIndex;
        secondsRemaining = nextExercise.durationInSeconds;
        isCounting = false;
      });
    } else {
      // If we're at the last exercise, go back to day view
      setState(() {
        currentExerciseIndex = -1;
      });
      
      // Show completion message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chúc mừng! Bạn đã hoàn thành tất cả bài tập.'))
      );
    }
  }

  void goBackToWorkoutDay() {
    countdownTimer?.cancel();
    setState(() {
      currentExerciseIndex = -1;
      isCounting = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // Determine which view to show
    if (currentExerciseIndex >= 0) {
      return _buildExerciseDetailView();
    } else {
      return _buildWorkoutDayView();
    }
  }

  Widget _buildWorkoutDayView() {
    // Lấy thông tin ngày tập hiện tại
    WorkoutDay currentDay = widget.program.workoutDays[selectedDayIndex];
    
    // Tính tổng calories (giả định mỗi bài tập đốt trung bình 5 calo/phút)
    int estimatedCalories = currentDay.totalDurationInMinutes * 5;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3261E), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header có tên người dùng
              AppBarCustom(),

              // Tiêu đề chương trình
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  widget.program.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              
              // Thanh chọn ngày
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.program.workoutDays.length,
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedDayIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Ngày ${index + 1}',
                          style: TextStyle(
                            color: isSelected ? const Color(0xFFB3261E) : Colors.black54,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Thông tin ngày tập
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * 0.87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${currentDay.exercises.length}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text("bài tập"),
                      ],
                    ),
                    Text(
                      currentDay.dayName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Column(
                      children: [
                        Text(
                          "$estimatedCalories",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text("kalo"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              Text(
                "Thời gian: ${currentDay.totalDurationInMinutes} phút",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),

              // Danh sách bài tập
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: currentDay.exercises.length,
                  itemBuilder: (context, index) {
                    Exercise exercise = currentDay.exercises[index];
                    return InkWell(
                      onTap: () => openExerciseDetail(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exercise.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    exercise.description,
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "00:${exercise.durationInSeconds}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Nút bắt đầu tập
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      ),
                      child: const Text(
                        "QUAY LẠI",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Start with the first exercise
                        if (currentDay.exercises.isNotEmpty) {
                          openExerciseDetail(0);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB3261E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      ),
                      child: const Text(
                        "BẮT ĐẦU",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildExerciseDetailView() {
    final currentDay = widget.program.workoutDays[selectedDayIndex];
    final exercise = currentDay.exercises[currentExerciseIndex];
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3261E), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarCustom(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  exercise.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: GestureDetector(
                                  onTap: goBackToWorkoutDay,
                                  child: const Icon(Icons.close, color: Color(0xFFB3261E)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: _buildImageWidget(exercise.gifPath),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Hướng dẫn",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            exercise.description,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Container with countdown and start button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Thời lượng:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "00 : ${secondsRemaining.toString().padLeft(2, '0')}",
                                    style: const TextStyle(
                                      color: Color(0xFFB3261E),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: isCounting ? null : startCountdown,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB3261E),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                ),
                                child: Text(isCounting ? "ĐANG CHẠY" : "BẮT ĐẦU"),
                              ),
                            ],
                          ),
                        ),
                        // Progress indicator to show which exercise we're on
                        Container(
                          margin: const EdgeInsets.only(top: 24, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Bài tập ${currentExerciseIndex + 1}/${currentDay.exercises.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: goBackToWorkoutDay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAA1F17),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "QUAY LẠI",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: goToNextExercise,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFFB3261E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          currentExerciseIndex >= currentDay.exercises.length - 1 
                              ? "HOÀN THÀNH" 
                              : "TIẾP TỤC",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String gifPath) {
    if (gifPath.isEmpty) {
      gifPath = 'assets/exercises/caumong.gif';
    }

    if (gifPath.startsWith('http://') || gifPath.startsWith('https://')) {
      return Image.network(
        gifPath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFB3261E)),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildImageErrorWidget();
        },
      );
    } else {
      return Image.asset(
        gifPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildImageErrorWidget();
        },
      );
    }
  }

  Widget _buildImageErrorWidget() {
    return Container(
      color: const Color(0xFFAA1F17),
      alignment: Alignment.center,
      child: const Text(
        "Không thể tải hình ảnh",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}