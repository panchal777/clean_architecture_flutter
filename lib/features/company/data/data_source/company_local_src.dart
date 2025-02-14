abstract class CompanyLocalSrc {
  Future<bool> saveEntry(String amount);

  Future<bool> withdrawAmount(String amount, String companyName);

  Future<dynamic> getTransactionHistory();

  Future<dynamic> getDashboardData();
}
