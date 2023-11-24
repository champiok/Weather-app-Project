import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherly/models/weather_model.dart';
import 'package:weatherly/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('fd38330b5047fe1678ec4d321a008f2f');
  final _cityTextController = TextEditingController();
  final _focusNode = FocusNode();
  Weather? _weather;
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _cityTextController.text = 'New Jersey';
    _fetchWeather();
  }

  void _fetchWeather() async {
    try {
      final weather =
          await _weatherService.getWeather(_cityTextController.text);
      setState(() {
        _weather = weather;
        _isSearchVisible = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load weather: $e')),
      );
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
    });

    if (_isSearchVisible) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
  }

  void _navigateToNotifications() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NotificationsPage(),
    ));
  }

  @override
  void dispose() {
    _cityTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        title: _isSearchVisible ? _buildSearchField() : null,
        leading: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: _navigateToNotifications,
        ),
        actions: [
          if (!_isSearchVisible)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _toggleSearch,
            ),
          if (_isSearchVisible)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: _toggleSearch,
            ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Expanded(
              child: Center(
                child: _weather == null
                    ? const Text("No weather data available.")
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weather!.cityName,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Lottie.asset(
                              getWeatherAnimation(_weather!.mainCondition)),
                          Text('${_weather!.temperature.round()}°C'),
                          Text(_weather!.mainCondition),
                          Text('Humidity: ${_weather!.humidity}%'),
                          Text('Wind: ${_weather!.windSpeed} mph'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        controller: _cityTextController,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: _fetchWeather,
          ),
        ),
        onSubmitted: (_) => _fetchWeather(),
      ),
    );
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/mist.json';
      case 'rain':
      case 'drizzle':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'snow':
        return 'assets/snow.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(),
    );
  }
}
