import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LanguageManager {
  Map<String, dynamic> _knownLanguages = {};

  String _currentLanguage = "en";

  setLanguage(String code) {
    print("Trying to set Language to " + code);
    if (_knownLanguages[code] == null) return;
    _currentLanguage = code;
    print("Set language to $_currentLanguage");
  }

  Future addLanguage({@required String assetPath, @required String code}) async {
    print("Loading language $code from $assetPath");
    String data = await rootBundle.loadString(assetPath);
    _knownLanguages[code] = json.decode(data);
    print(" Loaded language $code from $assetPath");
  }

  dynamic get(dynamic path) {
    if (path is Path) path = path.path;

    assert(path is String);
    assert(_knownLanguages[_currentLanguage] != null);

    return _knownLanguages[_currentLanguage][path] == null ? path : _knownLanguages[_currentLanguage][path];
  }

  LanguageManager() {
    Path.setLanguageManager(this);
  }
}

class Path {
  static LanguageManager languageManager;

  static setLanguageManager(LanguageManager languageManager) {
    assert(languageManager != null);
    Path.languageManager = languageManager;
    print("Set Language Manager of path");
  }

  final String path;

  Path(this.path);

  String get get {
    return languageManager.get(this);
  }
}
