class PostModel
{
  String? name;
  String? uId;
  String? profileImage;
  String? postText;
  String? postImage;
  String? dateTime;


  PostModel({
    required this.name,
    required this.uId,
    required this.profileImage,
    required this.postImage,
    required this.postText,
    required this.dateTime,
  });
  PostModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    postImage = json['postImage'];
    postText = json['postText'];
    dateTime = json['dateTime'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'name': name,
      'uId':uId,
      'profileImage':profileImage,
      'postImage':postImage,
      'postText':postText,
      'dateTime':dateTime,

    };
  }
}