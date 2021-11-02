class JoinCallRequest {
  late int healthCheckId;
  late int email;
  late int displayName;
  late String isInvited;

  JoinCallRequest({
    required this.healthCheckId,
    required this.email,
    required this.displayName,
    required this.isInvited,
  });

  JoinCallRequest.fromJson(Map<String, dynamic> json) {
    healthCheckId = json['healthCheckId'];
    email = json['email'];
    displayName = json['displayName'];
    isInvited = json['isInvited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['healthCheckId'] = this.healthCheckId;
    data['email'] = this.email;
    data['displayName'] = this.displayName;
    data['isInvited'] = this.isInvited;
    return data;
  }
}

class JoinCallResponse {
  late int uid;
  late String token;
  late int slot;

  JoinCallResponse({
    required this.uid,
    required this.token,
    required this.slot,
  });

  JoinCallResponse.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    token = json['token'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['slot'] = this.slot;
    return data;
  }
}
