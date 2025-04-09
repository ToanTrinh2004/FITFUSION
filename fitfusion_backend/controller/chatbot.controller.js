const chatbotService = require('../services/chatbot.service');

/**
 * Controller xử lý yêu cầu tạo kế hoạch bữa ăn
 * @param {Request} req - Request từ client
 * @param {Response} res - Response gửi về client
 */
exports.generateMealPlan = async (req, res) => {
  try {
    const { bmiStatus,foodAllergy,foodFavour  } = req.body;

    if (!bmiStatus || !foodAllergy || !foodFavour) {
      return res.status(400).json({ error: 'Input is required' });
    }

    const mealPlan = await chatbotService.MealsGenerate(bmiStatus,foodAllergy,foodFavour);

    return res.status(200).json({ 
      success: true,
      data: mealPlan 
    });
  } catch (error) {
    console.error('Error generating meal plan:', error);
    return res.status(500).json({ 
      success: false,
      error: 'Failed to generate meal plan' 
    });
  }
};
exports.calculateCalories =  async (req,res)=>{
    try {
        const {food} = req.body;
        if(!food){
            res.status(400).json({ error: 'Input is required' });
        }
        const nutrition = await chatbotService.CaloriesCalculator(food);
        return res.status(200).json({ 
            success: true,
            data: nutrition 
          });
    } catch (error) {
        console.error('Error generating meal plan:', error);
        return res.status(500).json({ 
          success: false,
          error: 'Failed to calculate nutritions' 
        });
    }
}
