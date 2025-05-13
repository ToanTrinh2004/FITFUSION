require("dotenv").config();
const { GoogleGenerativeAI } = require("@google/generative-ai");

class ChatbotService {
  constructor() {
    this.apiKey = process.env.GEMINI_API_KEY;
    this.genAI = new GoogleGenerativeAI(this.apiKey);

    this.model = this.genAI.getGenerativeModel({
      model: "gemini-2.0-flash",
    });

    this.generationConfig = {
      temperature: 1,
      topP: 0.95,
      topK: 64,
      maxOutputTokens: 65536,
      responseModalities: [],
      responseMimeType: "text/plain",
    };
  }

  /**
   * Hàm tạo prompt dựa trên dữ liệu người dùng
   */
  createMealsPrompt(bmiStatus, foodAllergy, foodFavour) {
    return `Một người có chỉ số BMI là "${bmiStatus}", dị ứng thực phẩm: "${foodAllergy}", món ăn yêu thích: "${foodFavour}". 
  Hãy tạo một kế hoạch bữa ăn hàng ngày (bữa sáng, trưa và tối) cho 1 tuan dưới dạng JSON với cấu trúc sau:
  
  {
    "breakfast": {
      "dishName": "Tên món ăn",
      "ingredients": ["Nguyên liệu 1", "Nguyên liệu 2"],
      "instructions": "Hướng dẫn từng bước",
      "calories": 500,
      "macronutrients": {
        "protein": 30,
        "carbs": 50,
        "fats": 10
      },
      "note": "Lý do tại sao bữa ăn này tốt cho chỉ số BMI này."
    },
    "lunch": { ... },
    "dinner": { ... },
    "nutrition": {
      "calories": ...,
      "protein": ...,
      "carbs": ...,
      "fats": ...
    }
  }  QUAN TRỌNG: Không bao gồm bất kỳ giải thích, tính toán, hoặc văn bản bổ sung nào. Chỉ trả về đối tượng JSON duy nhất.`;
  }
  createCaloriesCalculatorPrompt(food) {
    return `Phân tích dinh dưỡng cho "${food}". 
    
    Chỉ trả về kết quả dưới dạng JSON với định dạng sau, không có bất kỳ văn bản nào trước hoặc sau đoạn JSON:
    {
      "calories": [số],
      "protein": [số],
      "carbs": [số],
      "fats": [số],
      "note": "[phân tích dinh dưỡng và lời khuyên ngắn gọn trong 50 từ]"
    }
    
    QUAN TRỌNG: Không bao gồm bất kỳ giải thích, tính toán, hoặc văn bản bổ sung nào. Chỉ trả về đối tượng JSON duy nhất.`;
  }
  /**
   * Function to process AI response, stripping Markdown and parsing the JSON
   * @param {string} responseText - The raw response from AI
   * @returns {object} - Parsed JSON or error object
   */
  processJsonResponse(responseText) {
    // Xử lý trường hợp AI trả về JSON bọc trong Markdown
    if (responseText.startsWith("```json")) {
      responseText = responseText.replace(/```json|```/g, "").trim();
    }

    // Chuyển đổi thành JSON
    try {
      return JSON.parse(responseText);
    } catch (error) {
      console.error("Invalid JSON response:", responseText);
      return { error: "Invalid JSON format received from AI" };
    }
  }

  /**
   * Generate a meal plan based on BMI, food allergies, and favorite food
   * @param {string} bmiStatus - BMI status (e.g., overweight)
   * @param {string} foodAllergy - Food allergy (e.g., peanut)
   * @param {string} foodFavour - Favorite food (e.g., chicken)
   * @returns {Promise<object>} - Meal plan in JSON format
   */
  async MealsGenerate(bmiStatus, foodAllergy, foodFavour) {
    try {
      const prompt = this.createMealsPrompt(bmiStatus, foodAllergy, foodFavour);
      const result = await this.model.generateContent(prompt);
      let responseText = result.response.text().trim();

      return this.processJsonResponse(responseText);
    } catch (error) {
      console.error("Error in meal plan generation:", error);
      throw error;
    }
  }

  /**
   * Calculate the nutritional information of given food
   * @param {string} food - A list of foods to calculate the nutritional values for
   * @returns {Promise<object>} - Nutritional information in JSON format
   */
  async CaloriesCalculator(food) {
    const prompt = this.createCaloriesCalculatorPrompt(food);
    try {
      const result = await this.model.generateContent(prompt);
      let responseText = result.response.text().trim();

      return this.processJsonResponse(responseText);
    } catch (error) {
      console.error("Error in calorie calculation:", error);
      throw error;
    }
  }
}
module.exports = new ChatbotService();
