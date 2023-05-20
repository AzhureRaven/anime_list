import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
  static late FlutterSecureStorage _storage;
  // preference keys
  static const _USER_KEY = 'user';
  static const _PASS_KEY = 'pass';
  static const _EXP_KEY = 'exp';
  // runtime variables
  static String _user = '';
  static String _pass = '';
  static late DateTime _exp;
  // constants
  static const _MILLISECOND = 86400000;
  static const _EXP_LENGTH = 3 * _MILLISECOND; // 3 days

  static Future<void> initialize() async {
    _storage = const FlutterSecureStorage();
    _user = await _storage.read(key: _USER_KEY) ?? '';
    _pass = await _storage.read(key: _PASS_KEY) ?? '';
    _exp = DateTime.fromMillisecondsSinceEpoch(int.parse(await _storage.read(key: _EXP_KEY) ?? '0'));
    checkExpiry();
  }

  static bool isEmpty() {
    return _user == '';
  }

  static String getPass(){
    return _pass;
  }

  static String getUser(){
    return _user;
  }

  static Future<void> setSession(String username, String password) async {
    _user = username;
    _pass = password;
    _exp = DateTime.now().add(Duration(milliseconds: _EXP_LENGTH));

    await _storage.write(key: _USER_KEY, value: _user);
    await _storage.write(key: _PASS_KEY, value: _pass);
    await _storage.write(key: _EXP_KEY, value: _exp.millisecondsSinceEpoch.toString());
  }

  static Future<void> changePassword(String password) async {
    _pass = password;
    await _storage.write(key: _PASS_KEY, value: _pass);
  }

  static Future<void> removeSession() async {
    await _storage.deleteAll();
    _user = '';
    _pass = '';
    _exp = DateTime.fromMillisecondsSinceEpoch(0);
  }

  static Future<void> checkExpiry() async {
    if (DateTime.now().isAfter(_exp)) await removeSession();
  }
}
