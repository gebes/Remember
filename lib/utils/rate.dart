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

    rateMyApp.init().then((value) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          title: AppLocalizations.of(context).translate('rate.title'),
          message: AppLocalizations.of(context).translate('rate.message'),
          rateButton: AppLocalizations.of(context).translate('rate.rateButton'),
          noButton: AppLocalizations.of(context).translate('rate.noButton'),
          laterButton: AppLocalizations.of(context).translate('rate.laterButton'),
          listener: (button) {
            // The button click listener (useful if you want to cancel the click event).
            switch (button) {
              case RateMyAppDialogButton.rate:
                print('Clicked on "Rate".');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },
          ignoreIOS: false, // Set to false if you want to show the Apple's native app rating dialog on iOS.
          dialogStyle: DialogStyle(), // Custom dialog styles.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
        );
      }
    });
  }
}
