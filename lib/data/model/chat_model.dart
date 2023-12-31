import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String fromUserId;
  final String toUserId;
  final int idDate;
  final String contentMassage;
  const ChatModel({
    required this.contentMassage,
    required this.fromUserId,
    required this.idDate,
    required this.toUserId,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        contentMassage: json['contentMassage'],
        fromUserId: json['fromUserId'],
        idDate: json['idDate'],
        toUserId: json['toUserId'],
      );
  Map<String, dynamic> get toJson => {
        'contentMassage': contentMassage,
        'fromUserId': fromUserId,
        'idDate': idDate,
        'toUserId': toUserId,
      };

  @override
  List<Object?> get props => [contentMassage, fromUserId, idDate, toUserId];
}
