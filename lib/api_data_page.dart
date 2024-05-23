import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

late String API_KEY = "016282d47a4249049bd134123242205";

class ApiDataPage extends StatefulWidget {
  @override
  _ApiDataPageState createState() => _ApiDataPageState();
}


class _ApiDataPageState extends State<ApiDataPage> {
  late String _location = 'Loading...';
  late String _temperature;
  late String _condition;
  late String _date;
  late String _minTemp;
  late String _maxTemp;
  late List<String> _hourlyWeather;

  @override
  void initState() {
    super.initState();
    fetchData("Saint Petersburg");
  }

  Future<void> fetchData(String city) async {
    late String url = "https://api.weatherapi.com/v1/forecast.json?key=" +
        API_KEY +
        "&q=" +
        city +
        "&days=" +
        "3" +
        "&aqi=no&alerts=no";
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _location = jsonResponse['location']['name'];
        _temperature = jsonResponse['current']['temp_c'].toString() + '°C';
        _condition = jsonResponse['current']['condition']['text'];
        _date = jsonResponse['location']['localtime'];
        _minTemp = jsonResponse['forecast']['forecastday'][0]['day']['mintemp_c'].toString() + '°C';
        _maxTemp = jsonResponse['forecast']['forecastday'][0]['day']['maxtemp_c'].toString() + '°C';
        _hourlyWeather = List<String>.generate(
          24,
              (index) => '${jsonResponse['forecast']['forecastday'][0]['hour'][index]['time']}: '
              '${jsonResponse['forecast']['forecastday'][0]['hour'][index]['temp_c']}°C',
        );
      });
    } else {
      setState(() {
        _location = 'Failed to load data';
        _temperature = '';
        _condition = '';
        _date = '';
        _minTemp = '';
        _maxTemp = '';
        _hourlyWeather = [];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Данные с API'),
      ),
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _date,
              style: TextStyle(fontSize: 24, fontFamily: 'aubrey'),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                '$_location',
                style: TextStyle(fontSize: 20, fontFamily: 'aubrey', color: Colors.pink),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                '$_temperature',
                style: TextStyle(fontSize: 40, fontFamily: 'aubrey', color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                '$_condition',
                style: TextStyle(fontSize: 20, fontFamily: 'aubrey', color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Align(
                alignment: Alignment.center,
                child: Text(
                  '$_minTemp / $_maxTemp',
                  style: TextStyle(fontSize: 20, fontFamily: 'aubrey', color: Colors.white),
                ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Погода по часам:',
                style: TextStyle(fontSize: 20, fontFamily: 'aubrey', color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _hourlyWeather.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _hourlyWeather[index],
                      style: TextStyle(fontSize: 18, fontFamily: 'aubrey', color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData("Saint Petersburg");
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}