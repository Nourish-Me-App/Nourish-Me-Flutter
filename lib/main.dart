import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/helpers/cache_helper.dart';
import 'core/helpers/helper_methods.dart';
import 'nourish_me.dart';

bool? showOnBoarding;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper cacheHelper = CacheHelper();
  await Future.wait<void>([
    ScreenUtil.ensureScreenSize(),
    cacheHelper.init(),
    Firebase.initializeApp(),
    GoogleFonts.pendingFonts([
      GoogleFonts.cairo(),
    ]),
  ]);

  GoogleFonts.config.allowRuntimeFetching = false;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  showOnBoarding = CacheHelper().getData(key: 'first_time_run');
  HelperMethods.svgPrecacheImage();
  CacheHelper().saveData(key: 'first_time_run', value: true);
  LicenseRegistry.addLicense(
    () async* {
      final license = await rootBundle.loadString('assets/fonts/cairo/OFL.txt');
      yield LicenseEntryWithLineBreaks(
        ['assets/fonts/cairo'],
        license,
      );
    },
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const NourishMe());
  });
}
