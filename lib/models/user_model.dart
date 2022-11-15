class UserModel
{
  late String uId;
  late String id;
  late String area;
  late String email;
  late String name;
  late String phone;
  late String image;
  late String cover;
  late bool isEmailVerified;

  UserModel({
    required this.uId,
    required this.id,
    required this.area,
    required this.email,
    required this.name,
    required this.phone,
    required this.image,
    required this.cover,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    uId = json['uId '];
    id = json['id '];
    area = json['area '];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image '];
    cover = json['cover '];
    isEmailVerified = json['isEmailVerified '];
  }

  Map<String, dynamic> toMap ()
  {
    return {
      'uId' : uId,
      'id' : id,
      'area' : area,
      'email' : email,
      'name' : name,
      'phone' : phone,
      'image' : image,
      'cover' : cover,
      'isEmailVerified' : isEmailVerified,
    };
  }

}