import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  var apiKey = '66D68C3E-0B22-4F91-8F0A-D61087D2335B';
  var url = 'https://rest.coinapi.io/v1/exchangerate';
  // String currencyId = 'USD';
  Map<String, String> cryptoPrices = {};
  Future getCoinData(selectedCurrency) async {
    for (String crypto in cryptoList) {
      http.Response response = await http
          .get(Uri.parse('$url/$crypto/$selectedCurrency?apikey=$apiKey'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        double itemCount = jsonResponse['rate'];
        print('Number of books about http: $itemCount.');
        cryptoPrices[crypto] = itemCount.toStringAsFixed(0);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    return cryptoPrices;
  }
}
