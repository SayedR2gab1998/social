class SocialUserModel
{
  String? email;
  String? name;
  String? phone;
  String? uId;
  String? bio;
  String? profileImage;
  String? coverImage;


  SocialUserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.bio,
    required this.coverImage,
    required this.profileImage,
});
  SocialUserModel.fromJson(Map<String,dynamic>json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId':uId,
      'bio':bio,
      'profileImage':profileImage,
      'coverImage':coverImage,
    };
  }
}