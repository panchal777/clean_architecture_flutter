class TransactionModel {
  int? id;
  String companyName;
  double savingAmount;
  double withdrawalAmount;
  bool isWithdraw;
  DateTime createdDate;
  DateTime updatedDate;

  double totalDeposited;
  double totalWithdrawn;
  double finalAmount;

  TransactionModel({
    this.id, // Optional for auto-increment
    required this.companyName,
    this.savingAmount = 0,
    this.withdrawalAmount = 0,
    this.isWithdraw = false,
    required this.createdDate,
    required this.updatedDate,
    this.totalDeposited = 0,
    this.totalWithdrawn = 0,
    this.finalAmount = 0,
  });

  // Convert object to Map for database
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'companyName': companyName,
      'savingAmount': savingAmount,
      'withdrawalAmount': withdrawalAmount,
      'isWithdraw': isWithdraw ? 1 : 0, // Store as INTEGER (1 or 0) in SQLite
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
      'totalDeposited': totalDeposited,
      'totalWithdrawn': totalWithdrawn,
      'finalAmount': finalAmount,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Convert a Map to TransactionDataModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      companyName: map['companyName'],
      savingAmount: (map['savingAmount'] as num).toDouble(),
      withdrawalAmount: (map['withdrawalAmount'] as num).toDouble(),
      isWithdraw: map['isWithdraw'] == 1,
      // Convert INTEGER back to bool
      createdDate: DateTime.parse(map['createdDate']),
      updatedDate: DateTime.parse(map['updatedDate']),

      totalDeposited: (map['totalDeposited'] as num).toDouble(),
      totalWithdrawn: (map['totalWithdrawn'] as num).toDouble(),
      finalAmount: (map['finalAmount'] as num).toDouble(),
    );
  }

  // CopyWith function
  TransactionModel copyWith(
      {int? id,
      String? companyName,
      double? savingAmount,
      double? withdrawalAmount,
      bool? isWithdraw,
      DateTime? createdDate,
      DateTime? updatedDate,
      double? totalDeposited,
      double? totalWithdrawn,
      double? finalAmount}) {
    return TransactionModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      savingAmount: savingAmount ?? this.savingAmount,
      withdrawalAmount: withdrawalAmount ?? this.withdrawalAmount,
      isWithdraw: isWithdraw ?? this.isWithdraw,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      totalDeposited: totalDeposited ?? this.totalDeposited,
      totalWithdrawn: totalWithdrawn ?? this.totalWithdrawn,
      finalAmount: finalAmount ?? this.finalAmount,
    );
  }
}
