/// Header : {"RC":"0","TokenNo":"67039","Opening":6700,"TotalReceipt":10000,"TotalPayment":5000,"Closing":11700}
/// Txns : [{"AcNo":"0201119078345","CustomerName":"SHALINI","TxnTime":"24/04/2024 10:30","TxnType":"R","Amount":500},{"AcNo":"0201119078321","CustomerName":"BALAKRISHNAN","TxnTime":"24/04/2024 10:45","TxnType":"R","Amount":1000},{"AcNo":"0201010004572","CustomerName":"VINEETH KUMAR","TxnTime":"24/04/2024 11:20","TxnType":"P","Amount":1200},{"AcNo":"0201119078101","CustomerName":"PRADEEP","TxnTime":"24/04/2024 12:10","TxnType":"R","Amount":200},{"AcNo":"0201119078231","CustomerName":"DINESAN","TxnTime":"24/04/2024 12:50","TxnType":"R","Amount":400}]

class ReportResponse {
  ReportResponse({
      Header? header, 
      List<Txns>? txns,}){
    _header = header;
    _txns = txns;
}

  ReportResponse.fromJson(dynamic json) {
    _header = json['Header'] != null ? Header.fromJson(json['Header']) : null;
    if (json['Txns'] != null) {
      _txns = [];
      json['Txns'].forEach((v) {
        _txns?.add(Txns.fromJson(v));
      });
    }
  }
  Header? _header;
  List<Txns>? _txns;
ReportResponse copyWith({  Header? header,
  List<Txns>? txns,
}) => ReportResponse(  header: header ?? _header,
  txns: txns ?? _txns,
);
  Header? get header => _header;
  List<Txns>? get txns => _txns;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_header != null) {
      map['Header'] = _header?.toJson();
    }
    if (_txns != null) {
      map['Txns'] = _txns?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// AcNo : "0201119078345"
/// CustomerName : "SHALINI"
/// TxnTime : "24/04/2024 10:30"
/// TxnType : "R"
/// Amount : 500

class Txns {
  Txns({
      String? acNo, 
      String? customerName, 
      String? txnTime, 
      String? txnType, 
      num? amount,}){
    _acNo = acNo;
    _customerName = customerName;
    _txnTime = txnTime;
    _txnType = txnType;
    _amount = amount;
}

  Txns.fromJson(dynamic json) {
    _acNo = json['AcNo'];
    _customerName = json['CustomerName'];
    _txnTime = json['TxnTime'];
    _txnType = json['TxnType'];
    _amount = json['Amount'];
  }
  String? _acNo;
  String? _customerName;
  String? _txnTime;
  String? _txnType;
  num? _amount;
Txns copyWith({  String? acNo,
  String? customerName,
  String? txnTime,
  String? txnType,
  num? amount,
}) => Txns(  acNo: acNo ?? _acNo,
  customerName: customerName ?? _customerName,
  txnTime: txnTime ?? _txnTime,
  txnType: txnType ?? _txnType,
  amount: amount ?? _amount,
);
  String? get acNo => _acNo;
  String? get customerName => _customerName;
  String? get txnTime => _txnTime;
  String? get txnType => _txnType;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AcNo'] = _acNo;
    map['CustomerName'] = _customerName;
    map['TxnTime'] = _txnTime;
    map['TxnType'] = _txnType;
    map['Amount'] = _amount;
    return map;
  }

}

/// RC : "0"
/// TokenNo : "67039"
/// Opening : 6700
/// TotalReceipt : 10000
/// TotalPayment : 5000
/// Closing : 11700

class Header {
  Header({
      String? rc, 
      String? tokenNo, 
      num? opening, 
      num? totalReceipt, 
      num? totalPayment, 
      num? closing,}){
    _rc = rc;
    _tokenNo = tokenNo;
    _opening = opening;
    _totalReceipt = totalReceipt;
    _totalPayment = totalPayment;
    _closing = closing;
}

  Header.fromJson(dynamic json) {
    _rc = json['RC'];
    _tokenNo = json['TokenNo'];
    _opening = json['Opening'];
    _totalReceipt = json['TotalReceipt'];
    _totalPayment = json['TotalPayment'];
    _closing = json['Closing'];
  }
  String? _rc;
  String? _tokenNo;
  num? _opening;
  num? _totalReceipt;
  num? _totalPayment;
  num? _closing;
Header copyWith({  String? rc,
  String? tokenNo,
  num? opening,
  num? totalReceipt,
  num? totalPayment,
  num? closing,
}) => Header(  rc: rc ?? _rc,
  tokenNo: tokenNo ?? _tokenNo,
  opening: opening ?? _opening,
  totalReceipt: totalReceipt ?? _totalReceipt,
  totalPayment: totalPayment ?? _totalPayment,
  closing: closing ?? _closing,
);
  String? get rc => _rc;
  String? get tokenNo => _tokenNo;
  num? get opening => _opening;
  num? get totalReceipt => _totalReceipt;
  num? get totalPayment => _totalPayment;
  num? get closing => _closing;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RC'] = _rc;
    map['TokenNo'] = _tokenNo;
    map['Opening'] = _opening;
    map['TotalReceipt'] = _totalReceipt;
    map['TotalPayment'] = _totalPayment;
    map['Closing'] = _closing;
    return map;
  }

}