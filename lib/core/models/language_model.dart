import 'package:flutter/material.dart';

class LanguageModel {
  LanguageModel({required this.languageCode, required this.name});
  String languageCode;
  String name;

  String get localeTag {
    return this.languageCode;
  }

  Locale toLocale() {
    return Locale(languageCode);
  }

  static fromJson(Map<String, dynamic> json) {
    return LanguageModel(
        languageCode: json['languageCode'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['languageCode'] = this.languageCode;
    data['name'] = this.name;
    return data;
  }
}
