/// Header : {"RC":"0","TokenNo":"48916"}
/// Summary : [{"AgentID":"020001","AgentName":"KRISHNA KUMAR","Status":"Y","Collection":3500,"Payment":500,"CashInHand":4500,"LastTxnDate":"10/04/2024"},{"AgentID":"020002","AgentName":"RAJESH","Status":"N","Collection":0,"Payment":0,"CashInHand":0,"LastTxnDate":"01/04/2024"},{"AgentID":"030001","AgentName":"PRAMEELA","Status":"Y","Collection":6500,"Payment":1500,"CashInHand":7500,"LastTxnDate":"24/04/2024"},{"AgentID":"020003","AgentName":"MOHANAN KUTTY","Status":"Y","Collection":5600,"Payment":2300,"CashInHand":4300,"LastTxnDate":"22/04/2024"},{"AgentID":"030002","AgentName":"GOVINDAN","Status":"Y","Collection":12500,"Payment":0,"CashInHand":12500,"LastTxnDate":"23/04/2024"}]

class AgentResponse {
  AgentResponse({
      Header? header, 
      List<Summary>? summary,}){
    _header = header;
    _summary = summary;
}

  AgentResponse.fromJson(dynamic json) {
    _header = json['Header'] != null ? Header.fromJson(json['Header']) : null;
    if (json['Summary'] != null) {
      _summary = [];
      json['Summary'].forEach((v) {
        _summary?.add(Summary.fromJson(v));
      });
    }
  }
  Header? _header;
  List<Summary>? _summary;
AgentResponse copyWith({  Header? header,
  List<Summary>? summary,
}) => AgentResponse(  header: header ?? _header,
  summary: summary ?? _summary,
);
  Header? get header => _header;
  List<Summary>? get summary => _summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_header != null) {
      map['Header'] = _header?.toJson();
    }
    if (_summary != null) {
      map['Summary'] = _summary?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// AgentID : "020001"
/// AgentName : "KRISHNA KUMAR"
/// Status : "Y"
/// Collection : 3500
/// Payment : 500
/// CashInHand : 4500
/// LastTxnDate : "10/04/2024"

class Summary {
  Summary({
      String? agentID, 
      String? agentName, 
      String? status, 
      num? collection, 
      num? payment, 
      num? cashInHand, 
      String? lastTxnDate,}){
    _agentID = agentID;
    _agentName = agentName;
    _status = status;
    _collection = collection;
    _payment = payment;
    _cashInHand = cashInHand;
    _lastTxnDate = lastTxnDate;
}

  Summary.fromJson(dynamic json) {
    _agentID = json['AgentID'];
    _agentName = json['AgentName'];
    _status = json['Status'];
    _collection = json['Collection'];
    _payment = json['Payment'];
    _cashInHand = json['CashInHand'];
    _lastTxnDate = json['LastTxnDate'];
  }
  String? _agentID;
  String? _agentName;
  String? _status;
  num? _collection;
  num? _payment;
  num? _cashInHand;
  String? _lastTxnDate;
Summary copyWith({  String? agentID,
  String? agentName,
  String? status,
  num? collection,
  num? payment,
  num? cashInHand,
  String? lastTxnDate,
}) => Summary(  agentID: agentID ?? _agentID,
  agentName: agentName ?? _agentName,
  status: status ?? _status,
  collection: collection ?? _collection,
  payment: payment ?? _payment,
  cashInHand: cashInHand ?? _cashInHand,
  lastTxnDate: lastTxnDate ?? _lastTxnDate,
);
  String? get agentID => _agentID;
  String? get agentName => _agentName;
  String? get status => _status;
  num? get collection => _collection;
  num? get payment => _payment;
  num? get cashInHand => _cashInHand;
  String? get lastTxnDate => _lastTxnDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AgentID'] = _agentID;
    map['AgentName'] = _agentName;
    map['Status'] = _status;
    map['Collection'] = _collection;
    map['Payment'] = _payment;
    map['CashInHand'] = _cashInHand;
    map['LastTxnDate'] = _lastTxnDate;
    return map;
  }

}

/// RC : "0"
/// TokenNo : "48916"

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