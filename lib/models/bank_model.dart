class BankModel {
  final String accountHolder;
  final String bankName;
  final String iban;
  final String accountNumber;

  BankModel({
    required this.accountHolder,
    required this.bankName,
    required this.iban,
    required this.accountNumber,
  });

  // تحويل من Map (Firebase) إلى Model
  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      accountHolder: map['accountHolder'] ?? '',
      bankName: map['bankName'] ?? '',
      iban: map['iban'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
    );
  }

  // تحويل من Model إلى Map (للحفظ في Firebase)
  Map<String, dynamic> toMap() {
    return {
      'accountHolder': accountHolder,
      'bankName': bankName,
      'iban': iban,
      'accountNumber': accountNumber,
    };
  }
}
