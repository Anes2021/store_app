// ignore_for_file: use_build_context_synchronously, unused_field

import 'dart:developer';
import 'dart:io';

import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/category_model.dart';
import 'package:balagh/src/presentation/widgets.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  XFile? _image;
  TextEditingController titleController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _uploading = false;
  bool isVerticalVeiw = true;

  // Method to pick image using ImagePicker
  Future<void> _pickImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery); // Pick image
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile; // Assign XFile to _image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // Ensure full height
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(30.h),
                appBar(),
                Gap(20.h),
                imagePickUpContainer(),
                Gap(10.h),
                textFields(),
                Gap(10.h),
                previewCategory(),
                Gap(20.h),
                GestureDetector(
                  onTap: () async {
                    await createCategoryShop();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.backgroundColorGrey01, width: 2)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Center(child: Text("Create Item Shop")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.backgroundColorGrey01,
                width: 1.5.sp,
              ),
              borderRadius: BorderRadius.circular(10.sp),
              color: AppColors.backgroundColorOne,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.orange,
              ),
            ),
          ),
        ),
        Gap(10.w),
        Text(
          "Create Category",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget imagePickUpContainer() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _pickImage();
          },
          child: Container(
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  border: Border.all(
                      color: AppColors.backgroundColorGrey01, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: (_image == null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 40.sp,
                          color: AppColors.backgroundColorGrey02,
                        ),
                        Text(
                          "Add Photo to The Category.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppColors.backgroundColorGrey02,
                                  fontSize: 16),
                        )
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      ))),
        ),
        (_image != null)
            ? GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text((_image == null) ? "" : "Click to change Image")
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget textFields() {
    return Column(
      children: [
        CustomTextField(
          controller: titleController,
          hintText: "put title here",
          function: (String text) {
            setState(() {
              titleController;
            });
          },
        ),
      ],
    );
  }

  Widget previewCategory() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Previews",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gap(5.w),
            Expanded(
              child: Container(
                height: 1.h,
                color: AppColors.backgroundColorGrey02,
              ),
            ),
          ],
        ),
        Gap(10.h),
        Container(
          width: isVerticalVeiw ? MediaQuery.of(context).size.width : 180.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: AppColors.backgroundColorGrey01, width: 1.5),
              color: AppColors.backgroundColorGrey03),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: isVerticalVeiw
                          ? MediaQuery.of(context).size.width
                          : 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.backgroundColorTwo),
                      child: (_image == null)
                          ? const Center(
                              child: Text("no image"),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Container(
                      width: isVerticalVeiw
                          ? MediaQuery.of(context).size.width
                          : 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black.withOpacity(0.4)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (titleController.text.trim().isEmpty)
                                  ? "category name"
                                  : titleController.text,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text("0 item",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isVerticalVeiw = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 1.5),
                            color: (isVerticalVeiw)
                                ? Colors.black.withOpacity(0.4)
                                : Colors.black),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.grid_view_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Gap(10.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isVerticalVeiw = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 1.5),
                            color: isVerticalVeiw
                                ? Colors.black
                                : Colors.black.withOpacity(0.4)),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.view_agenda,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> createCategoryShop() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    String id = const Uuid().v4();

    if (titleController.text.trim().isEmpty) {
      CherryToast.error(
        description: Text(
          "please fill all informations",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp, color: AppColors.backgroundColorGrey03),
        ),
      ).show(context);
      return;
    } else {
      if (_image == null) return; // Check if image is selected

      setState(() {
        _uploading = true; // Set uploading state to true
      });
      String downloadURL;
      // Generate a unique file name using UUID or DateTime
      String fileName = const Uuid().v4(); // Use UUID for unique file names
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');

      // Convert XFile to File and upload
      File fileToUpload = File(_image!.path);

      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(fileToUpload);
      TaskSnapshot snapshot = await uploadTask;
      log(snapshot.toString());

      // Get the download URL of the uploaded file
      downloadURL = await snapshot.ref.getDownloadURL();
      log(downloadURL.toString());
      setState(() {
        downloadURL;
        _uploading = false;
      });
      log("klb0$downloadURL");
      CategoryModel shopItemModel = CategoryModel(
        itemId: id,
        title: titleController.text,
        imageUrl: downloadURL,
      );
      await fireStore
          .collection("categories")
          .doc(id)
          .set(shopItemModel.toJson());
      CherryToast.success(
        description: Text(
          "Category added successfully",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13.sp,
                color: AppColors.backgroundColorGrey03,
              ),
        ),
      ).show(context);
      Navigator.of(context).pop();
    }
  }
}
