import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bloc_project/controller/home_controller.dart';
import 'package:my_bloc_project/view/detail_screen.dart';
import 'package:my_bloc_project/widgets/user_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 118, 134, 217),
          centerTitle: true,
          title: const Text(
            'Employees Directory',
            style: TextStyle(color: Colors.white),
          )),
      body: Obx(() {
        if (controller.error?.value != '') {
          return Center(child: Text(controller.error!.value));
        }

        if (controller.users.isEmpty &&
            controller.lastOpenedUser.value == null) {
          return const Center(child: Text("No users found"));
        }

        final allUsers = [
          if (controller.lastOpenedUser.value != null)
            controller.lastOpenedUser.value!,
          ...controller.users,
        ];

        return ListView.builder(
          controller: controller.scrollController,
          itemCount: allUsers.length + (controller.isLoading.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < allUsers.length) {
              final emp = allUsers[index];
              return UserTile(
                user: emp,
                onTap: () {
                  controller.savelastOpenedUser(emp);
                  Get.to(() => DetailsScreen(user: emp));
                },
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      }),
    );
  }
}
