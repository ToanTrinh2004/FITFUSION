//Các lớp chính:

// Exercise: Lưu thông tin chi tiết về mỗi bài tập (tên, đường dẫn GIF, mức độ khó, nhóm cơ, thời gian...)
// WorkoutDay: Đại diện cho một ngày tập luyện, bao gồm danh sách các bài tập
// WorkoutProgram: Đại diện cho một chương trình tập luyện đầy đủ, bao gồm nhiều ngày tập
// WorkoutModel: Lớp chính quản lý việc tạo và tùy chỉnh các chương trình tập luyện

// Các cấp độ tập luyện:

// Cơ bản (Basic): Dành cho người mới, 4 bài tập mỗi ngày
// Trung bình (Intermediate): 6 bài tập mỗi ngày
// Nâng cao (Advanced): 8 bài tập mỗi ngày

// Các chương trình tập luyện theo số ngày:

// 3 ngày/tuần: Tập theo mô hình Upper/Lower/Full Body
// 4 ngày/tuần: Tập theo mô hình Ngực+Vai/Lưng+Tay/Chân/Core
// 5 ngày/tuần: Tập theo mô hình từng nhóm cơ riêng biệt
// 6 ngày/tuần: Tập theo mô hình Push/Pull/Legs (lặp lại 2 lần)

import 'dart:math';

// Định nghĩa enum cho mức độ khó của bài tập
enum WorkoutLevel {
  basic,
  intermediate,
  advanced,
}

// Định nghĩa enum cho các nhóm cơ
enum MuscleGroup {
  chest,
  back,
  legs,
  arms,
  shoulders,
  core,
  fullBody,
}

// Lớp Exercise để lưu thông tin về mỗi bài tập
class Exercise {
  final String id;
  final String name;
  final String gifPath;
  final WorkoutLevel level;
  final List<MuscleGroup> muscleGroups;
  final int durationInSeconds;
  final String description;

  Exercise({
    required this.id,
    required this.name,
    required this.gifPath,
    required this.level,
    required this.muscleGroups,
    required this.durationInSeconds,
    required this.description,
  });
}

// Lớp WorkoutDay đại diện cho lịch tập của một ngày
class WorkoutDay {
  final String dayName;
  final List<Exercise> exercises;
  final int restBetweenExercisesInSeconds;
  final int totalDurationInMinutes;

  WorkoutDay({
    required this.dayName,
    required this.exercises,
    this.restBetweenExercisesInSeconds = 30,
  }) : totalDurationInMinutes = _calculateTotalDuration(exercises, restBetweenExercisesInSeconds);

  static int _calculateTotalDuration(List<Exercise> exercises, int restBetweenExercisesInSeconds) {
    int totalSeconds = 0;
    for (var exercise in exercises) {
      totalSeconds += exercise.durationInSeconds;
    }
    // Thêm thời gian nghỉ giữa các bài tập
    totalSeconds += (exercises.length - 1) * restBetweenExercisesInSeconds;
    // Chuyển đổi từ giây sang phút và làm tròn lên
    return (totalSeconds / 60).ceil();
  }
}

// Lớp WorkoutProgram chứa toàn bộ chương trình tập luyện cho một tuần
class WorkoutProgram {
  final WorkoutLevel level;
  final int daysPerWeek;
  final List<WorkoutDay> workoutDays;
  final String name;

  WorkoutProgram({
    required this.level,
    required this.daysPerWeek,
    required this.workoutDays,
    required this.name,
  });
}

// Lớp chính quản lý việc tạo ra các chương trình tập luyện
class WorkoutModel {
  // Danh sách tất cả các bài tập có sẵn
  final List<Exercise> allExercises = [
    Exercise(
      id: 'caumong',
      name: 'Cau mông',
      gifPath: 'assets/exercises/caumong.gif',
      level: WorkoutLevel.basic,
      muscleGroups: [MuscleGroup.legs],
      durationInSeconds: 45,
      description: 'Bài tập tăng cường cơ mông và đùi sau.',
    ),
    Exercise(
      id: 'conbo',
      name: 'Con bò',
      gifPath: 'assets/exercises/conbo.gif',
      level: WorkoutLevel.basic,
      muscleGroups: [MuscleGroup.core, MuscleGroup.shoulders],
      durationInSeconds: 60,
      description: 'Bài tập tăng cường sức mạnh cơ lõi và vai.',
    ),
    Exercise(
      id: 'conran',
      name: 'Con rắn',
      gifPath: 'assets/exercises/conran.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.back, MuscleGroup.core],
      durationInSeconds: 45,
      description: 'Bài tập giãn cơ lưng và tăng cường cơ lõi.',
    ),
    Exercise(
      id: 'eobenphai',
      name: 'Eo bên phải',
      gifPath: 'assets/exercises/eobenphai.gif',
      level: WorkoutLevel.basic,
      muscleGroups: [MuscleGroup.core],
      durationInSeconds: 30,
      description: 'Bài tập tăng cường cơ eo bên phải.',
    ),
    Exercise(
      id: 'eobentrai',
      name: 'Eo bên trái',
      gifPath: 'assets/exercises/eobentrai.gif',
      level: WorkoutLevel.basic,
      muscleGroups: [MuscleGroup.core],
      durationInSeconds: 30,
      description: 'Bài tập tăng cường cơ eo bên trái.',
    ),
    Exercise(
      id: 'gapbung',
      name: 'Gập bụng',
      gifPath: 'assets/exercises/gapbung.gif',
      level: WorkoutLevel.basic,
      muscleGroups: [MuscleGroup.core],
      durationInSeconds: 45,
      description: 'Bài tập cơ bản cho cơ bụng.',
    ),
    Exercise(
      id: 'gapbungkieunga',
      name: 'Gập bụng kiểu nằm',
      gifPath: 'assets/exercises/gapbungkieunga.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.core],
      durationInSeconds: 60,
      description: 'Bài tập cơ bụng nâng cao với tư thế nằm.',
    ),
    Exercise(
      id: 'gapchan',
      name: 'Gập chân',
      gifPath: 'assets/exercises/gapchan.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.legs, MuscleGroup.core],
      durationInSeconds: 45,
      description: 'Bài tập kết hợp cơ bụng dưới và cơ đùi.',
    ),
    Exercise(
      id: 'gapcobung',
      name: 'Gập cơ bụng',
      gifPath: 'assets/exercises/gapcobung.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.core],
      durationInSeconds: 60,
      description: 'Bài tập tăng cường cơ bụng 6 múi.',
    ),
    Exercise(
      id: 'leonui',
      name: 'Leo núi',
      gifPath: 'assets/exercises/leonui.gif',
      level: WorkoutLevel.advanced,
      muscleGroups: [MuscleGroup.fullBody, MuscleGroup.core],
      durationInSeconds: 60,
      description: 'Bài tập cardio kết hợp tăng cường toàn thân.',
    ),
    Exercise(
      id: 'nangchan',
      name: 'Nâng chân',
      gifPath: 'assets/exercises/nangchan.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.legs, MuscleGroup.core],
      durationInSeconds: 45,
      description: 'Bài tập tăng cường cơ bụng dưới và chân.',
    ),
    Exercise(
      id: 'nghiengnguoicoliensun',
      name: 'Nghiêng người co liên sun',
      gifPath: 'assets/exercises/nghiengnguoicoliensun.gif',
      level: WorkoutLevel.advanced,
      muscleGroups: [MuscleGroup.core, MuscleGroup.arms],
      durationInSeconds: 60,
      description: 'Bài tập phức hợp tăng cường cơ lõi và tay.',
    ),
    Exercise(
      id: 'nhay',
      name: 'Nhảy',
      gifPath: 'assets/exercises/nhay.gif',
      level: WorkoutLevel.basic,
      muscleGroups: [MuscleGroup.legs, MuscleGroup.fullBody],
      durationInSeconds: 60,
      description: 'Bài tập cardio cơ bản cho toàn thân.',
    ),
    Exercise(
      id: 'plank',
      name: 'Plank',
      gifPath: 'assets/exercises/plank.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.core, MuscleGroup.shoulders],
      durationInSeconds: 60,
      description: 'Bài tập tăng cường cơ lõi và ổn định thân.',
    ),
    Exercise(
      id: 'tamvanchuTPhai',
      name: 'Tấm ván chữ T phải',
      gifPath: 'assets/exercises/tamvanchuTPhai.gif',
      level: WorkoutLevel.advanced,
      muscleGroups: [MuscleGroup.core, MuscleGroup.shoulders],
      durationInSeconds: 45,
      description: 'Biến thể nâng cao của plank, tập trung vào cơ bên phải.',
    ),
    Exercise(
      id: 'tamvanchuTTrai',
      name: 'Tấm ván chữ T trái',
      gifPath: 'assets/exercises/tamvanchuTTrai.gif',
      level: WorkoutLevel.advanced,
      muscleGroups: [MuscleGroup.core, MuscleGroup.shoulders],
      durationInSeconds: 45,
      description: 'Biến thể nâng cao của plank, tập trung vào cơ bên trái.',
    ),
    Exercise(
      id: 'taychamgot',
      name: 'Tay chạm gót',
      gifPath: 'assets/exercises/taychamgot.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.core],
      durationInSeconds: 45,
      description: 'Bài tập tăng cường cơ bụng nghiêng.',
    ),
    Exercise(
      id: 'vancheo',
      name: 'Ván chèo',
      gifPath: 'assets/exercises/vancheo.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.back, MuscleGroup.arms],
      durationInSeconds: 60,
      description: 'Bài tập tăng cường cơ lưng và tay.',
    ),
    Exercise(
      id: 'vanhong',
      name: 'Ván hông',
      gifPath: 'assets/exercises/vanhong.gif',
      level: WorkoutLevel.intermediate,
      muscleGroups: [MuscleGroup.core],
      durationInSeconds: 45,
      description: 'Biến thể của plank tăng cường cơ hông và thân.',
    ),
  ];

  // Tạo một chương trình tập luyện dựa vào mức độ và số ngày tập trong tuần
  WorkoutProgram createWorkoutProgram(WorkoutLevel level, int daysPerWeek) {
    // Lọc các bài tập phù hợp với mức độ
    List<Exercise> filteredExercises = _filterExercisesByLevel(level);
    
    // Tạo lịch tập cho từng ngày trong tuần đảm bảo số bài tập mỗi ngày bằng nhau
    List<WorkoutDay> workoutDays = _createBalancedWorkoutDays(filteredExercises, level, daysPerWeek);
    
    // Đặt tên cho chương trình tập luyện
    String programName = _getProgramName(level, daysPerWeek);
    
    return WorkoutProgram(
      level: level,
      daysPerWeek: daysPerWeek,
      workoutDays: workoutDays,
      name: programName,
    );
  }

  // Lọc các bài tập theo mức độ
  List<Exercise> _filterExercisesByLevel(WorkoutLevel level) {
    List<Exercise> result = [];
    
    switch(level) {
      case WorkoutLevel.basic:
        // Chỉ bao gồm các bài tập cơ bản
        result = allExercises.where((e) => e.level == WorkoutLevel.basic).toList();
        break;
      case WorkoutLevel.intermediate:
        // Bao gồm cả bài tập cơ bản và trung bình
        result = allExercises.where((e) => 
            e.level == WorkoutLevel.basic || e.level == WorkoutLevel.intermediate).toList();
        break;
      case WorkoutLevel.advanced:
        // Bao gồm tất cả các bài tập
        result = List.from(allExercises);
        break;
    }
    
    return result;
  }

  // Tạo danh sách các ngày tập với số bài tập mỗi ngày bằng nhau
  List<WorkoutDay> _createBalancedWorkoutDays(List<Exercise> availableExercises, WorkoutLevel level, int daysPerWeek) {
    // Số lượng bài tập cố định cho mỗi ngày dựa vào mức độ
    int exercisesPerDay = _getExercisesPerDayCount(level);
    
    // Phân loại bài tập theo nhóm cơ
    var groupedExercises = _groupExercisesByMuscle(availableExercises);
    
    // Tạo danh sách các ngày tập dựa vào số ngày tập trong tuần
    List<WorkoutDay> days = [];
    
    switch(daysPerWeek) {
      case 3:
        days = _createThreeDayBalancedProgram(groupedExercises, exercisesPerDay);
        break;
      case 4:
        days = _createFourDayBalancedProgram(groupedExercises, exercisesPerDay);
        break;
      case 5:
        days = _createFiveDayBalancedProgram(groupedExercises, exercisesPerDay);
        break;
      case 6:
        days = _createSixDayBalancedProgram(groupedExercises, exercisesPerDay);
        break;
      default:
        days = _createDefaultBalancedProgram(groupedExercises, exercisesPerDay, daysPerWeek);
        break;
    }
    
    return days;
  }

  // Tạo chương trình cân bằng 3 ngày trong tuần
  List<WorkoutDay> _createThreeDayBalancedProgram(Map<MuscleGroup, List<Exercise>> groupedExercises, int exercisesPerDay) {
    // Ngày 1: Tập phần trên (Ngực, Vai, Tay)
    List<Exercise> day1Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.chest, MuscleGroup.shoulders, MuscleGroup.arms],
      exercisesPerDay
    );
    
    // Ngày 2: Tập phần dưới (Chân, Mông) và Core
    List<Exercise> day2Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.legs, MuscleGroup.core],
      exercisesPerDay
    );
    
    // Ngày 3: Tập lưng và bổ sung
    List<Exercise> day3Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.back, MuscleGroup.fullBody, MuscleGroup.core],
      exercisesPerDay
    );
    
    return [
      WorkoutDay(dayName: 'Ngày 1: Phần trên', exercises: day1Exercises),
      WorkoutDay(dayName: 'Ngày 2: Phần dưới & Core', exercises: day2Exercises),
      WorkoutDay(dayName: 'Ngày 3: Lưng & Toàn thân', exercises: day3Exercises),
    ];
  }

  // Tạo chương trình cân bằng 4 ngày trong tuần
  List<WorkoutDay> _createFourDayBalancedProgram(Map<MuscleGroup, List<Exercise>> groupedExercises, int exercisesPerDay) {
    // Ngày 1: Ngực và Vai
    List<Exercise> day1Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.chest, MuscleGroup.shoulders],
      exercisesPerDay
    );
    
    // Ngày 2: Lưng và Tay
    List<Exercise> day2Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.back, MuscleGroup.arms],
      exercisesPerDay
    );
    
    // Ngày 3: Chân và Mông
    List<Exercise> day3Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.legs, MuscleGroup.fullBody],
      exercisesPerDay
    );
    
    // Ngày 4: Core và toàn thân
    List<Exercise> day4Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.core, MuscleGroup.fullBody],
      exercisesPerDay
    );
    
    return [
      WorkoutDay(dayName: 'Ngày 1: Ngực & Vai', exercises: day1Exercises),
      WorkoutDay(dayName: 'Ngày 2: Lưng & Tay', exercises: day2Exercises),
      WorkoutDay(dayName: 'Ngày 3: Chân', exercises: day3Exercises),
      WorkoutDay(dayName: 'Ngày 4: Core & Toàn thân', exercises: day4Exercises),
    ];
  }

  // Tạo chương trình cân bằng 5 ngày trong tuần
  List<WorkoutDay> _createFiveDayBalancedProgram(Map<MuscleGroup, List<Exercise>> groupedExercises, int exercisesPerDay) {
    // Ngày 1: Ngực
    List<Exercise> day1Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.chest, MuscleGroup.core],
      exercisesPerDay
    );
    
    // Ngày 2: Lưng
    List<Exercise> day2Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.back, MuscleGroup.core],
      exercisesPerDay
    );
    
    // Ngày 3: Chân
    List<Exercise> day3Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.legs, MuscleGroup.core],
      exercisesPerDay
    );
    
    // Ngày 4: Vai và Tay
    List<Exercise> day4Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.shoulders, MuscleGroup.arms],
      exercisesPerDay
    );
    
    // Ngày 5: Core và toàn thân
    List<Exercise> day5Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.core, MuscleGroup.fullBody],
      exercisesPerDay
    );
    
    return [
      WorkoutDay(dayName: 'Ngày 1: Ngực', exercises: day1Exercises),
      WorkoutDay(dayName: 'Ngày 2: Lưng', exercises: day2Exercises),
      WorkoutDay(dayName: 'Ngày 3: Chân', exercises: day3Exercises),
      WorkoutDay(dayName: 'Ngày 4: Vai & Tay', exercises: day4Exercises),
      WorkoutDay(dayName: 'Ngày 5: Core & Toàn thân', exercises: day5Exercises),
    ];
  }

  // Tạo chương trình cân bằng 6 ngày trong tuần
  List<WorkoutDay> _createSixDayBalancedProgram(Map<MuscleGroup, List<Exercise>> groupedExercises, int exercisesPerDay) {
    // Ngày 1: Đẩy (Ngực, Vai)
    List<Exercise> day1Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.chest, MuscleGroup.shoulders],
      exercisesPerDay
    );
    
    // Ngày 2: Kéo (Lưng, Tay)
    List<Exercise> day2Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.back, MuscleGroup.arms],
      exercisesPerDay
    );
    
    // Ngày 3: Chân và Core
    List<Exercise> day3Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.legs, MuscleGroup.core],
      exercisesPerDay
    );
    
    // Ngày 4: Đẩy - biến thể (Ngực, Vai)
    List<Exercise> day4Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.chest, MuscleGroup.shoulders],
      exercisesPerDay,
      excludeExercises: day1Exercises
    );
    
    // Ngày 5: Kéo - biến thể (Lưng, Tay)
    List<Exercise> day5Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.back, MuscleGroup.arms],
      exercisesPerDay,
      excludeExercises: day2Exercises
    );
    
    // Ngày 6: Chân, Core & toàn thân
    List<Exercise> day6Exercises = _getRandomBalancedExercisesForGroups(
      groupedExercises, 
      [MuscleGroup.legs, MuscleGroup.core, MuscleGroup.fullBody],
      exercisesPerDay,
      excludeExercises: day3Exercises
    );
    
    return [
      WorkoutDay(dayName: 'Ngày 1: Đẩy - Ngực & Vai', exercises: day1Exercises),
      WorkoutDay(dayName: 'Ngày 2: Kéo - Lưng & Tay', exercises: day2Exercises),
      WorkoutDay(dayName: 'Ngày 3: Chân & Core', exercises: day3Exercises),
      WorkoutDay(dayName: 'Ngày 4: Đẩy - Biến thể', exercises: day4Exercises),
      WorkoutDay(dayName: 'Ngày 5: Kéo - Biến thể', exercises: day5Exercises),
      WorkoutDay(dayName: 'Ngày 6: Chân, Core & Toàn thân', exercises: day6Exercises),
    ];
  }

  // Tạo chương trình cân bằng mặc định cho số ngày tùy ý
  List<WorkoutDay> _createDefaultBalancedProgram(Map<MuscleGroup, List<Exercise>> groupedExercises, int exercisesPerDay, int daysPerWeek) {
    List<WorkoutDay> result = [];
    
    // Danh sách các nhóm cơ tập trung cho mỗi ngày
    List<List<MuscleGroup>> dayFocus = [
      [MuscleGroup.chest, MuscleGroup.shoulders],
      [MuscleGroup.back, MuscleGroup.arms],
      [MuscleGroup.legs, MuscleGroup.core],
      [MuscleGroup.shoulders, MuscleGroup.chest],
      [MuscleGroup.arms, MuscleGroup.back],
      [MuscleGroup.core, MuscleGroup.legs],
      [MuscleGroup.fullBody, MuscleGroup.core]
    ];
    
    // Tạo một chương trình tập cho mỗi ngày với số bài tập bằng nhau
    for (int i = 0; i < daysPerWeek; i++) {
      int dayIndex = i % dayFocus.length;
      
      List<Exercise> dayExercises = _getRandomBalancedExercisesForGroups(
        groupedExercises, 
        dayFocus[dayIndex],
        exercisesPerDay
      );
      
      result.add(WorkoutDay(
        dayName: 'Ngày ${i + 1}: ${_getDayFocusName(dayFocus[dayIndex])}',
        exercises: dayExercises
      ));
    }
    
    return result;
  }

  // Lấy tên nhóm cơ tập trung cho ngày đó
  String _getDayFocusName(List<MuscleGroup> groups) {
    if (groups.contains(MuscleGroup.fullBody)) {
      return 'Toàn thân';
    }
    
    List<String> names = [];
    if (groups.contains(MuscleGroup.chest)) names.add('Ngực');
    if (groups.contains(MuscleGroup.back)) names.add('Lưng');
    if (groups.contains(MuscleGroup.legs)) names.add('Chân');
    if (groups.contains(MuscleGroup.arms)) names.add('Tay');
    if (groups.contains(MuscleGroup.shoulders)) names.add('Vai');
    if (groups.contains(MuscleGroup.core)) names.add('Core');
    
    return names.join(' & ');
  }

  // Lấy số lượng bài tập cố định mỗi ngày dựa vào mức độ
  int _getExercisesPerDayCount(WorkoutLevel level) {
    switch(level) {
      case WorkoutLevel.basic:
        return 4; // 4 bài tập mỗi ngày cho người mới
      case WorkoutLevel.intermediate:
        return 6; // 6 bài tập mỗi ngày cho mức độ trung bình
      case WorkoutLevel.advanced:
        return 8; // 8 bài tập mỗi ngày cho mức độ nâng cao
      default:
        return 5;
    }
  }

  // Lấy tên cho chương trình tập luyện
  String _getProgramName(WorkoutLevel level, int daysPerWeek) {
    String levelStr = '';
    switch(level) {
      case WorkoutLevel.basic:
        levelStr = 'Cơ bản';
        break;
      case WorkoutLevel.intermediate:
        levelStr = 'Trung bình';
        break;
      case WorkoutLevel.advanced:
        levelStr = 'Nâng cao';
        break;
    }
    
    return 'Chương trình $levelStr - $daysPerWeek ngày/tuần';
  }

  // Nhóm các bài tập theo nhóm cơ
  Map<MuscleGroup, List<Exercise>> _groupExercisesByMuscle(List<Exercise> exercises) {
    Map<MuscleGroup, List<Exercise>> result = {};
    
    // Khởi tạo danh sách rỗng cho mỗi nhóm cơ
    for (var group in MuscleGroup.values) {
      result[group] = [];
    }
    
    // Phân loại các bài tập vào các nhóm cơ
    for (var exercise in exercises) {
      for (var group in exercise.muscleGroups) {
        result[group]!.add(exercise);
      }
    }
    
    return result;
  }

  // Lấy ngẫu nhiên các bài tập cho các nhóm cơ nhất định, đảm bảo luôn đủ số lượng
  List<Exercise> _getRandomBalancedExercisesForGroups(
    Map<MuscleGroup, List<Exercise>> groupedExercises,
    List<MuscleGroup> targetGroups,
    int count,
    {List<Exercise> excludeExercises = const []}
  ) {
    // Kết hợp tất cả các bài tập từ các nhóm cơ mục tiêu
    List<Exercise> combinedExercises = [];
    for (var group in targetGroups) {
      combinedExercises.addAll(groupedExercises[group]!);
    }
    
    // Loại bỏ các bài tập trùng lặp
    combinedExercises = combinedExercises.toSet().toList();
    
    // Loại bỏ các bài tập bị loại trừ
    combinedExercises.removeWhere((e) => excludeExercises.any((ex) => ex.id == e.id));
    
    // Trộn ngẫu nhiên danh sách bài tập
    combinedExercises.shuffle();
    
    // Đảm bảo lấy đủ số lượng bài tập yêu cầu
    int resultCount = min(count, combinedExercises.length);
    return combinedExercises.take(resultCount).toList();
  }
  
  // Các chương trình tập mẫu để hiển thị trong ứng dụng
  List<WorkoutProgram> getSamplePrograms() {
    List<WorkoutProgram> programs = [];
    
    // Thêm các chương trình mẫu cho mỗi cấp độ và số ngày
    programs.add(createWorkoutProgram(WorkoutLevel.basic, 3));
    programs.add(createWorkoutProgram(WorkoutLevel.basic, 4));
    programs.add(createWorkoutProgram(WorkoutLevel.basic, 5));
    
    programs.add(createWorkoutProgram(WorkoutLevel.intermediate, 3));
    programs.add(createWorkoutProgram(WorkoutLevel.intermediate, 4));
    programs.add(createWorkoutProgram(WorkoutLevel.intermediate, 5));
    
    programs.add(createWorkoutProgram(WorkoutLevel.advanced, 3));
    programs.add(createWorkoutProgram(WorkoutLevel.advanced, 4));
    programs.add(createWorkoutProgram(WorkoutLevel.advanced, 6));
    
    return programs;
  }
  
  // Tạo và lấy một chương trình cụ thể dựa trên những tham số đầu vào
  WorkoutProgram getSpecificProgram(WorkoutLevel level, int daysPerWeek) {
    return createWorkoutProgram(level, daysPerWeek);
  }
  
  // Chuyển đổi WorkoutLevel từ chuỗi
  static WorkoutLevel levelFromString(String levelStr) {
    switch(levelStr.toLowerCase()) {
      case 'basic':
      case 'cơ bản':
        return WorkoutLevel.basic;
      case 'intermediate':
      case 'trung bình':
        return WorkoutLevel.intermediate;
      case 'advanced':
      case 'nâng cao':
        return WorkoutLevel.advanced;
      default:
        return WorkoutLevel.basic;
    }
  }
  
  // Hàm tiện ích để chuyển đổi WorkoutLevel thành chuỗi
  static String levelToString(WorkoutLevel level) {
    switch(level) {
      case WorkoutLevel.basic:
        return 'Cơ bản';
      case WorkoutLevel.intermediate:
        return 'Trung bình';
      case WorkoutLevel.advanced:
        return 'Nâng cao';
      default:
        return 'Không xác định';
    }
  }
  
  // Các tùy chọn mẫu để hiển thị trong giao diện người dùng
  static List<String> getLevelOptions() {
    return ['Cơ bản', 'Trung bình', 'Nâng cao'];
  }
  
  static List<int> getDaysPerWeekOptions() {
    return [2, 3, 4, 5, 6, 7];
  }
  
  // Lấy danh sách các bài tập theo mức độ
  List<Exercise> getExercisesByLevel(WorkoutLevel level) {
    return _filterExercisesByLevel(level);
  }
}

// Ví dụ sử dụng:
void main() {
  WorkoutModel workoutModel = WorkoutModel();
  
  // Tạo chương trình tập luyện cơ bản 3 ngày một tuần
  WorkoutProgram program = workoutModel.createWorkoutProgram(WorkoutLevel.basic, 3);
  
  print('Chương trình: ${program.name}');
  print('Số ngày: ${program.daysPerWeek}');
  print('Cấp độ: ${WorkoutModel.levelToString(program.level)}');
  
  for (var day in program.workoutDays) {
    print('\n${day.dayName}');
    print('Thời gian tập: ${day.totalDurationInMinutes} phút');
    print('Bài tập:');
    
    for (var exercise in day.exercises) {
      print('- ${exercise.name} (${exercise.durationInSeconds} giây)');
    }
  }
}