import 'package:flutter/material.dart';

import '../utlis/secured_storage.dart';

class SecuredProvider extends ChangeNotifier {

  Future<void> initialize() async {
    await SecuredStorage.initialize();
    notifyListeners();
  }

  bool isEmpty() {
    return SecuredStorage.isEmpty();
  }

  String getPass() {
    return SecuredStorage.getPass();
  }

  String getUser() {
    return SecuredStorage.getUser();
  }

  Future<void> setSession(String username, String password) async {
    await SecuredStorage.setSession(username, password);
    notifyListeners();
  }

  Future<void> changePassword(String password) async {
    await SecuredStorage.changePassword(password);
    notifyListeners();
  }

  Future<void> removeSession() async {
    await SecuredStorage.removeSession();
    notifyListeners();
  }

  Future<void> checkExpiry() async {
    await SecuredStorage.checkExpiry();
    notifyListeners();
  }
}

