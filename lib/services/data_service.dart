import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user_model.dart';
import '../models/farmer_model.dart';
import '../models/group_model.dart';
import '../models/agronomist_model.dart';
import '../models/advisory_model.dart';
import '../models/yield_prediction_model.dart';
import '../models/market_price_model.dart';
import '../models/credit_score_model.dart';
import '../models/weather_model.dart';
import '../models/input_order_model.dart';

// Service class for managing local data storage
class DataService {
  static const String _userKey = 'user';
  static const String _farmerKey = 'farmer';
  static const String _groupKey = 'group';
  static const String _agronomistKey = 'agronomist';
  static const String _advisoriesKey = 'advisories';
  static const String _yieldPredictionsKey = 'yield_predictions';
  static const String _marketPricesKey = 'market_prices';
  static const String _creditScoresKey = 'credit_scores';
  static const String _weatherDataKey = 'weather_data';
  static const String _inputOrdersKey = 'input_orders';

  // Save user data
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  // Get user data
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    if (jsonString != null) {
      return User.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // Save farmer data
  static Future<void> saveFarmer(Farmer farmer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_farmerKey, jsonEncode(farmer.toJson()));
  }

  // Get farmer data
  static Future<Farmer?> getFarmer() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_farmerKey);
    if (jsonString != null) {
      return Farmer.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // Save group data
  static Future<void> saveGroup(FarmerGroup? group) async {
    final prefs = await SharedPreferences.getInstance();
    if (group != null) {
      await prefs.setString(_groupKey, jsonEncode(group.toJson()));
    } else {
      await prefs.remove(_groupKey); // Remove if null
    }
  }

  // Get group data
  static Future<FarmerGroup?> getGroup() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_groupKey);
    if (jsonString != null) {
      return FarmerGroup.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // Save agronomist data
  static Future<void> saveAgronomist(Agronomist? agronomist) async {
    final prefs = await SharedPreferences.getInstance();
    if (agronomist != null) {
      await prefs.setString(_agronomistKey, jsonEncode(agronomist.toJson()));
    } else {
      await prefs.remove(_agronomistKey); // Remove if null
    }
  }

  // Get agronomist data
  static Future<Agronomist?> getAgronomist() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_agronomistKey);
    if (jsonString != null) {
      return Agronomist.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // Save advisories
  static Future<void> saveAdvisories(List<Advisory> advisories) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = advisories.map((advisory) => advisory.toJson()).toList();
    await prefs.setString(_advisoriesKey, jsonEncode(jsonList));
  }

  // Get advisories
  static Future<List<Advisory>> getAdvisories() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_advisoriesKey);
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => Advisory.fromJson(json)).toList();
    }
    return [];
  }

  // Save yield predictions
  static Future<void> saveYieldPredictions(List<YieldPrediction> predictions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = predictions.map((prediction) => prediction.toJson()).toList();
    await prefs.setString(_yieldPredictionsKey, jsonEncode(jsonList));
  }

  // Get yield predictions
  static Future<List<YieldPrediction>> getYieldPredictions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_yieldPredictionsKey);
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => YieldPrediction.fromJson(json)).toList();
    }
    return [];
  }

  // Save market prices
  static Future<void> saveMarketPrices(List<MarketPrice> prices) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prices.map((price) => price.toJson()).toList();
    await prefs.setString(_marketPricesKey, jsonEncode(jsonList));
  }

  // Get market prices
  static Future<List<MarketPrice>> getMarketPrices() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_marketPricesKey);
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => MarketPrice.fromJson(json)).toList();
    }
    return [];
  }

  // Save credit scores
  static Future<void> saveCreditScore(CreditScore score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_creditScoresKey, jsonEncode(score.toJson()));
  }

  // Get credit scores
  static Future<CreditScore?> getCreditScore() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_creditScoresKey);
    if (jsonString != null) {
      return CreditScore.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // Save weather data
  static Future<void> saveWeatherData(WeatherData weather) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weatherDataKey, jsonEncode(weather.toJson()));
  }

  // Get weather data
  static Future<WeatherData?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_weatherDataKey);
    if (jsonString != null) {
      return WeatherData.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // Save input orders
  static Future<void> saveInputOrders(List<InputOrder> orders) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = orders.map((order) => order.toJson()).toList();
    await prefs.setString(_inputOrdersKey, jsonEncode(jsonList));
  }

  // Get input orders
  static Future<List<InputOrder>> getInputOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_inputOrdersKey);
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => InputOrder.fromJson(json)).toList();
    }
    return [];
  }

  // Clear all stored data
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}