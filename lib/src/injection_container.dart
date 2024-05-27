// ignore: depend_on_referenced_packages
import 'package:balagh/src/services/feedback_service.dart.dart';
import 'package:balagh/src/services/firebase_authentication_service.dart';
import 'package:balagh/src/services/firebase_storage_service.dart';
import 'package:balagh/src/services/shared_prefrences_service.dart';
import 'package:balagh/src/utils/image_picker_cropper_helper.dart';
import 'package:balagh/src/utils/toasts.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerSingleton<AuthController>(AuthController());
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  locator.registerSingleton<FirebaseStorageService>(FirebaseStorageService());
  locator.registerSingleton<ToastsHelper>(ToastsHelper());
  locator.registerSingleton<FeedBackController>(FeedBackController());
  // locator.registerSingleton<GeminiController>(GeminiController());
  locator.registerSingleton<SharedPrefrencesController>(
      SharedPrefrencesController());

  locator.registerSingleton<ImagePickerHelper>(ImagePickerHelper());
}

final imagePicker = locator<ImagePickerHelper>();
final auth = locator<AuthController>();
final firestore = locator<FirebaseFirestore>();
final storage = locator<FirebaseStorageService>();
final toast = locator<ToastsHelper>();
final feedBack = locator<FeedBackController>();
// final gemini = locator<GeminiController>();
final prefrences = locator<SharedPrefrencesController>();
