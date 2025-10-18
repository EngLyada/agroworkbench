import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../models/farmer_model.dart';
import '../models/group_model.dart';
import '../models/agronomist_model.dart';
import '../models/advisory_model.dart';
import '../models/yield_prediction_model.dart';
import '../models/market_price_model.dart';
import '../models/credit_score_model.dart';
import '../models/weather_model.dart';
import '../services/data_service.dart';
import '../services/offline_service.dart';

// Main app state provider
class AppState extends ChangeNotifier {
  User? _user;
  Farmer? _farmer;
  FarmerGroup? _group;
  Agronomist? _agronomist;
  List<Advisory> _advisories = [];
  List<YieldPrediction> _yieldPredictions = [];
  List<MarketPrice> _marketPrices = [];
  CreditScore? _creditScore;
  WeatherData? _weatherData;

  // Getters
  User? get user => _user;
  Farmer? get farmer => _farmer;
  FarmerGroup? get group => _group;
  Agronomist? get agronomist => _agronomist;
  List<Advisory> get advisories => _advisories;
  List<YieldPrediction> get yieldPredictions => _yieldPredictions;
  List<MarketPrice> get marketPrices => _marketPrices;
  CreditScore? get creditScore => _creditScore;
  WeatherData? get weatherData => _weatherData;

  bool get isOnline => true; // Simplified for demo
  bool get isOffline => !isOnline;

  // Initialize app state
  Future<void> initialize() async {
    // Load user data
    _user = await DataService.getUser();
    
    // Load role-specific data based on user role
    if (_user != null) {
      switch (_user!.role) {
        case UserRole.farmer:
          _farmer = await DataService.getFarmer();
          break;
        case UserRole.group:
          _group = await DataService.getGroup();
          break;
        case UserRole.agronomist:
          _agronomist = await DataService.getAgronomist();
          break;
      }
    }

    // Load other data
    _advisories = await DataService.getAdvisories();
    _yieldPredictions = await DataService.getYieldPredictions();
    _marketPrices = await DataService.getMarketPrices();
    _creditScore = await DataService.getCreditScore();
    _weatherData = await DataService.getWeatherData();

    notifyListeners();
  }

  // Update user
  Future<void> updateUser(User user) async {
    _user = user;
    await DataService.saveUser(user);
    notifyListeners();
  }

  // Update farmer
  Future<void> updateFarmer(Farmer farmer) async {
    _farmer = farmer;
    await DataService.saveFarmer(farmer);
    notifyListeners();
  }

  // Update group
  Future<void> updateGroup(FarmerGroup? group) async {
    _group = group;
    await DataService.saveGroup(group);
    notifyListeners();
  }

  // Update agronomist
  Future<void> updateAgronomist(Agronomist? agronomist) async {
    _agronomist = agronomist;
    await DataService.saveAgronomist(agronomist);
    notifyListeners();
  }

  // Update advisories
  Future<void> updateAdvisories(List<Advisory> advisories) async {
    _advisories = advisories;
    await DataService.saveAdvisories(advisories);
    
    // Save to offline cache
    await OfflineService.saveOfflineData(advisories: advisories);
    
    notifyListeners();
  }

  // Update yield predictions
  Future<void> updateYieldPredictions(List<YieldPrediction> predictions) async {
    _yieldPredictions = predictions;
    await DataService.saveYieldPredictions(predictions);
    
    // Save to offline cache
    await OfflineService.saveOfflineData(yieldPredictions: predictions);
    
    notifyListeners();
  }

  // Update market prices
  Future<void> updateMarketPrices(List<MarketPrice> prices) async {
    _marketPrices = prices;
    await DataService.saveMarketPrices(prices);
    
    // Save to offline cache
    await OfflineService.saveOfflineData(marketPrices: prices);
    
    notifyListeners();
  }

  // Update credit score
  Future<void> updateCreditScore(CreditScore score) async {
    _creditScore = score;
    await DataService.saveCreditScore(score);
    notifyListeners();
  }

  // Update weather data
  Future<void> updateWeatherData(WeatherData weather) async {
    _weatherData = weather;
    await DataService.saveWeatherData(weather);
    
    // Save to offline cache
    await OfflineService.saveOfflineData(weatherData: weather);
    
    notifyListeners();
  }

  // Load data from offline cache when online
  Future<void> loadOfflineData() async {
    if (await OfflineService.isOfflineDataFresh()) {
      final offlineData = await OfflineService.getOfflineData();
      
      if (offlineData.containsKey('advisories')) {
        _advisories = offlineData['advisories'];
      }
      
      if (offlineData.containsKey('yieldPredictions')) {
        _yieldPredictions = offlineData['yieldPredictions'];
      }
      
      if (offlineData.containsKey('marketPrices')) {
        _marketPrices = offlineData['marketPrices'];
      }
      
      if (offlineData.containsKey('weatherData')) {
        _weatherData = offlineData['weatherData'];
      }
      
      notifyListeners();
    }
  }

  // Clear all data
  Future<void> clearAllData() async {
    _user = null;
    _farmer = null;
    _group = null;
    _agronomist = null;
    _advisories = [];
    _yieldPredictions = [];
    _marketPrices = [];
    _creditScore = null;
    _weatherData = null;
    
    await DataService.clearAllData();
    await OfflineService.clearOfflineData();
    
    notifyListeners();
  }
}