import 'package:flutter/foundation.dart';

class ProfileModel {
  ProfileModel({
    @required this.userId,
    @required this.emailId,
    @required this.subscribed,
  });
  final String userId;
  final String emailId;
  final bool subscribed;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'emailId': emailId,
      'subscribed': subscribed,
    };
  }
}
