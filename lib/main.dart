import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nourish_me/core/helpers/helper_methods.dart';
import 'core/helpers/cache_helper.dart';

import 'nourish_me.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  await GoogleFonts.pendingFonts([
    GoogleFonts.cairo(),
  ]);
  await CacheHelper().init();
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
   HelperMethods.svgPrecacheImage();

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
