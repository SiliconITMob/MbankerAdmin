class TokenResponse {
  TokenResponse({this.rc, this.tokenNo});

  TokenResponse.fromJson(dynamic json) {
    rc = json['RC'];
    tokenNo = json['TokenNo'];
  }

  String? rc;
  String? tokenNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RC'] = rc;
    map['TokenNo'] = tokenNo;
    return map;
  }
}
