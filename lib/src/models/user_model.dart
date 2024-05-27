import 'package:flutter/material.dart';

class SocialMediaModel {
  final String id;
  final String facebook;
  final String twitter;
  final String whatsApp;
  final String snapshat;

  SocialMediaModel(
      {required this.id,
      required this.facebook,
      required this.twitter,
      required this.whatsApp,
      required this.snapshat});

  // fromJson
  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      id: json['id'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      whatsApp: json['whatsApp'],
      snapshat: json['snapshat'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'facebook': facebook,
      'twitter': twitter,
      'whatsApp': whatsApp,
      'snapshat': snapshat,
    };
  }
}

class UserModel {
  final String id;
  final DateTime joinedDate;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final String country;
  final bool isAdmin;
  final bool isOwner;
  final bool gender;
  final String isReadNotifications;
  final String phoneNumber;

  UserModel(
      {required this.id,
      required this.gender,
      required this.phoneNumber,
      required this.isReadNotifications,
      required this.joinedDate,
      required this.isAdmin,
      required this.isOwner,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.imageUrl,
      required this.country});

// subcollection socialMedia
// subcollection notifications

  // fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phoneNumber: json["phoneNumber"],
      id: json['id'],
      isReadNotifications: json['isReadNotifications'],
      gender: json['gender'],
      isAdmin: json['isAdmin'],
      isOwner: json['isOwner'],
      joinedDate: DateTime.parse(json['joinedDate']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      country: json['country'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isReadNotifications': isReadNotifications,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
      'isOwner': isOwner,
      'joinedDate': joinedDate.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
      'country': country,
    };
  }
}

class NotificationModel {
  final String id;
  final DateTime sentDate;
  final String title;
  final String message;

  NotificationModel(
      {required this.id,
      required this.title,
      required this.message,
      required this.sentDate});

  // fromJson
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      sentDate: DateTime.parse(json['sentDate']),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'sentDate': sentDate.toIso8601String(),
    };
  }
}

class RequestModel {
  final String id;
  final DateTime sentDate;
  final String userName;
  final String userImageUrl;
  final String userId;
  final String specialistId;
  final String specialistName;
  final String specialistImageUrl;
  final RequestModel status;
  final DateTime schduledDate;
  final TimeOfDay schduledTime;
  final String message;

  RequestModel(
      {required this.id,
      required this.sentDate,
      required this.userName,
      required this.userImageUrl,
      required this.userId,
      required this.specialistId,
      required this.specialistName,
      required this.specialistImageUrl,
      required this.status,
      required this.schduledDate,
      required this.schduledTime,
      required this.message});

  // fromJson
  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      sentDate: DateTime.parse(json['sentDate']),
      userName: json['userName'],
      userImageUrl: json['userImageUrl'],
      userId: json['userId'],
      specialistId: json['specialistId'],
      specialistName: json['specialistName'],
      specialistImageUrl: json['specialistImageUrl'],
      status: json['status'],
      schduledDate: DateTime.parse(json['schduledDate']),
      schduledTime:
          TimeOfDay.fromDateTime(DateTime.parse(json['schduledTime'])),
      message: json['message'],
    );
  }

  // toJson
  Map<String, dynamic> toJson(BuildContext context) {
    return {
      'id': id,
      'sentDate': sentDate.toIso8601String(),
      'userName': userName,
      'userImageUrl': userImageUrl,
      'userId': userId,
      'specialistId': specialistId,
      'specialistName': specialistName,
      'specialistImageUrl': specialistImageUrl,
      'status': status,
      'schduledDate': schduledDate.toIso8601String(),
      'schduledTime': schduledTime.format(context),
      'message': message,
    };
  }
}

enum RequestStatus { pending, accepted, rejected, completed }

// extension for toString & fromString
extension RequestStatusExtension on RequestStatus {
  String get value {
    switch (this) {
      case RequestStatus.pending:
        return 'pending';
      case RequestStatus.accepted:
        return 'accepted';
      case RequestStatus.rejected:
        return 'rejected';
      case RequestStatus.completed:
        return 'completed';
      default:
        return 'pending';
    }
  }
}

// fromString extnesion
extension RequestStatusFromString on String {
  RequestStatus get requestStatus {
    switch (this) {
      case 'pending':
        return RequestStatus.pending;
      case 'accepted':
        return RequestStatus.accepted;
      case 'rejected':
        return RequestStatus.rejected;
      case 'completed':
        return RequestStatus.completed;
      default:
        return RequestStatus.pending;
    }
  }
}

class NoteModel {
  final String id;
  final String title;
  final String content;
  final String specialistId;
  final String specialistName;
  final String specialistImageUrl;
  final DateTime createdDate;

  NoteModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.specialistId,
      required this.specialistName,
      required this.specialistImageUrl,
      required this.createdDate});

  // fromJson
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      specialistId: json['specialistId'],
      specialistName: json['specialistName'],
      specialistImageUrl: json['specialistImageUrl'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'specialistId': specialistId,
      'specialistName': specialistName,
      'specialistImageUrl': specialistImageUrl,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
