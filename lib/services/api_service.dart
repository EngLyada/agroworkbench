// API endpoints as specified in requirements
class ApiEndpoints {
  static const String baseUrl = 'https://api.agroworkbench.com'; // Placeholder
  
  // Authentication endpoints
  static const String authLogin = '/api/auth/login';
  static const String authVerifyOtp = '/api/auth/verify-otp';
  static const String authRegister = '/api/auth/register';
  
  // Farmer endpoints
  static const String farmerProfile = '/api/farmer/profile';
  static const String farmerUpdateProfile = '/api/farmer/profile/update';
  
  // Advisory endpoints
  static const String advisory = '/api/services/advisory';
  static const String advisoryFeedback = '/api/services/advisory/feedback';
  
  // Yield prediction endpoints
  static const String yieldPrediction = '/api/services/yield-prediction';
  static const String yieldPredictionUpdate = '/api/services/yield-prediction/update';
  
  // Market prices endpoints
  static const String marketPrices = '/api/markets/prices';
  static const String marketForecast = '/api/markets/forecast';
  
  // Credit scoring endpoints
  static const String creditScore = '/api/credit/score';
  static const String creditScoreHistory = '/api/credit/history';
  
  // Chat endpoints
  static const String chatMessage = '/api/chat/message';
  
  // Group endpoints
  static const String farmerGroups = '/api/groups';
  static const String groupMembers = '/api/groups/members';
  
  // Agronomist endpoints
  static const String agronomistVisits = '/api/agronomist/visits';
  static const String agronomistFarmers = '/api/agronomist/farmers';
  
  // Weather endpoints
  static const String weatherData = '/api/weather';
  static const String weatherForecast = '/api/weather/forecast';
}

// API service class
class ApiService {
  // This would contain actual API implementation
  // For now, we'll keep it as a placeholder structure
}