

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency="AUD";

 List<String> list=[];
 List<Widget> wl=[];
  void addWidgetListItem()
  {
    for(int i=0;i<currenciesList.length;i++)
    {
      wl.add(Text(list[i]));print(list[i]);
    }

  }
  void addListItem()
  {
    for(int i=0;i<currenciesList.length;i++)
      {
        list.add(currenciesList[i]);print(list[i]);
      }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addListItem();
    addWidgetListItem();
    getCurrency();

  }
  var btc,eth,xrp;
 void getCurrency() async{
    Response response= await get("https://api.nomics.com/v1/currencies/ticker?key=a7523b7f0336aa5a85f38d3825ae13e4&ids=BTC,ETH,XRP&interval=1d,30d&convert=$selectedCurrency");
   setState(() {
    var btc1=  jsonDecode(response.body)[0]['price'];
    var eth1=  jsonDecode(response.body)[1]['price'];
    var xrp1=  jsonDecode(response.body)[2]['price'];
    setState(() {
      btc=btc1;
      eth=eth1;
      xrp=xrp1;
    });
   });




  }

  @override
  Widget build(BuildContext context) {
   if(btc==null)return Center(
     child: CircularProgressIndicator()
   );
   else
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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btc $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $eth$selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 XTH = $xrp $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS?(CupertinoPicker(itemExtent: 32, onSelectedItemChanged: (sI){
              setState(() {
                selectedCurrency=list[sI];print(selectedCurrency);
              });
            }, children: wl)):(DropdownButton<String>(items: list.map((String dropDownStringItem)
            {
              return DropdownMenuItem<String>(
                value:dropDownStringItem,
                child: Text( dropDownStringItem),
              );
            }).toList(), onChanged: (String a)
            {setState(() {
              selectedCurrency=a;
              getCurrency();

            });

            },value: selectedCurrency,))
          ),
        ],
      ),
    );
  }
}



