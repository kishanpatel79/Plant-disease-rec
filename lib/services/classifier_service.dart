import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'disease_database.dart';

class ClassifierService {
  static const String LABELS_PATH = 'assets/labels.txt';
  
  List<String> _labels = [];
  bool _isModelLoaded = false;
  
  // Initialize singleton
  static final ClassifierService _instance = ClassifierService._internal();
  
  factory ClassifierService() {
    return _instance;
  }
  
  ClassifierService._internal();
  
  Future<void> _loadLabels() async {
    try {
      if (_isModelLoaded) return;

      try {
        final labelsData = await rootBundle.loadString(LABELS_PATH);
        _labels = labelsData.split('\n');
      } catch (e) {
        print('Error loading labels: $e');
        // Load default set of labels if file isn't available
        _labels = await DiseaseDatabase().getAvailableDiseases();
      }
      
      _isModelLoaded = true;
    } catch (e) {
      print('Error in model initialization: $e');
      _labels = await DiseaseDatabase().getAvailableDiseases();
      _isModelLoaded = true;
    }
  }
  
  Future<String> classifyImage(String imagePath) async {
    // Load labels if not already loaded
    if (!_isModelLoaded) {
      await _loadLabels();
    }
    
    // Simulate processing time
    await Future.delayed(const Duration(seconds: 2));
    
    // For web and development, use mock prediction
    return _getMockPrediction();
  }
  
  // For development/testing and web platform
  String _getMockPrediction() {
    final diseaseNames = [
      'Tomato Late Blight',
      'Apple Black Rot',
      'Grape Black Rot',
      'Tomato Early Blight',
      'Apple Scab',
      'Strawberry Leaf Scorch',
      'Corn Common Rust',
      'Peach Bacterial Spot',
      'Potato Late Blight',
      'Tomato Mosaic Virus',
    ];
    
    return diseaseNames[Random().nextInt(diseaseNames.length)];
  }
}
