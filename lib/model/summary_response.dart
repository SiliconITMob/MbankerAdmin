class SummaryResponse {
  SummaryResponse({
      String? rc,
      String? tokenNo,
      num? agentCount,
      num? dDCollection,
      num? sBCollection,
      num? loanCollection,
      num? rDCollection,
      num? chittyCollection,
      num? totalCollection,
      num? totalPayment,}){
    _rc = rc;
    _tokenNo = tokenNo;
    _agentCount = agentCount;
    _dDCollection = dDCollection;
    _sBCollection = sBCollection;
    _loanCollection = loanCollection;
    _rDCollection = rDCollection;
    _chittyCollection = chittyCollection;
    _totalCollection = totalCollection;
    _totalPayment = totalPayment;
}

  SummaryResponse.fromJson(dynamic json) {
    _rc = json['RC'];
    _tokenNo = json['TokenNo'];
    _agentCount = json['AgentCount'];
    _dDCollection = json['DDCollection'];
    _sBCollection = json['SBCollection'];
    _loanCollection = json['LoanCollection'];
    _rDCollection = json['RDCollection'];
    _chittyCollection = json['ChittyCollection'];
    _totalCollection = json['TotalCollection'];
    _totalPayment = json['TotalPayment'];
  }
  String? _rc;
  String? _tokenNo;
  num? _agentCount;
  num? _dDCollection;
  num? _sBCollection;
  num? _loanCollection;
  num? _rDCollection;
  num? _chittyCollection;
  num? _totalCollection;
  num? _totalPayment;
SummaryResponse copyWith({  String? rc,
  String? tokenNo,
  num? agentCount,
  num? dDCollection,
  num? sBCollection,
  num? loanCollection,
  num? rDCollection,
  num? chittyCollection,
  num? totalCollection,
  num? totalPayment,
}) => SummaryResponse(  rc: rc ?? _rc,
  tokenNo: tokenNo ?? _tokenNo,
  agentCount: agentCount ?? _agentCount,
  dDCollection: dDCollection ?? _dDCollection,
  sBCollection: sBCollection ?? _sBCollection,
  loanCollection: loanCollection ?? _loanCollection,
  rDCollection: rDCollection ?? _rDCollection,
  chittyCollection: chittyCollection ?? _chittyCollection,
  totalCollection: totalCollection ?? _totalCollection,
  totalPayment: totalPayment ?? _totalPayment,
);
  String? get rc => _rc;
  String? get tokenNo => _tokenNo;
  num? get agentCount => _agentCount;
  num? get dDCollection => _dDCollection;
  num? get sBCollection => _sBCollection;
  num? get loanCollection => _loanCollection;
  num? get rDCollection => _rDCollection;
  num? get chittyCollection => _chittyCollection;
  num? get totalCollection => _totalCollection;
  num? get totalPayment => _totalPayment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RC'] = _rc;
    map['TokenNo'] = _tokenNo;
    map['AgentCount'] = _agentCount;
    map['DDCollection'] = _dDCollection;
    map['SBCollection'] = _sBCollection;
    map['LoanCollection'] = _loanCollection;
    map['RDCollection'] = _rDCollection;
    map['ChittyCollection'] = _chittyCollection;
    map['TotalCollection'] = _totalCollection;
    map['TotalPayment'] = _totalPayment;
    return map;
  }

}