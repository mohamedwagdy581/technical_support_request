class UserModel
{
  late String uId;
  late String id;
  late String email;
  late String name;
  late String phone;
  late String bio;
  late String image;
  late String cover;
  late bool isEmailVerified;

  UserModel({
    required this.uId,
    required this.id,
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
    id = json['id '];
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
      'id' : id,
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