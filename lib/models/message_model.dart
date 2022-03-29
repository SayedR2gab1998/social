class MessageModel
{
  String? dateTime;
  String? senderId;
  String? receiverId;
  String? messageText;


  MessageModel({
    required this.dateTime,
    required this.senderId,
    required this.receiverId,
    required this.messageText,
  });
  MessageModel.fromJson(Map<String,dynamic>json)
  {
    dateTime = json['dateTime'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    messageText = json['messageText'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'dateTime':dateTime,
      'senderId':senderId,
      'receiverId':receiverId,
      'messageText':messageText,
    };
  }
}