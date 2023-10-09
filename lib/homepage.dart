import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wether/api.dart';
import 'package:intl/intl.dart';
import 'package:wether/themechange.dart';
import 'graph.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigt = MediaQuery.of(context).size.height;
    String mydate = DateFormat('EEE, M/d/y hh:mm a').format(DateTime.now());
    final proobj = Provider.of<SProvider>(context);
    final sharedProvider = Provider.of<DarkThemePreference>(context);
    final color = Color.fromARGB(255, 79, 120, 170);
    final color2 = Color.fromARGB(255, 102, 146, 196);

    bool mylight = true;
    bool mysecondlight = false;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor:
          sharedProvider.light == true ? color : Color.fromARGB(255, 10, 9, 17),

      //start appbar
      appBar: AppBar(
        backgroundColor: sharedProvider.light == true
            ? color
            : Color.fromARGB(255, 10, 9, 17),
        elevation: 0,
        actions: [
          Container(
            height: screenheigt * 0.1,
            width: screenWidth * 0.27,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: sharedProvider.light == true
                  ? color2
                  : Color.fromARGB(255, 34, 41, 46),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    sharedProvider.mytheme(mylight);
                  },
                  icon: Icon(
                    Icons.sunny,
                    //   color: Colors.yellow,
                    color: sharedProvider.light == true
                        ? Colors.yellow
                        : Colors.white,
                    size: 16,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sharedProvider.mytheme(mysecondlight);
                      // themeChange.darkTheme=true;
                    },
                    icon: Icon(Icons.nightlight_round_outlined,
                        color: sharedProvider.light != true
                            ? Colors.yellow
                            : Colors.white,
                        size: 16)),
              ],
            ),
          ),
        ],
        centerTitle: true,
        title: Container(
          height: screenheigt * 0.1,
          width: screenWidth * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: sharedProvider.light == true
                ? color
                : Color.fromARGB(255, 10, 9, 17),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  proobj.fetchCurrentWeather();
                },
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
              ),
              Text(
                ' ${proobj.smo?.name ?? 'Search Location'}',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              proobj.circle == true
                  ? CircularProgressIndicator(
                      color: Colors.amber,
                    )
                  : IconButton(
                      onPressed: () {
                        TextEditingController city = TextEditingController();
                        //  fetchUser();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('search a city'),
                                content: TextField(controller: city),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('close')),
                                  TextButton(
                                      onPressed: () {
                                        proobj.fetchUser(city: city.text);
                                        Navigator.pop(context);
                                      },
                                      child: Text('ok'))
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ))
            ],
          ),
        ),
        leading: InkWell(
          onTap: () {},
          child: CircleAvatar(
              backgroundColor: sharedProvider.light == true
                  ? color
                  : Color.fromARGB(255, 10, 9, 17),
              backgroundImage: AssetImage('assets/v.png')),
        ),
      ),
      //close appbar;

      body: Column(
        children: [
          SizedBox(
            height: screenheigt * 0.015,
          ),
          Center(
            child: Text(
              'Today',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: screenheigt * 0.01,
          ),
          Center(
            child: Text(
              '$mydate',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: screenheigt * 0.03,
          ),
          Container(
            height: screenheigt * 0.45,
            width: screenWidth * 0.85,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 25.0,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: sharedProvider.light == true
                  ? color2
                  : Color.fromARGB(255, 34, 41, 46),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (proobj.smo != null)
                  SizedBox(
                      height: screenheigt * 0.21,
                      child: getLeadingWidget(proobj.smo!.description)),
                Text(
                  ' ${proobj.smo?.description ?? 'description'}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  '${proobj.smo?.temperature ?? 0}°C',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.air_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          '${proobj.smo?.wind ?? 0}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'wind',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.water_drop_sharp,
                          color: Colors.white,
                        ),
                        Text(
                          '${proobj.smo?.humidity ?? 0}%',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Humidity',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Today',
                style: TextStyle(color: Colors.yellow),
              ),
              SizedBox(
                width: screenWidth * 0.55,
              ),
              Row(
                children: [
                  Text(
                    'Next 7 Days',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/r3.png'),
                    height: screenheigt * 0.035,
                  ),
                  SizedBox(
                    height: screenheigt * 0.01,
                  ),
                  Text(
                    '21°',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/r3.png'),
                    height: screenheigt * 0.035,
                  ),
                  SizedBox(
                    height: screenheigt * 0.01,
                  ),
                  Text(
                    '20°',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/h2.png'),
                    height: screenheigt * 0.044,
                  ),
                  SizedBox(
                    height: screenheigt * 0.01,
                  ),
                  Text(
                    '22°',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/s2.webp'),
                    height: screenheigt * 0.035,
                  ),
                  SizedBox(
                    height: screenheigt * 0.01,
                  ),
                  Text(
                    '23°',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SpendFrequencyChart(),
        ],
      ),
    );
  }

  Widget getLeadingWidget(String category) {
    switch (category) {
      case 'overcast clouds':
        return Image.asset(
          'assets/overcast.png',
        );
      case 'scattered clouds':
        return Image.asset('assets/scattered.png');
      case 'clear sky':
        return Image.asset('assets/sun.png');
      case 'haze':
        return Image.asset('assets/haze.png');
      case 'few clouds':
        return Image.asset('assets/d.webp');
      case 'broken clouds':
        return Image.asset('assets/d.webp');
      case 'moderate rain':
        return Image.asset('assets/cloudy.png');
      case 'light rain':
        return Image.asset('assets/light.png');
      case 'light intensity shower rain':
        return Image.asset('assets/light.png');
      case 'drizzle':
        return Image.asset('assets/drizzle.png');
      case 'heavy intensity rain':
        return Image.asset('assets/heavy-rain.png');
      default:
        return Image.asset('assets/s2.webp');
    }
  }
}
