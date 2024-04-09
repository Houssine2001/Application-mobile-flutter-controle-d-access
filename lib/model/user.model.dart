class User{
  String id;
  String name;
  String time;

  User({this.id='' ,required this.name ,required this.time});

  Map<String, dynamic> toJson(){
    return  {
      'id':id,
      'name':name,
      'time':time
    };
  }
  factory User.fromJson(Map<String, dynamic> json){
    return User(id: json['id'], name: json['name'], time: json['time']);
  }







}