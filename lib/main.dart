import 'package:balagh/screens/home_screen.dart';
import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/core/app_extension.dart';
import 'package:balagh/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUp();
  runApp(const Distributor());
}

class Distributor extends StatelessWidget {
  const Distributor({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(context.width, context.height),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
              bodyMedium: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backgroundColorGrey02,
                ),
              ),
              bodySmall: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: AppColors.backgroundColorGrey01,
                  fontSize: 13,
                ),
              )),
          scaffoldBackgroundColor: AppColors.backgroundColorOne,
          primarySwatch: Colors.orange,
          fontFamily: 'Roboto',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
