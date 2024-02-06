import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Crew {
  final String? id;
  final String name;
  final String key;
  Crew({
    this.id,
    required this.name,
    required this.key,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'key': key});

    return result;
  }

  factory Crew.fromMap(ParseObject map) {
    return Crew(
      id: map['objectId'],
      name: map['Name'],
      key: map['Key'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Crew.fromJson(ParseObject source) => Crew.fromMap(source);
}
