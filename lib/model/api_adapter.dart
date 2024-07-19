import 'dart:convert';
import 'model_delta.dart';

List<Del> parseDels(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Del>((json) => Del.fromJson(json)).toList();
}