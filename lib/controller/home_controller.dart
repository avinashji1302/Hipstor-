import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_bloc_project/model/user_model.dart';
import 'package:my_bloc_project/services/api_services.dart';

import 'package:shared_preferences/shared_preferences.dart';


class HomeController extends GetxController {
  final ApiServices  _apiService = ApiServices();
  final RxList<UserModel> users = <UserModel>[].obs;
  final Rx<UserModel?> lastOpenedUser = Rx<UserModel?>(null);

  final RxBool isLoading = false.obs;
  final RxString error = RxString('');
  final ScrollController scrollController = ScrollController();

  int _currentPage = 1;
  bool _hasMore = true;

  @override
  void onInit() {
    super.onInit();
    _loadlastOpenedUser();
    fetchUsers();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    print("Scrollling....");
    print('Scroll Pos: ${scrollController.position.pixels} / ${scrollController.position.maxScrollExtent}');

    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading.value &&
        _hasMore) {
      fetchUsers();

        print("calling ....");
    }
  }

  void fetchUsers() async {
    if (isLoading.value || !_hasMore) return;

    isLoading.value = true;
    error?.value = '';

    try {
      final data = await _apiService.fetchUserDetails(_currentPage, 10);
      if (data.isEmpty) {
        _hasMore = false;
      } else {
        users.addAll(data);
        _currentPage++;

          print("calling ....$_currentPage");
      }
    } catch (e) {
      error?.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }

  void _loadlastOpenedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final lastData = prefs.getString('last_opened_user');
    if (lastData != null) {
      lastOpenedUser.value = UserModel.fromJson(json.decode(lastData));
    }
  }

  void savelastOpenedUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_opened_user', json.encode(user.toJson()));
    lastOpenedUser.value = user;
  }
}
