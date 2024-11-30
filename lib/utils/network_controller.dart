import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum NetworkState { connected, disconnected }

class NetworkController extends GetxController {
  var networkState = NetworkState.connected.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    _subscribeToConnectivityChanges();
  }

  // Check connectivity and verify internet access
  void checkConnectivity() async {
    try {
      var result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.none) {
        debugPrint("Internet is disconnected");
        networkState.value = NetworkState.disconnected;
      } else {
        final hasInternet = await _hasInternetConnection();
        if (hasInternet) {
          debugPrint("Internet is connected");
          networkState.value = NetworkState.connected;
        } else {
          debugPrint("No internet access despite connectivity");
          networkState.value = NetworkState.disconnected;
        }
      }
    } catch (e) {
      debugPrint("Error checking connectivity: $e");
      networkState.value = NetworkState.disconnected;
    }
  }

  // Subscribe to connectivity changes and update network state
  void _subscribeToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        networkState.value = NetworkState.disconnected;
        debugPrint("Internet is disconnected");
      } else {
        final hasInternet = await _hasInternetConnection();
        if (hasInternet) {
          debugPrint("Internet is connected");
          networkState.value = NetworkState.connected;
        } else {
          debugPrint("No internet access despite connectivity");
          networkState.value = NetworkState.disconnected;
        }
      }
    });
  }

  // Utility function to verify internet connection
  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
