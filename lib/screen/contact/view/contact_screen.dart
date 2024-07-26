import 'package:crud_app/screen/home/controller/home_controller.dart';
import 'package:crud_app/util/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getFormData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => controller.formList.value!.isEmpty
            ? const Center(
                child: Text("No contact"),
              )
            : ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: controller.formList.value!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () async {
                      await DbHelper.dbHelper.deleteFormData(id: controller.formList.value![index].id!);
                      controller.getFormData();
                    },
                    onTap: () {
                      Get.toNamed("/" ,arguments: controller.formList.value![index]);
                    },
                    title: Text(
                      "${controller.formList.value![index].name}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle:
                        Text("${controller.formList.value![index].number}"),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/');
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
