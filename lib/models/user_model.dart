class UserModel
{
  late String uId;
  late String email;
  late String name;
  late String phone;
  late String bio;
  late String image;
  late String cover;
  late bool isEmailVerified;

  UserModel({
    required this.uId,
    required this.email,
    required this.name,
    required this.phone,
    required this.bio,
    required this.image,
    required this.cover,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    uId = json['uId '];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image '];
    cover = json['cover '];
    bio = json['bio '];
    isEmailVerified = json['isEmailVerified '];
  }

  Map<String, dynamic> toMap ()
  {
    return {
      'uId' : uId,
      'email' : email,
      'name' : name,
      'phone' : phone,
      'image' : image,
      'cover' : cover,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
    };
  }

}