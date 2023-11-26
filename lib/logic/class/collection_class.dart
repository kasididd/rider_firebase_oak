class RiderModel {
  final String id;
  late String name;
  late int age;
  late int riderClass;
  late DateTime? modifyOn;
  final DateTime timeCreate;
  RiderModel({this.id = "", required this.name, required this.age, required this.riderClass, this.modifyOn, required this.timeCreate});
  factory RiderModel.fromJson(Map<String, dynamic> map) {
    return RiderModel(id: map['id'], name: map['name'], age: map['age'], riderClass: map['riderClass'], timeCreate: DateTime.now(), modifyOn: DateTime.now());
  }
  Map<String, dynamic> toJson() => {'name': name, 'age': age, 'riderClass': riderClass, 'modifyOn': modifyOn, 'timeCreate': timeCreate};
}
