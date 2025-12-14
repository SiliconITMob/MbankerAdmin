/// Header : {"RC":"0","TokenNo":"99620"}
/// Receipt : [{"AcType":"SB","Allow":"N","MaxAmount":0},{"AcType":"DD","Allow":"N","MaxAmount":0},{"AcType":"RD","Allow":"N","MaxAmount":0},{"AcType":"LOANS","Allow":"N","MaxAmount":0},{"AcType":"GROUP","Allow":"N","MaxAmount":0}]
/// Payment : [{"AcType":"SB","Allow":"N","MaxAmount":0},{"AcType":"DD","Allow":"N","MaxAmount":0}]
/// Opening : [{"AcType":"SB with New Customer","Allow":"N"},{"AcType":"SB with Existing Customer","Allow":"N"},{"AcType":"DD with New Customer","Allow":"N"},{"AcType":"DD with Existing Customer","Allow":"N"},{"AcType":"Deposit Loan","Allow":"N"},{"AcType":"New Customer (CIF)","Allow":"N"}]
/// PassbookOTP : [{"AcType":"SB","OTP":"N"},{"AcType":"DD","OTP":"N"},{"AcType":"RD","OTP":"N"},{"AcType":"LOANS","OTP":"N"},{"AcType":"GROUP","OTP":"N"}]

class PermissionResponse {
  PermissionResponse({
      Header? header, 
      List<Receipt>? receipt, 
      List<Payment>? payment, 
      List<Opening>? opening, 
      List<PassbookOtp>? passbookOTP,}){
    _header = header;
    _receipt = receipt;
    _payment = payment;
    _opening = opening;
    _passbookOTP = passbookOTP;
}

  PermissionResponse.fromJson(dynamic json) {
    _header = json['Header'] != null ? Header.fromJson(json['Header']) : null;
    if (json['Receipt'] != null) {
      _receipt = [];
      json['Receipt'].forEach((v) {
        _receipt?.add(Receipt.fromJson(v));
      });
    }
    if (json['Payment'] != null) {
      _payment = [];
      json['Payment'].forEach((v) {
        _payment?.add(Payment.fromJson(v));
      });
    }
    if (json['Opening'] != null) {
      _opening = [];
      json['Opening'].forEach((v) {
        _opening?.add(Opening.fromJson(v));
      });
    }
    if (json['PassbookOTP'] != null) {
      _passbookOTP = [];
      json['PassbookOTP'].forEach((v) {
        _passbookOTP?.add(PassbookOtp.fromJson(v));
      });
    }
  }
  Header? _header;
  List<Receipt>? _receipt;
  List<Payment>? _payment;
  List<Opening>? _opening;
  List<PassbookOtp>? _passbookOTP;
PermissionResponse copyWith({  Header? header,
  List<Receipt>? receipt,
  List<Payment>? payment,
  List<Opening>? opening,
  List<PassbookOtp>? passbookOTP,
}) => PermissionResponse(  header: header ?? _header,
  receipt: receipt ?? _receipt,
  payment: payment ?? _payment,
  opening: opening ?? _opening,
  passbookOTP: passbookOTP ?? _passbookOTP,
);
  Header? get header => _header;
  List<Receipt>? get receipt => _receipt;
  List<Payment>? get payment => _payment;
  List<Opening>? get opening => _opening;
  List<PassbookOtp>? get passbookOTP => _passbookOTP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_header != null) {
      map['Header'] = _header?.toJson();
    }
    if (_receipt != null) {
      map['Receipt'] = _receipt?.map((v) => v.toJson()).toList();
    }
    if (_payment != null) {
      map['Payment'] = _payment?.map((v) => v.toJson()).toList();
    }
    if (_opening != null) {
      map['Opening'] = _opening?.map((v) => v.toJson()).toList();
    }
    if (_passbookOTP != null) {
      map['PassbookOTP'] = _passbookOTP?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// AcType : "SB"
/// OTP : "N"

class PassbookOtp {
  PassbookOtp({
      String? acType, 
      String? otp,}){
    _acType = acType;
    _otp = otp;
}

  PassbookOtp.fromJson(dynamic json) {
    _acType = json['AcType'];
    _otp = json['OTP'];
  }
  String? _acType;
  String? _otp;
PassbookOtp copyWith({  String? acType,
  String? otp,
}) => PassbookOtp(  acType: acType ?? _acType,
  otp: otp ?? _otp,
);
  String? get acType => _acType;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AcType'] = _acType;
    map['OTP'] = _otp;
    return map;
  }

}

/// AcType : "SB with New Customer"
/// Allow : "N"

class Opening {
  Opening({
      String? acType, 
      String? allow,}){
    _acType = acType;
    _allow = allow;
}

  Opening.fromJson(dynamic json) {
    _acType = json['AcType'];
    _allow = json['Allow'];
  }
  String? _acType;
  String? _allow;
Opening copyWith({  String? acType,
  String? allow,
}) => Opening(  acType: acType ?? _acType,
  allow: allow ?? _allow,
);
  String? get acType => _acType;
  String? get allow => _allow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AcType'] = _acType;
    map['Allow'] = _allow;
    return map;
  }

}

/// AcType : "SB"
/// Allow : "N"
/// MaxAmount : 0

class Payment {
  Payment({
      String? acType, 
      String? allow, 
      num? maxAmount,}){
    _acType = acType;
    _allow = allow;
    _maxAmount = maxAmount;
}

  Payment.fromJson(dynamic json) {
    _acType = json['AcType'];
    _allow = json['Allow'];
    _maxAmount = json['MaxAmount'];
  }
  String? _acType;
  String? _allow;
  num? _maxAmount;
Payment copyWith({  String? acType,
  String? allow,
  num? maxAmount,
}) => Payment(  acType: acType ?? _acType,
  allow: allow ?? _allow,
  maxAmount: maxAmount ?? _maxAmount,
);
  String? get acType => _acType;
  String? get allow => _allow;
  num? get maxAmount => _maxAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AcType'] = _acType;
    map['Allow'] = _allow;
    map['MaxAmount'] = _maxAmount;
    return map;
  }

}

/// AcType : "SB"
/// Allow : "N"
/// MaxAmount : 0

class Receipt {
  Receipt({
      String? acType, 
      String? allow, 
      num? maxAmount,}){
    _acType = acType;
    _allow = allow;
    _maxAmount = maxAmount;
}

  Receipt.fromJson(dynamic json) {
    _acType = json['AcType'];
    _allow = json['Allow'];
    _maxAmount = json['MaxAmount'];
  }
  String? _acType;
  String? _allow;
  num? _maxAmount;
Receipt copyWith({  String? acType,
  String? allow,
  num? maxAmount,
}) => Receipt(  acType: acType ?? _acType,
  allow: allow ?? _allow,
  maxAmount: maxAmount ?? _maxAmount,
);
  String? get acType => _acType;
  String? get allow => _allow;
  num? get maxAmount => _maxAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AcType'] = _acType;
    map['Allow'] = _allow;
    map['MaxAmount'] = _maxAmount;
    return map;
  }

}

/// RC : "0"
/// TokenNo : "99620"

class Header {
  Header({
      String? rc, 
      String? tokenNo,}){
    _rc = rc;
    _tokenNo = tokenNo;
}

  Header.fromJson(dynamic json) {
    _rc = json['RC'];
    _tokenNo = json['TokenNo'];
  }
  String? _rc;
  String? _tokenNo;
Header copyWith({  String? rc,
  String? tokenNo,
}) => Header(  rc: rc ?? _rc,
  tokenNo: tokenNo ?? _tokenNo,
);
  String? get rc => _rc;
  String? get tokenNo => _tokenNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RC'] = _rc;
    map['TokenNo'] = _tokenNo;
    return map;
  }

}