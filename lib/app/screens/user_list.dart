import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heliverse/app/screens/team_view.dart';
import 'package:heliverse/app/utils/snackbar.dart';
import '../controllers/user_controller.dart';
import '../widgets/user_card.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find<UserController>();
    final searchController = TextEditingController();

    final searchField = TextField(
      controller: searchController,
      decoration: const InputDecoration(
        labelText: 'Search by Name',
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        controller.filterByName(value);
      },
    );

    final clearButton = IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        searchController.clear();
        controller.filterByName('');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: searchField,
                ),
                clearButton,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter by Domain:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  final selectedDomain = controller.selectedFilters['domain'];
                  return DropdownButton<String>(
                    hint: const Text('Select Domain'),
                    value: selectedDomain,
                    onChanged: (value) {
                      controller.selectedFilters['domain'] = value;
                      controller.applyFilters();
                    },
                    items: [
                      'All',
                      'Sales',
                      'Finance',
                      'Marketing',
                      'IT',
                      'Management',
                    ].map((domain) {
                      return DropdownMenuItem<String>(
                        value: domain,
                        child: Text(domain),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter by Gender:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  final selectedGender = controller.selectedFilters['gender'];
                  return DropdownButton<String>(
                    hint: const Text('Select Gender'),
                    value: selectedGender,
                    onChanged: (value) {
                      controller.selectedFilters['gender'] = value;
                      controller.applyFilters();
                    },
                    items: [
                      'All',
                      'Male',
                      'Female',
                    ].map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter by Availability:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  final selectedAvailability =
                      controller.selectedFilters['available'];
                  return DropdownButton<String>(
                    hint: const Text('Select Availability'),
                    value: selectedAvailability,
                    onChanged: (value) {
                      controller.selectedFilters['available'] = value;
                      controller.applyFilters();
                    },
                    items: [
                      'All',
                      'Available',
                      'Unavailable',
                    ].map((availability) {
                      return DropdownMenuItem<String>(
                        value: availability,
                        child: Text(availability),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const TeamDetailsScreen());
            },
            child: const Text('View Team Details'),
          ),
          Expanded(
            child: Obx(() {
              final users = controller.users;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Column(
                    children: [
                      UserCard(user: user),
                      if (user.available)
                        ElevatedButton(
                          onPressed: () {
                            controller.addToTeam(user);
                            showAddSnackbar();
                          },
                          child: const Text('Add To Team'),
                        ),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
