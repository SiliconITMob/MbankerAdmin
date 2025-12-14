class RegisterResponse {
  RegisterResponse({
      this.rc, 
      this.cbsurl, 
      this.uname,
      this.bname,
      this.tokenNo,});

  RegisterResponse.fromJson(dynamic json) {
    rc = json['RC'];
    cbsurl = json['CBSURL'];
    bname = json['BNAME'];
    uname = json['UNAME'];
    tokenNo = json['TokenNo'];
  }
  String? rc;
  String? cbsurl;
  String? bname;
  String? uname;
  String? tokenNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RC'] = rc;
    map['CBSURL'] = cbsurl;
    map['BNAME'] = bname;
    map['UNAME'] = uname;
    map['TokenNo'] = tokenNo;
    return map;
  }

}