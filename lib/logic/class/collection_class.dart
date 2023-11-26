class RiderModel {
  final String id;
  late String name;
  final int age;
  final int riderClass;
  RiderModel({this.id = "", required this.name, required this.age, required this.riderClass});
  factory RiderModel.fromJson(Map<String, dynamic> map) {
    return RiderModel(id: map['id'], name: map['name'], age: map['age'], riderClass: map['riderClass']);
  }
  factory RiderModel.fromJsonNoId(Map<String, dynamic> map) {
    return RiderModel(id: "", name: map['name'], age: map['age'], riderClass: map['riderClass']);
  }
  Map<String, dynamic> toJson() => {'name': name, 'age': age, 'riderClass': riderClass};
}
