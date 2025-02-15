class CompanyTransactionSummary {
  String companyName;
  double totalCredited;
  double totalDebited;
  double finalBalance;

  CompanyTransactionSummary({
    required this.companyName,
    this.totalCredited = 0.0,
    this.totalDebited = 0.0,
    this.finalBalance = 0.0,
  });

  // Convert JSON (Map) to Dart object
  factory CompanyTransactionSummary.fromJson(Map<String, dynamic> json) {
    return CompanyTransactionSummary(
      companyName: json['companyName'],
      totalCredited: (json['totalCredited'] ?? 0.0).toDouble(),
      totalDebited: (json['totalDebited'] ?? 0.0).toDouble(),
      finalBalance: (json['finalBalance'] ?? 0.0).toDouble(),
    );
  }

  // Convert Dart object to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'totalCredited': totalCredited,
      'totalDebited': totalDebited,
      'finalBalance': finalBalance,
    };
  }
}
