import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'core/helpers/cache_helper.dart';
import 'core/helpers/helper_methods.dart';
import 'nourish_me.dart';

import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await Future.wait<void>([
    ScreenUtil.ensureScreenSize(),
    CacheHelper().init(),
    GoogleFonts.pendingFonts([
      GoogleFonts.cairo(),
    ]),
  ]);

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
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(const NourishMe());
}
