import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/farmer_model.dart';
import '../models/advisory_model.dart';
import '../models/yield_prediction_model.dart';
import '../models/market_price_model.dart';
import '../models/weather_model.dart';

// Service for handling offline data
class OfflineService {
  static const String _offlineDataKey = 'offline_data';
  static const String _lastSyncKey = 'last_sync_time';
  static const String _connectivityKey = 'connectivity_status';

  // Check if device is online
  static Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  // Save data for offline access
  static Future<void> saveOfflineData({
    List<Advisory>? advisories,
    List<YieldPrediction>? yieldPredictions,
    List<MarketPrice>? marketPrices,
    WeatherData? weatherData,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> offlineData = {};

    if (advisories != null) {
      offlineData['advisories'] = advisories.map((a) => a.toJson()).toList();
    }

    if (yieldPredictions != null) {
      offlineData['yieldPredictions'] = yieldPredictions.map((y) => y.toJson()).toList();
    }

    if (marketPrices != null) {
      offlineData['marketPrices'] = marketPrices.map((m) => m.toJson()).toList();
    }

    if (weatherData != null) {
      offlineData['weatherData'] = weatherData.toJson();
    }

    await prefs.setString(_offlineDataKey, jsonEncode(offlineData));
    await prefs.setString(_lastSyncKey, DateTime.now().toIso8601String());
  }

  // Get offline data
  static Future<Map<String, dynamic>> getOfflineData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_offlineDataKey);
    
    if (jsonString != null) {
      final Map<String, dynamic> data = jsonDecode(jsonString);
      
      // Convert back to model objects
      final result = <String, dynamic>{};
      
      if (data.containsKey('advisories')) {
        result['advisories'] = (data['advisories'] as List)
            .map((json) => Advisory.fromJson(json))
            .toList();
      }
      
      if (data.containsKey('yieldPredictions')) {
        result['yieldPredictions'] = (data['yieldPredictions'] as List)
            .map((json) => YieldPrediction.fromJson(json))
            .toList();
      }
      
      if (data.containsKey('marketPrices')) {
        result['marketPrices'] = (data['marketPrices'] as List)
            .map((json) => MarketPrice.fromJson(json))
            .toList();
      }
      
      if (data.containsKey('weatherData')) {
        result['weatherData'] = WeatherData.fromJson(data['weatherData']);
      }
      
      return result;
    }
    
    return {};
  }

  // Get last sync time
  static Future<DateTime?> getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final syncTimeString = prefs.getString(_lastSyncKey);
    
    if (syncTimeString != null) {
      return DateTime.parse(syncTimeString);
    }
    
    return null;
  }

  // Clear offline data
  static Future<void> clearOfflineData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_offlineDataKey);
    await prefs.remove(_lastSyncKey);
  }

  // Check if offline data is fresh (less than 7 days old)
  static Future<bool> isOfflineDataFresh() async {
    final lastSync = await getLastSyncTime();
    
    if (lastSync == null) {
      return false;
    }
    
    final now = DateTime.now();
    final difference = now.difference(lastSync);
    
    return difference.inDays < 7;
  }
}