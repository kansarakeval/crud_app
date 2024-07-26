import 'package:crud_app/screen/home/model/home_model.dart';
import 'package:crud_app/util/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeModel? m1 = Get.arguments;
  TextEditingController? txtName ;
  TextEditingController? txtEmail;
  TextEditingController? txtPassword;
  TextEditingController? txtNumber;
  @override
  void initState() {
    super.initState();
    checkField();
  }
  void checkField()
  {
    if(m1==null)
      {
        txtName = TextEditingController();
        txtEmail = TextEditingController();
        txtPassword = TextEditingController();
        txtNumber = TextEditingController();
      }
    else
      {
        txtName = TextEditingController(text: m1!.name);
        txtEmail = TextEditingController(text: m1!.email);
        txtPassword = TextEditingController(text: m1!.password);
        txtNumber = TextEditingController(text: m1!.number);
      }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: txtName,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      hintText: "Enter the Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    controller: txtEmail,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: "Enter the email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: txtPassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      hintText: "Enter the Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    controller: txtNumber,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.call_outlined),
                      hintText: "Enter the Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      HomeModel model = HomeModel(
                        name: txtName!.text,
                        email: txtEmail!.text,
                        password: txtPassword!.text,
                        number: txtNumber!.text,
                      );
                      if(m1==null)
                      {
                        await DbHelper.dbHelper.insertFormData(model);
                      }
                      else
                      {
                        await DbHelper.dbHelper.updateFormData(m1!.id!, model);
                      }
                      Get.offAllNamed('contact');
                    }
                  }, child: const Text("Submit"))
                ],
              ),
            ),
        ),
        ),
    );
  }
}
