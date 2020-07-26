
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'app_localizations.dart';

class RateTheApp {
  static void showDialog(BuildContext context) {
    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'Remember',
      minDays: 0,
      minLaunches: 0,
      remindDays: 2,
      remindLaunches: 1,
      googlePlayIdentifier: 'eu.gebes.remember.Remember',
      appStoreIdentifier: '1513544998',
    );
    
     rateMyApp.
  }
}
