class TestDto{
  int age;
  String name;
  String city;

  TestDto({
    required this.age,
    required this.name,
    required this.city,
  });
  factory TestDto.fromJson(Map<String, dynamic> json) {
    return TestDto(
      age: int.parse(json['age']),
      name: json['name'],
      city: json['city'],
    );
  }

  String toString(){
    return "${this.name} ( ${this.age} )님의 거주지는 ${this.city} 입니다.";
  }
}