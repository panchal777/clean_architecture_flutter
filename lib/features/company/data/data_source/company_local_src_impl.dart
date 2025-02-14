import 'package:clean_architecture_flutter/features/company/data/data_source/company_local_src.dart';

class CompanyLocalSrcImpl implements CompanyLocalSrc {
  @override
  Future getDashboardData() async {
    // TODO: implement getDashboardData
    throw UnimplementedError();
  }

  @override
  Future getTransactionHistory() async {
    // TODO: implement getTransactionHistory
    throw UnimplementedError();
  }

  @override
  Future<bool> saveEntry(String amount) async {
    return true;
  }

  @override
  Future<bool> withdrawAmount(String amount, String companyName) async {
    return true;
  }
}
