class TransactionModel {
  int? id;
  String companyName;
  double savingAmount;
  double withdrawalAmount;
  bool isWithdraw;
  DateTime createdDate;
  DateTime updatedDate;

  TransactionModel({
    this.id, // Optional for auto-increment
    required this.companyName,
    this.savingAmount = 0,
    this.withdrawalAmount = 0,
    this.isWithdraw = false,
    required this.createdDate,
    required this.updatedDate,
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
    );
  }

  // CopyWith function
  TransactionModel copyWith({
    int? id,
    String? companyName,
    double? savingAmount,
    double? withdrawalAmount,
    bool? isWithdraw,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      savingAmount: savingAmount ?? this.savingAmount,
      withdrawalAmount: withdrawalAmount ?? this.withdrawalAmount,
      isWithdraw: isWithdraw ?? this.isWithdraw,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }
}
