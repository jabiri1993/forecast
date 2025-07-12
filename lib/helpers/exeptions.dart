import 'package:flutter/material.dart';

import '../../main.dart';
import '../inject_container.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

///can be used for throwing [NoInternetException]
class NoInternetException implements Exception {
  late String _message;

  NoInternetException([String message = 'NoInternetException Occurred']) {
    if (getIt<GlobalKey<ScaffoldMessengerState>>().currentState != null) {
      getIt<GlobalKey<ScaffoldMessengerState>>().currentState!.showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(message)));
    }
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
