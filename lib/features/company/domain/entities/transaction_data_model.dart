class TransactionDataModel {
  String primaryId;
  String companyName;
  String savingAmount;
  String withdrawalAmount;
  DateTime createdDate;
  DateTime updatedDate;

  TransactionDataModel({
    required this.primaryId,
    required this.companyName,
    required this.savingAmount,
    required this.withdrawalAmount,
    required this.createdDate,
    required this.updatedDate,
  });

  // Convert a TransactionDataModel object into a Map
  Map<String, dynamic> toMap() {
    return {
      'primaryId': primaryId,
      'companyName': companyName,
      'savingAmount': savingAmount,
      'withdrawalAmount': withdrawalAmount,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }

  // Convert a Map into a TransactionDataModel object
  factory TransactionDataModel.fromMap(Map<String, dynamic> map) {
    return TransactionDataModel(
      primaryId: map['primaryId'],
      companyName: map['companyName'],
      savingAmount: map['savingAmount'],
      withdrawalAmount: map['withdrawalAmount'],
      createdDate: DateTime.parse(map['createdDate']),
      updatedDate: DateTime.parse(map['updatedDate']),
    );
  }
}
