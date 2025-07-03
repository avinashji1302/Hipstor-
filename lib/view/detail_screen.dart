import 'package:flutter/material.dart';
import 'package:my_bloc_project/model/user_model.dart';
import 'package:my_bloc_project/widgets/user_details_tile.dart';

class DetailsScreen extends StatelessWidget {
  final UserModel user;

  const DetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 118, 134, 217),
        centerTitle: true,
        title: const Text(
          'Employee Detail',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photo),
                radius: isSmallScreen ? 40 : 50,
              ),
              const SizedBox(height: 16),
              Text(
                "This is ${user.name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserDetailsTile(title: 'Company', value: user.company),
                    UserDetailsTile(title: 'Email', value: user.email),
                    UserDetailsTile(title: 'Phone', value: user.phone),
                    UserDetailsTile(title: 'Address', value: user.address),
                    UserDetailsTile(title: 'State', value: user.state),
                    UserDetailsTile(title: 'Country', value: user.country),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
