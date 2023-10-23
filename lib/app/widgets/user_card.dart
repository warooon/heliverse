import 'package:flutter/material.dart';
import '../model/user_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar),
        ),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.email),
        trailing: Text('Domain: ${user.domain}'),
      ),
    );
  }
}
