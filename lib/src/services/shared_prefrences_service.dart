import 'dart:convert';

import 'package:balagh/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

// todo : you can only have a single account in each device and when deletes the account the boolean get reversed
class SharedPrefrencesController {
  //*Keys:
  static const String _dailyConversationsKey = "dailyConversations";
  static const String _dailyAppointmentsKey = "dailyAppointments";
  static const String _dailyGoalKey = "dailyGoal";

  static const String _overtimeDurationArrayKey = "overtimeDurationArray";
  static const String _overtimeStepsArrayKey = "overtimeStepsArray";

  static const String _totalDurationKey = "totalDuration";
  static const String _totalStepsKey = "totalSteps";

  static const String _currentDailyStepsKey = "currentDailySteps";
  static const String _currentDailyDurationKey = "currentDailyDuration";

  static const String _lastDayLoggedKey = "lastDayLogged";

  static const String _firstDateJoinedKey = "firstDateJoined";

  static const String _userModelKey = "userModel";

  //*---------------------------------------------------------------------------*//

 

  // write userModel
  Future<bool> writeUserModel(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonUserModel = jsonEncode(userModel.toJson());
    return prefs.setString(_userModelKey, jsonUserModel);
  }

  //*---------------------------------------------------------------------------*//

  Future<DateTime> readFirstDateJoined() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_firstDateJoinedKey);
    if (value == null) {
      await prefs.setString(
          _firstDateJoinedKey, DateTime.now().toIso8601String());
      return DateTime.now();
    }

    return DateTime.parse(value);
  }

  //*---------------------------------------------------------------------------*//

  //* read current daily steps
  Future<int> readCurrentDailyDuration() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt(_currentDailyDurationKey) == null) {
      await prefs.setInt(_currentDailyDurationKey, 0);
      return 0;
    } else {
      return prefs.getInt(_currentDailyDurationKey)!;
    }
  }

  //* write current daily Duration
  Future<bool> writeCurrentDailyDuration(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_currentDailyDurationKey, value);
  }

  //*---------------------------------------------------------------------------*//

  //* read current daily steps
  Future<int> readCurrentDailySteps() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(_currentDailyStepsKey) == null) {
      await prefs.setInt(_currentDailyStepsKey, 0);
      return 0;
    } else {
      return prefs.getInt(_currentDailyStepsKey)!;
    }
  }

  //* write current daily steps
  Future<bool> writeCurrentDailySteps(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_currentDailyStepsKey, value);
  }

  //*---------------------------------------------------------------------------*//

  //* read daily conversations
  Future<int> readDailyConversations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // happens one time
    if (prefs.getInt(_dailyConversationsKey) == null) {
      await prefs.setInt(_dailyConversationsKey, 50);
      return 50;
    }
    return prefs.getInt(_dailyConversationsKey)!;
  }

  //* write daily conversations
  Future<bool> writeDailyConversations(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_dailyConversationsKey, value);
  }

  //*---------------------------------------------------------------------------*//

  //* read daily appointments
  Future<int> readDailyAppointments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt(_dailyAppointmentsKey) == null) {
      await prefs.setInt(_dailyAppointmentsKey, 2);
      return 2;
    }

    return prefs.getInt(_dailyAppointmentsKey) ?? 2;
  }

  //* write daily appointments
  Future<bool> writeDailyAppointments(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(_dailyAppointmentsKey, value);
  }

  //*---------------------------------------------------------------------------*//

  //* read daily goal
  Future<int> readDailyGoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt(_dailyGoalKey) == null) {
      await prefs.setInt(_dailyGoalKey, 50);
      return 50;
    }

    return prefs.getInt(_dailyGoalKey)!;
  }

  //* write daily goal
  Future<bool> writeDailyGoal(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_dailyGoalKey, value);
  }

  //*---------------------------------------------------------------------------*//

  //* read overtime steps array
  Future<List<int>> readOvertimeStepsArray() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(
        "Here is my value of readOvertimeStepsArray  ${prefs.getStringList(_overtimeStepsArrayKey)?.map((e) => int.parse(e)).toList()}");

    if (prefs
            .getStringList(_overtimeStepsArrayKey)
            ?.map((e) => int.parse(e))
            .toList() ==
        null) {
      await prefs.setStringList(_overtimeStepsArrayKey, []);

      return [];
    }

    final value = prefs
        .getStringList(_overtimeStepsArrayKey)
        ?.map((e) => int.parse(e))
        .toList();

    return value!;
  }

  //* write overtime steps array
  Future<bool> writeOvertimeStepsArray(List<int> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(
        _overtimeStepsArrayKey, value.map((e) => e.toString()).toList());
  }

  //*---------------------------------------------------------------------------*//

  //* read total steps
  Future<int> readTotalSteps() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt(_totalStepsKey) == null) {
      await prefs.setInt(_totalStepsKey, 0);
      return 0;
    }

    return prefs.getInt(_totalStepsKey)!;
  }

  //* write total steps
  Future<bool> writeTotalSteps(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_totalStepsKey, value);
  }

  //*---------------------------------------------------------------------------*//

  //* read total steps
  Future<int> readTotalDuration() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(_totalDurationKey) == null) {
      await prefs.setInt(_totalDurationKey, 0);
      return 0;
    }

    return prefs.getInt(_totalDurationKey)!;
  }

  //* write total Duration
  Future<bool> writeTotalDuration(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_totalDurationKey, value);
  }

  //*---------------------------------------------------------------------------*//

  //* read last day logged
  Future<DateTime> readLastDayLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(_lastDayLoggedKey) == null) {
      await prefs.setString(
          _lastDayLoggedKey, DateTime.now().toIso8601String());
      return DateTime.now();
    } else {
      return DateTime.parse(prefs.getString(_lastDayLoggedKey)!);
    }
  }

  //* write last day logged
  Future<bool> writeLastDayLogged(DateTime value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_lastDayLoggedKey, value.toIso8601String());
  }

  //*---------------------------------------------------------------------------*//

  //* read overtime duration in minutes list
  Future<List<int>> readOvertimeDurationInMinutesArray() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(
        "Here is my value of overtimeDurationArrayKey  ${prefs.getStringList(_overtimeDurationArrayKey)?.map((e) => int.parse(e)).toList()}");

    final value = prefs
        .getStringList(_overtimeDurationArrayKey)
        ?.map((e) => int.parse(e))
        .toList();

    if (value == null) {
      await prefs.setStringList(_overtimeDurationArrayKey, []);

      return [];
    }

    return value;
  }

  //* write overtime duration in minutes list
  Future<bool> writeOvertimeDurationInMinutesArray(List<int> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setStringList(
        _overtimeDurationArrayKey, value.map((e) => e.toString()).toList());
  }

  //*---------------------------------------------------------------------------*//

  //* clear all
  Future<bool> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
