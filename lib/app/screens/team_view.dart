import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../utils/snackbar.dart';
import '../widgets/user_card.dart';

class TeamDetailsScreen extends StatelessWidget {
  const TeamDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find<UserController>();
    final teamMembers = controller.teamMembers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Details'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            final user = teamMembers[index];
            return Column(
              children: [
                UserCard(user: user),
                ElevatedButton(
                  onPressed: () {
                    controller.removeFromTeam(user);
                    showRemoveSnackbar();
                  },
                  child: const Text('Remove From Team'),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
