import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'getCity.dart';
import 'getWeather.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override


  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const MyHomePage(),
    // );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyAppTheme>(
          create: (context) => MyAppTheme(),
        ),
      ],
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}





class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> day = ['H', 'H+1', 'H+2','H+3','H+4','H+5','H+6' ];

  late Position position;
  late String currentLocation = '';

  Map<int, Map<String, dynamic>> logo = {
    0: {'status': 'Clear sky', 'logo': 'clear_day.png', 'color1': 0xff2972FF, 'color2': 0xff99BCFF},
    1: {'status': 'Mainly clear', 'logo': 'partly_cloudy_day.png', 'color1': 0xff2972FF, 'color2': 0xff99BCFF},
    2: {'status': 'Partly cloudy', 'logo': 'partly_cloudy_night.png', 'color1': 0xff86ADF9, 'color2': 0xffD9E6FF},
    3: {'status': 'Overcast', 'logo': 'cloudy.png', 'color1': 0xff86ADF9, 'color2': 0xffD9E6FF},
    45: {'status': 'Fog', 'logo': 'clear_night.png', 'color1': 0xff86ADF9, 'color2': 0xffD9E6FF},
    48: {'status': 'Depositing rime fog', 'logo': 'clear_night.png', 'color1': 0xff86ADF9, 'color2': 0xffD9E6FF},
    51: {'status': 'Drizzle Light', 'logo': 'rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    53: {'status': 'Drizzle Moderate', 'logo': 'rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    55: {'status': 'Dense Intensity', 'logo': 'heavy_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    56: {'status': 'Freezing Drizzle Light', 'logo': 'freezing_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    57: {'status': 'Freezing Drizzle dense intensity', 'logo': 'freezing_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    61: {'status': 'Rain Slight', 'logo': 'light_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    63: {'status': 'Rain Moderate', 'logo': 'moderate_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    65: {'status': 'Rain heavy intensity', 'logo': 'heavy_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    66: {'status': 'Freezing Rain Light', 'logo': 'freezing_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    67: {'status': 'Freezing Rain heavy intensity', 'logo': 'freezing_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    80: {'status': 'Rain showers Slight', 'logo': 'showers.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    81: {'status': 'Rain showers Moderate', 'logo': 'showers.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    82: {'status': 'Rain showers Violent', 'logo': 'light_snow.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    85: {'status': 'Snow showers slight', 'logo': 'light_snow.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    86: {'status': 'Snow showers heavy', 'logo': 'heavy_snow.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    95: {'status': 'Thunderstorm Slight or moderate', 'logo': 'thunderstorm.png', 'color1': 0xff374052, 'color2': 0xffFFFFFF},
    96: {'status': 'Thunderstorm slight', 'logo': 'thunderstorm.png', 'color1': 0xff374052, 'color2': 0xffFFFFFF},
    99: {'status': 'Thunderstorm with slight and heavy hail', 'logo': 'thunderstorm_hail.png', 'color1': 0xff374052, 'color2': 0xffFFFFFF},
  };

  late WeatherData weatherData = WeatherData(
    latitude: 0.0,
    longitude: 0.0,
    generationtimeMs: 0.0,
    utcOffsetSeconds: 0,
    timezone: '',
    timezoneAbbreviation: '',
    elevation: 0,
    currentUnits: CurrentUnits(
      time: '',
      interval: '',
      temperature2m: '',
      relativeHumidity2m: '',
      apparentTemperature: '',
      isDay: '',
      precipitation: '',
      rain: '',
      weatherCode: '',
      windSpeed10m: '',
    ),
    current: Current(
      time: '',
      interval: 0,
      temperature2m: 0.0,
      relativeHumidity2m: 0,
      apparentTemperature: 0.0,
      isDay: 0,
      precipitation: 0.0,
      rain: 0.0,
      weatherCode: 0,
      windSpeed10m: 0.0,
    ),
    dailyUnits: DailyUnits(
      time: '',
      weatherCode: '',
    ),
    daily: Daily(
      time: [],
      weatherCode: [],
    ),
    hourlyUnits: HourlyUnits(
      time:'',
      temperature2m:'',
      weatherCode:'',
    ),
    hourly: Hourly(
      time: [],
      temperature2m:[],
      weatherCode: [],
    ),
  );

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _requestLocationPermission();
    await _getCurrentLocation();
    await _loadWeatherData();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isDenied) {
      await Permission.location.request();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final latitude = position.latitude;
      final longitude = position.longitude;

      await _getCityName(latitude, longitude);

      print('Latitude: $latitude, Longitude: $longitude');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getCityName(double latitude, double longitude) async {
    try {
      final cityName = await getCityName(latitude, longitude);

      setState(() {
        currentLocation = cityName;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  Future<void> _loadWeatherData() async {
    try {
      final fetchedWeatherData = await fetchWeatherData(position.latitude, position.longitude);
      setState(() {
        weatherData = fetchedWeatherData;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  void _openModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.grey,
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: (weatherData.daily.weatherCode.length ?? 0), // +1 for header row
              itemBuilder: (context, index) {
                // Data rows
                return Padding(
                  padding: EdgeInsets.all(7),
                  child:Column(
                    children: [
                      Container(
                          width: 100,
                          height: 180,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Text(weatherData.daily.time[index].toString() ?? 'Loading...'),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Image.asset(
                                  'assets/images/' + logo[weatherData.daily.weatherCode[index]]?['logo'] ?? '', // Path to image in assets directory
                                  fit: BoxFit.cover,
                                  width: 50,
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text(logo[weatherData.daily.weatherCode[index]]?['status'], style: TextStyle(fontSize: 11),)
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<MyAppTheme>(context);
    final weatherCode = weatherData.current.weatherCode;

    DateTime now = DateTime.now();
    String tanggalHariIni = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    appTheme.updateTheme(weatherCode); // Mengubah tema berdasarkan weatherCode

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: appTheme.current,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100.0),
              ),
              Text(currentLocation, style: TextStyle(color: Colors.white, fontSize: 30.0)),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
              ),
              Text('In your location', style: TextStyle(color: Colors.white, fontSize: 12.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(' ', style: TextStyle(color: Colors.white, fontSize: 70.0)),
                  Text(' ' + (weatherData.current.temperature2m.round().toString() ?? 'Loading...') + '°', style: TextStyle(color: Colors.white, fontSize: 135.0)),
                ],
              ),
              Text(logo[weatherData.current.weatherCode]?['status'] ?? 'Unknown', style: TextStyle(color: Colors.white, fontSize: 20.0)),
              SizedBox(height: 30.0),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.25),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.all(20.0),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(weatherData.current.relativeHumidity2m.toString() + weatherData.currentUnits.relativeHumidity2m, style: TextStyle(color: Colors.white)),
                              Text('Humidity', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          Column(
                            children: [
                              Text(weatherData.current.precipitation.toString() + weatherData.currentUnits.precipitation, style: TextStyle(color: Colors.white)),
                              Text('Precipitation', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          Column(
                            children: [
                              Text(weatherData.current.windSpeed10m.toString() + weatherData.currentUnits.windSpeed10m, style: TextStyle(color: Colors.white)),
                              Text('Wind', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child:ElevatedButton(
                            onPressed: () {
                              _openModalBottomSheet(context);
                            },
                            child: Text('Next 7 days', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(138, 138, 138, 1))
                            ),
                          ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: ((weatherData.daily.weatherCode.length > 0) ? 24 : 0), // +1 for header row
                          itemBuilder: (context, index) {
                            // Data rows
                            return Padding(
                              padding: EdgeInsets.all(7),
                              child:Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 180,
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 255, 255, 0.5),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Padding(padding: EdgeInsets.only(top: 20)),
                                          Text(weatherData.hourly.time[index].toString().split('T')[1].substring(0, 5) ?? 'Loading...'),
                                          Padding(padding: EdgeInsets.only(top: 20)),
                                          Image.asset(
                                            'assets/images/' + logo[weatherData.hourly.weatherCode[index]]?['logo'] ?? '', // Path to image in assets directory
                                            fit: BoxFit.cover,
                                            width: 50,
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10)),
                                          Text(logo[weatherData.hourly.weatherCode[index]]?['status'], style: TextStyle(fontSize: 11),)

                                        ],
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MyAppTheme extends ChangeNotifier {
  List<Color> current = [
    Color(0xff2972FF),
    Color(0xff2972FF),
  ];

  Map<int, Map<String, dynamic>> logo = {
    0: {'status': 'Clear sky', 'logo': 'clear_day.png', 'color1': 0xff2972FF, 'color2': 0xff99BCFF},
    1: {'status': 'Mainly clear', 'logo': 'partly_cloudy_day.png', 'color1': 0xff2972FF, 'color2': 0xff99BCFF},
    2: {'status': 'Partly cloudy', 'logo': 'partly_cloudy_night.png', 'color1': 0xff86ADF9, 'color2': 0xffD9E6FF},
    3: {'status': 'Overcast', 'logo': 'cloudy.png', 'color1': 0xff86ADF9, 'color2': 0xffD9E6FF},
    45: {'status': 'Fog', 'logo': 'clear_night.png', 'color1': 0xff86ADF9, 'color2': 0xffD9E6FF},
    48: {'status': 'Depositing rime fog', 'logo': 'clear_night.png', 'color1': 0xff86ADF9, 'color2': 0xffD9E6FF},
    51: {'status': 'Drizzle Light', 'logo': 'rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    53: {'status': 'Drizzle Moderate', 'logo': 'rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    55: {'status': 'Dense Intensity', 'logo': 'heavy_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    56: {'status': 'Freezing Drizzle Light', 'logo': 'freezing_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    57: {'status': 'Freezing Drizzle dense intensity', 'logo': 'freezing_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    61: {'status': 'Rain Slight', 'logo': 'light_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    63: {'status': 'Rain Moderate', 'logo': 'moderate_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    65: {'status': 'Rain heavy intensity', 'logo': 'heavy_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    66: {'status': 'Freezing Rain Light', 'logo': 'freezing_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    67: {'status': 'Freezing Rain heavy intensity', 'logo': 'freezing_rain.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    80: {'status': 'Rain showers Slight', 'logo': 'showers.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    81: {'status': 'Rain showers Moderate', 'logo': 'showers.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    82: {'status': 'Rain showers Violent', 'logo': 'light_snow.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    85: {'status': 'Snow showers slight', 'logo': 'light_snow.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    86: {'status': 'Snow showers heavy', 'logo': 'heavy_snow.png', 'color1': 0xff778DB9, 'color2': 0xffC5D4F2},
    95: {'status': 'Thunderstorm Slight or moderate', 'logo': 'thunderstorm.png', 'color1': 0xff374052, 'color2': 0xffFFFFFF},
    96: {'status': 'Thunderstorm slight', 'logo': 'thunderstorm.png', 'color1': 0xff374052, 'color2': 0xffFFFFFF},
    99: {'status': 'Thunderstorm with slight and heavy hail', 'logo': 'thunderstorm_hail.png', 'color1': 0xff374052, 'color2': 0xffFFFFFF},
  };

  void updateTheme(int weatherCode) {
    if (logo.containsKey(weatherCode)) {
      current = [
        Color(logo[weatherCode]!['color1'] as int),
        Color(logo[weatherCode]!['color2'] as int),
      ];
      notifyListeners();
    }
  }
}
