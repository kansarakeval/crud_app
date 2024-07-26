class HomeModel{
  int? id;
  String? name,email,password,number;

  HomeModel({this.id,this.name, this.email, this.password, this.number});

  factory HomeModel.mapToModel(Map m1){
    return HomeModel(
      id: m1['id'],
      name: m1['name'],
      email: m1['email'],
      number: m1['number'],
      password: m1['password'],
    );
  }
}