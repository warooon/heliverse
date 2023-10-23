import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  final users = <User>[].obs;
  final selectedFilters = <String, dynamic>{
    'domain': null,
    'gender': null,
    'available': null,
  }.obs;
  final teamMembers = <User>[].obs;

  List<User> originalUsers = []; // Store the original list of users

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    final jsonString = await DefaultAssetBundle.of(Get.context!)
        .loadString('assets/heliverse_mock_data.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final List<User> userList =
        jsonList.map((json) => User.fromJson(json)).toList();
    users.assignAll(userList);
    originalUsers = List.from(userList); // Store the original list
  }

  void filterByName(String name) {
    final availableFilter = selectedFilters['available'] ?? 'All';

    if (name.isEmpty) {
      // If the search field is empty, restore the original "All" state
      users.assignAll(originalUsers);
      return;
    }

    final filteredUsers = originalUsers.where((user) {
      final domainFilter = selectedFilters['domain'];
      final genderFilter = selectedFilters['gender'];
      final userName = '${user.firstName} ${user.lastName}';

      final domainPass = domainFilter == null ||
          domainFilter == 'All' ||
          domainFilter == user.domain;
      final genderPass = genderFilter == null ||
          genderFilter == 'All' ||
          genderFilter == user.gender;
      final namePass = userName.toLowerCase().contains(name.toLowerCase());

      return domainPass &&
          genderPass &&
          namePass &&
          checkAvailability(user, availableFilter);
    }).toList();

    users.assignAll(filteredUsers);
  }

  void applyFilters() {
    final domainFilter = selectedFilters['domain'] ?? 'All';
    final genderFilter = selectedFilters['gender'] ?? 'All';
    final availableFilter = selectedFilters['available'] ?? 'All';

    final filteredUsers = originalUsers.where((user) {
      final domainPass = domainFilter == 'All' || domainFilter == user.domain;
      final genderPass = genderFilter == 'All' || genderFilter == user.gender;
      final availabilityPass = checkAvailability(user, availableFilter);

      return domainPass && genderPass && availabilityPass;
    }).toList();

    users.assignAll(filteredUsers);
  }

  bool checkAvailability(User user, String availableFilter) {
    if (availableFilter == 'All') {
      return true;
    } else if (availableFilter == 'Available') {
      return user.available == true;
    } else if (availableFilter == 'Unavailable') {
      return user.available == false;
    }
    return false;
  }

  void addToTeam(User user) {
    if (user.available && !teamMembers.contains(user)) {
      teamMembers.add(user);
    }
  }

  void removeFromTeam(User user) {
    teamMembers.remove(user);
    teamMembers.refresh();
  }
}
