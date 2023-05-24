import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mars_model.dart';
import '../services/nasa_service.dart';

final sliderScalarProvider = StateProvider<double>((ref) => 1.0);

final apodDetailIndexProvider = StateProvider<int>((ref) => 0);

final apodResult = FutureProvider<MarsModel>(
  (ref) async {
    try {
      // Call your service to fetch the ResultNasaModel object
      return await ResultNasaService.getMyResultOfNasaService();
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Error fetching Apods: $e');
      }
      // Return a default value or throw an error
      rethrow;
    }
  },
);
