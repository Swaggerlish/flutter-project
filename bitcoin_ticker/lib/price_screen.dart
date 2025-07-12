import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  DropdownMenu<String> androidDropdown() {
    List<DropdownMenuEntry<String>> currencyList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuEntry(
        label: currency,
        value: currency,
      );
      currencyList.add(newItem);
    }
    return DropdownMenu<String>(
        hintText: selectedCurrency,
        dropdownMenuEntries: currencyList,
        onSelected: (value) {
          setState(() {
            value;
            getData();
          });
        });
  }

  CupertinoPicker iosPicker() {
    List<Text> currencyList = [];
    // List<String> defaultCurrency = ['USD'];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      currencyList.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 30.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: currencyList,
    );
  }

  // String bitcoinValue = '?';
  bool isWaiting = false;
  Map<String, String> cryptoValues = {};
  //11. Create an async method here await the coin data from coin_data.dart
  void getData() async {
    isWaiting = true;
    CoinData coinData = CoinData();
    try {
      var data = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        cryptoValues = data;
      });
    } catch (e) {
      // print(e);
      setState(() async {
        cryptoValues = await coinData.getCoinData('USD');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('🤑 Coin Ticker'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Column(
                  children: <Widget>[
                    CryptoCard(
                        value: isWaiting ? '?' : cryptoValues['BTC'] ?? 'ETH',
                        crypto: 'BTC',
                        selectedCurrency: selectedCurrency),
                    CryptoCard(
                        value: isWaiting ? '?' : cryptoValues['ETH'] ?? 'ETH',
                        crypto: 'ETH',
                        selectedCurrency: selectedCurrency),
                    CryptoCard(
                        value: isWaiting ? '?' : cryptoValues['LTC'] ?? 'ETH',
                        crypto: 'LTC',
                        selectedCurrency: selectedCurrency)
                  ],
                )),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iosPicker() : androidDropdown(),
            ),
          ],
        ));
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {super.key,
      required this.value,
      required this.crypto,
      required this.selectedCurrency});

  final String value;
  final String crypto;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $value $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
