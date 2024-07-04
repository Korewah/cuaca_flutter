import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentUnits currentUnits;
  final Current current;
  final DailyUnits dailyUnits;
  final Daily daily;
  final HourlyUnits hourlyUnits;
  final Hourly hourly;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.dailyUnits,
    required this.daily,
    required this.hourlyUnits,
    required this.hourly,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationtimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentUnits: CurrentUnits.fromJson(json['current_units']),
      current: Current.fromJson(json['current']),
      dailyUnits: DailyUnits.fromJson(json['daily_units']),
      daily: Daily.fromJson(json['daily']),
      hourlyUnits: HourlyUnits.fromJson(json['hourly_units']),
      hourly: Hourly.fromJson(json['hourly']),
    );
  }
}

class CurrentUnits {
  final String time;
  final String interval;
  final String temperature2m;
  final String relativeHumidity2m;
  final String apparentTemperature;
  final String isDay;
  final String precipitation;
  final String rain;
  final String weatherCode;
  final String windSpeed10m;

  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.isDay,
    required this.precipitation,
    required this.rain,
    required this.weatherCode,
    required this.windSpeed10m,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      apparentTemperature: json['apparent_temperature'],
      isDay: json['is_day'],
      precipitation: json['precipitation'],
      rain: json['rain'],
      weatherCode: json['weather_code'],
      windSpeed10m: json['wind_speed_10m'],
    );
  }
}

class Current {
  final String time;
  final int interval;
  final double temperature2m;
  final int relativeHumidity2m;
  final double apparentTemperature;
  final int isDay;
  final double precipitation;
  final double rain;
  final int weatherCode;
  final double windSpeed10m;

  Current({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.isDay,
    required this.precipitation,
    required this.rain,
    required this.weatherCode,
    required this.windSpeed10m,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      apparentTemperature: json['apparent_temperature'],
      isDay: json['is_day'],
      precipitation: json['precipitation'],
      rain: json['rain'],
      weatherCode: json['weather_code'],
      windSpeed10m: json['wind_speed_10m'],
    );
  }
}

class HourlyUnits {
  final String time;
  final String temperature2m;
  final String weatherCode;

  HourlyUnits({
    required this.time,
    required this.temperature2m,
    required this.weatherCode,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'],
      temperature2m: json['temperature_2m'],
      weatherCode: json['weather_code'],
    );
  }
}

class Hourly {
  final List<String> time;
  final List<double> temperature2m;
  final List<int> weatherCode;

  Hourly({
    required this.time,
    required this.temperature2m,
    required this.weatherCode,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      time: List<String>.from(json['time']),
      temperature2m: List<double>.from(json['temperature_2m']),
      weatherCode: List<int>.from(json['weather_code']),
    );
  }
}

class DailyUnits {
  final String time;
  final String weatherCode;

  DailyUnits({
    required this.time,
    required this.weatherCode,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'],
      weatherCode: json['weather_code'],
    );
  }
}

class Daily {
  final List<String> time;
  final List<int> weatherCode;

  Daily({
    required this.time,
    required this.weatherCode,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      time: List<String>.from(json['time']),
      weatherCode: List<int>.from(json['weather_code']),
    );
  }
}

Future<WeatherData> fetchWeatherData(double latitude, double longitude) async {
  final String apiUrl = 'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,weather_code&daily=weather_code&timezone=Asia/Jakarta&forecast_days=7&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,rain,weather_code,wind_speed_10m';

  final response = await http.get(Uri.parse(apiUrl));

  print(apiUrl);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = jsonDecode(response.body);

    return WeatherData.fromJson(jsonMap);
  } else {
    throw Exception('Failed to load data');
  }
}
