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
  await Future.wait<void>([
    ScreenUtil.ensureScreenSize(),
    CacheHelper().init(),
    GoogleFonts.pendingFonts([
      GoogleFonts.cairo(),
    ]),
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
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

  runApp(const NourishMe());
}
