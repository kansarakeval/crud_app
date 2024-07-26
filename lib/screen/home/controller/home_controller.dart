import 'package:crud_app/screen/home/model/home_model.dart';
import 'package:crud_app/util/db_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  Rxn<List<HomeModel>> formList = Rxn();

  Future<void> getFormData() async {
    List<HomeModel> l1 = await DbHelper.dbHelper.readFormData();
    formList.value = l1;
  }
}