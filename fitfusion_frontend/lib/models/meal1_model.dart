import 'meal_model.dart';

final List<DailyNutrition> mockNutritionData = [
  // Thứ 2
  DailyNutrition(
    breakfast: Meal(
      dishName: 'Yến mạch với chuối',
      ingredients: ['50g yến mạch', '1 quả chuối', '200ml sữa'],
      instructions: 'Nấu yến mạch với sữa, sau đó thêm chuối cắt lát.',
      calories: 320,
      macronutrients: Macronutrients(protein: 10, carbs: 50, fats: 8),
      note: 'Giàu chất xơ và năng lượng đầu ngày.',
    ),
    lunch: Meal(
      dishName: 'Cơm cá hồi áp chảo',
      ingredients: ['100g cá hồi', '150g cơm', '100g rau cải'],
      instructions: 'Áp chảo cá, ăn cùng cơm và rau luộc.',
      calories: 700,
      macronutrients: Macronutrients(protein: 35, carbs: 80, fats: 25),
      note: 'Giàu omega-3 tốt cho tim mạch.',
    ),
    dinner: Meal(
      dishName: 'Canh bí đỏ + ức gà',
      ingredients: ['200g bí đỏ', '100g ức gà', 'hành ngò'],
      instructions: 'Nấu canh bí đỏ với ức gà đã luộc chín.',
      calories: 620,
      macronutrients: Macronutrients(protein: 30, carbs: 90, fats: 10),
      note: 'Thanh đạm, dễ tiêu hóa.',
    ),
    nutritionSummary: Macronutrients(protein: 75, carbs: 220, fats: 43),
    totalCalories: 1640,
  ),

  // Thứ 3
  DailyNutrition(
    breakfast: Meal(
      dishName: 'Bánh mì ốp la',
      ingredients: ['2 quả trứng', '1 ổ bánh mì'],
      instructions: 'Chiên trứng, ăn kèm bánh mì.',
      calories: 360,
      macronutrients: Macronutrients(protein: 16, carbs: 40, fats: 15),
      note: 'Cung cấp năng lượng cơ bản.',
    ),
    lunch: Meal(
      dishName: 'Bún bò',
      ingredients: ['200g bún', '100g thịt bò', 'rau thơm'],
      instructions: 'Nấu nước dùng, thêm thịt bò và rau.',
      calories: 690,
      macronutrients: Macronutrients(protein: 33, carbs: 85, fats: 20),
      note: 'Đậm đà, giàu sắt.',
    ),
    dinner: Meal(
      dishName: 'Trứng hấp + rau luộc',
      ingredients: ['2 quả trứng', '100g rau xanh'],
      instructions: 'Hấp trứng, ăn kèm rau luộc.',
      calories: 580,
      macronutrients: Macronutrients(protein: 25, carbs: 30, fats: 22),
      note: 'Nhẹ bụng buổi tối.',
    ),
    nutritionSummary: Macronutrients(protein: 74, carbs: 225, fats: 57),
    totalCalories: 1630,
  ),

  // Thứ 4
  DailyNutrition(
    breakfast: Meal(
      dishName: 'Smoothie chuối xoài',
      ingredients: ['1 quả chuối', '1/2 quả xoài', '150ml sữa chua'],
      instructions: 'Xay tất cả thành sinh tố.',
      calories: 310,
      macronutrients: Macronutrients(protein: 8, carbs: 45, fats: 10),
      note: 'Giúp mát gan, dễ tiêu.',
    ),
    lunch: Meal(
      dishName: 'Cơm thịt nạc + canh cải',
      ingredients: ['100g thịt nạc', '200g cơm', 'canh cải ngọt'],
      instructions: 'Luộc thịt, nấu canh cải.',
      calories: 720,
      macronutrients: Macronutrients(protein: 36, carbs: 88, fats: 18),
      note: 'Cung cấp protein nạc và rau xanh.',
    ),
    dinner: Meal(
      dishName: 'Salad trứng và khoai tây',
      ingredients: ['2 quả trứng', '1 củ khoai tây', 'xốt mayonnaise ít béo'],
      instructions: 'Luộc và trộn cùng xốt.',
      calories: 600,
      macronutrients: Macronutrients(protein: 25, carbs: 70, fats: 20),
      note: 'No lâu nhưng không quá nặng.',
    ),
    nutritionSummary: Macronutrients(protein: 69, carbs: 203, fats: 48),
    totalCalories: 1630,
  ),

    // Thứ 5
  DailyNutrition(
    breakfast: Meal(
      dishName: 'Cháo yến mạch trứng',
      ingredients: ['40g yến mạch', '1 quả trứng', '200ml nước'],
      instructions: 'Nấu cháo yến mạch, thêm trứng vào khuấy đều.',
      calories: 330,
      macronutrients: Macronutrients(protein: 12, carbs: 40, fats: 10),
      note: 'Bữa sáng nhẹ nhàng, dễ hấp thu.',
    ),
    lunch: Meal(
      dishName: 'Cơm thịt kho trứng',
      ingredients: ['150g cơm', '1 quả trứng kho', '50g thịt heo'],
      instructions: 'Kho thịt và trứng với nước dừa.',
      calories: 750,
      macronutrients: Macronutrients(protein: 32, carbs: 85, fats: 28),
      note: 'Bổ sung năng lượng buổi trưa.',
    ),
    dinner: Meal(
      dishName: 'Bún riêu cua',
      ingredients: ['200g bún', 'cua xay', 'cà chua', 'rau sống'],
      instructions: 'Nấu riêu cua, chan với bún và rau.',
      calories: 610,
      macronutrients: Macronutrients(protein: 28, carbs: 80, fats: 15),
      note: 'Thanh mát, ngon miệng.',
    ),
    nutritionSummary: Macronutrients(protein: 72, carbs: 205, fats: 53),
    totalCalories: 1690,
  ),

  // Thứ 6
  DailyNutrition(
    breakfast: Meal(
      dishName: 'Bánh chuối yến mạch',
      ingredients: ['1 quả chuối', '30g yến mạch', '1 quả trứng'],
      instructions: 'Trộn đều và chiên áp chảo.',
      calories: 340,
      macronutrients: Macronutrients(protein: 10, carbs: 42, fats: 12),
      note: 'Không dùng đường, tốt cho sức khỏe.',
    ),
    lunch: Meal(
      dishName: 'Mì xào rau củ + trứng',
      ingredients: ['100g mì trứng', 'rau củ hỗn hợp', '1 quả trứng'],
      instructions: 'Xào mì cùng rau củ và trứng.',
      calories: 700,
      macronutrients: Macronutrients(protein: 30, carbs: 90, fats: 20),
      note: 'Đầy đủ năng lượng và vitamin.',
    ),
    dinner: Meal(
      dishName: 'Cháo cá lóc',
      ingredients: ['100g cá lóc', '60g gạo tẻ', 'hành ngò'],
      instructions: 'Nấu cháo cùng cá đã luộc tách xương.',
      calories: 620,
      macronutrients: Macronutrients(protein: 28, carbs: 75, fats: 15),
      note: 'Dễ tiêu, tốt cho dạ dày.',
    ),
    nutritionSummary: Macronutrients(protein: 68, carbs: 207, fats: 47),
    totalCalories: 1660,
  ),

  // Thứ 7
  DailyNutrition(
    breakfast: Meal(
      dishName: 'Trứng luộc + bánh mì nguyên cám',
      ingredients: ['2 quả trứng luộc', '1 lát bánh mì nguyên cám'],
      instructions: 'Luộc trứng, ăn kèm bánh mì.',
      calories: 350,
      macronutrients: Macronutrients(protein: 18, carbs: 25, fats: 14),
      note: 'Giàu đạm, ít tinh bột xấu.',
    ),
    lunch: Meal(
      dishName: 'Cơm thịt gà nướng + salad',
      ingredients: ['150g cơm', '100g gà nướng', 'xà lách cà chua dưa leo'],
      instructions: 'Gà nướng sẵn, ăn kèm cơm và salad tươi.',
      calories: 740,
      macronutrients: Macronutrients(protein: 36, carbs: 80, fats: 25),
      note: 'Đủ chất nhưng vẫn lành mạnh.',
    ),
    dinner: Meal(
      dishName: 'Miến gà',
      ingredients: ['100g miến', '100g thịt gà', 'hành rau thơm'],
      instructions: 'Luộc gà, nấu nước dùng chan vào miến.',
      calories: 610,
      macronutrients: Macronutrients(protein: 30, carbs: 80, fats: 12),
      note: 'Bữa tối nhẹ, đủ chất.',
    ),
    nutritionSummary: Macronutrients(protein: 84, carbs: 185, fats: 51),
    totalCalories: 1700,
  ),

  // Chủ Nhật
  DailyNutrition(
    breakfast: Meal(
      dishName: 'Phở bò',
      ingredients: ['200g phở', '100g thịt bò', 'rau thơm, giá'],
      instructions: 'Nấu nước dùng, thêm thịt bò và phở.',
      calories: 400,
      macronutrients: Macronutrients(protein: 20, carbs: 45, fats: 12),
      note: 'Truyền thống, ngon miệng.',
    ),
    lunch: Meal(
      dishName: 'Cơm sườn nướng',
      ingredients: ['150g cơm', '1 miếng sườn nướng', 'dưa leo cà chua'],
      instructions: 'Nướng sườn, ăn kèm cơm và rau củ.',
      calories: 800,
      macronutrients: Macronutrients(protein: 35, carbs: 85, fats: 28),
      note: 'Ngon miệng cho bữa cuối tuần.',
    ),
    dinner: Meal(
      dishName: 'Súp lơ xào tôm + cơm',
      ingredients: ['100g tôm', '100g súp lơ', '100g cơm'],
      instructions: 'Xào tôm với súp lơ, ăn cùng cơm.',
      calories: 540,
      macronutrients: Macronutrients(protein: 28, carbs: 60, fats: 15),
      note: 'Đủ chất, nhẹ nhàng.',
    ),
    nutritionSummary: Macronutrients(protein: 83, carbs: 190, fats: 55),
    totalCalories: 1740,
  ),
];