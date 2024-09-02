import 'package:balagh/src/core/app_extension.dart';
import 'package:balagh/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      builder: (context, child) => const Scaffold(),
    );
  }
}
