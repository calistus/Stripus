import 'package:dio/dio.dart';
import 'package:stripus/model/loqate_validate_model.dart';
import 'package:stripus/secret/api_keys.dart';

class AccountValidationRepository {
  final _baseUrl = "https://api-v3.rakutentravelxchange.com";
  final headerPayLoad = {
    "X-Api-Key": APIKeys.LOQATE_TEST_API_KEY,
    "accept-encoding": "gzip"
  };

  Future<AccountValidatorModel> validateAccount(
      String accountNumber, String sortCode) async {
    try {
      print("Innn");
      Dio dio = new Dio();
      String requestURL =
          "https://api.addressy.com/BankAccountValidation/Interactive/Validate/v2/json3.ws?Key=PK89-FA93-PG99-PH86&AccountNumber=70872490&SortCode=40-47-84";
      Response response = await dio.post(requestURL);
      print(response);
      return AccountValidatorModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
  }
}
