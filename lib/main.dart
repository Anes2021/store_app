import 'package:balagh/screens/home_screen.dart';
import 'package:balagh/src/core/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // setUp();
  runApp(const Distributor());
}

class Distributor extends StatefulWidget {
  const Distributor({super.key});

  @override
  State<Distributor> createState() => _DistributorState();
}

class _DistributorState extends State<Distributor> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Set a fixed design size here
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            bodyLarge: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            //! this will change to black in light mode
            bodyMedium: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundColorGrey02,
              ),
            ),
            labelMedium: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            bodySmall: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: AppColors.backgroundColorGrey01,
                fontSize: 12.sp,
              ),
            ),
            displaySmall: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: AppColors.backgroundColorGrey02,
                fontSize: 10.sp,
              ),
            ),

            //! this is for item shop
            titleLarge: GoogleFonts.aBeeZee(
              textStyle:
                  TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            titleMedium: GoogleFonts.aBeeZee(
              textStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            titleSmall: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ),
          scaffoldBackgroundColor: AppColors.backgroundColorOne,
          primarySwatch: Colors.orange,
          fontFamily: 'Roboto',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
