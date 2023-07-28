import 'dart:async';
import 'dart:math';
import 'package:api/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TamagotchiScreen extends StatefulWidget {
  @override
  _TamagotchiScreenState createState() => _TamagotchiScreenState();
}

class _TamagotchiScreenState extends State<TamagotchiScreen> {
  bool _clicked = false;
  bool _tamiAlive = true;

  int _healthPercentage = 100;
  int _happinessPercentage = 100;

  List<String> _photoLinks = [
    'https://i0.wp.com/superchartisland.com/wp-content/uploads/2020/03/tamaegg.gif?resize=620%2C380&ssl=1',
    'https://media.tenor.com/VwzSNZflSOgAAAAC/tamagotchi-bandai.gif',
    'https://media.tenor.com/4KiSgIL4tKUAAAAC/tamagotchi-bandai.gif',
    'https://media.tenor.com/XRTmy5DN1pYAAAAC/TamagotchiScreen-bandai.gif',
  ];

  int counter = 0;
  Timer? _timer;
  late String imageUrl;

  @override
  void initState() {
    super.initState();

    _healthPercentage = 100;
    _happinessPercentage = 100;

    counter = 0;
    _clicked = false;
    imageUrl = _photoLinks[0];

    // Start the timer to increment the counter every 1 second (adjust as needed)
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_clicked) {
        setState(() {
          counter++;
          _tamiImages(counter);
        });
      }
    });
  }

  void _updateHealth() {
      setState(() {
        _healthPercentage += 10;
      });
  }

  void _updateHappiness() {
      setState(() {
        _happinessPercentage += 10;
      });
  }

  void _startDecreasingValues() {
    const checkValuesDuration = Duration(seconds: 0);
    {
      Timer.periodic(checkValuesDuration, (Timer timer) {
        if (!_tamiAlive) return;
          setState(() {
            if (_healthPercentage > 100) {
              _healthPercentage = 100;
            } else if (_happinessPercentage > 100) {
              _happinessPercentage = 100;
            }
          });
      });

      const decreaseDuration =
          Duration(seconds: 1); // Adjust the duration as needed
      Timer.periodic(decreaseDuration, (Timer timer) {
        if (!_tamiAlive) return;
        if (_tamiAlive) {
          if (mounted) {
            setState(() {
              // Reduce health and happiness by random value every 1 second
              int intValueHealth =
                  Random().nextInt(10); // Value is >= 0 and < 10.
              int intValueHappiness =
                  Random().nextInt(10); // Value is >= 0 and < 10.
              _healthPercentage -= intValueHealth;
              _happinessPercentage -= intValueHappiness;

              if (_healthPercentage <= 0 || _happinessPercentage <= 0) {
                {
                  _tamiAlive = false;
                  _clicked = false;

                  _healthPercentage = 100;
                  _happinessPercentage = 100;
                  return;
                }
              }
            });
          }
        }
        if (!_tamiAlive) {
          Navigator.pushReplacementNamed(context, '/DeadScreen');
        }
      });
    }
  }

  void _tamiImages(int time) {
    print('time + ${time}');

    imageUrl = _photoLinks[0];

    if (time > 10 && time <= 20) {
      imageUrl = _photoLinks[1];
    } else if (time > 20 && time <= 30) {
      imageUrl = _photoLinks[2];
    } else if (time > 30) {
      imageUrl = _photoLinks[3];
    }
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    counter = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TamagotchiScreen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                /// Health, Happiness text
                Row(
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    Text('Health', style: GoogleFonts.alike(fontSize: 24.0)),
                    const SizedBox(
                      width: 32,
                    ),
                    Text('Happiness', style: GoogleFonts.alike(fontSize: 24.0)),
                  ],
                ),

                /// STATS IN CIRCULAR PERCENT INDICATOR
                Row(
                  children: [
                    Text(
                      '${_healthPercentage}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 128,
                    ),
                    Text(
                      '${_happinessPercentage}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                /// TamagotchiScreen photo
                const SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    Text(
                      'Tami',
                      style: GoogleFonts.zeyada(fontSize: 32.0),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Image.network(
                      imageUrl,
                      height: 128,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 24,
                ),

                /// Buttons
                Row(
                  children: [
                    Container(
                      width: 42.0,
                      height: 42.0,
                      child: FloatingActionButton(
                        heroTag: "btn1",
                        onPressed: _updateHealth,
                        tooltip: 'PLAY', // Shows what the button does
                        child: const Icon(
                          Icons.add_card,
                          color: Colors.pink,
                          size: 28.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 64,
                    ),
                    Container(
                      width: 64.0,
                      height: 64.0,
                      child: FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: _clicked
                            ? null
                            : () {
                                setState(() => {
                                      _startDecreasingValues(),
                                      _clicked = true
                                    }); // set it to true now
                              },
                        tooltip: 'START', // Shows what the button does
                        child: const Icon(
                          Icons.play_circle,
                          color: Colors.pink,
                          size: 48.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 64,
                    ),
                    Container(
                      width: 42.0,
                      height: 42.0,
                      child: FloatingActionButton(
                        heroTag: "btn3",
                        onPressed: _updateHappiness,
                        tooltip: 'FEED', // Shows what the button does
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.pink,
                          size: 32.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    Text('PLAY', style: GoogleFonts.alike(fontSize: 16.0)),
                    const SizedBox(
                      height: 64,
                      width: 64,
                    ),
                    Text('START', style: GoogleFonts.alike(fontSize: 16.0)),
                    const SizedBox(
                      width: 64,
                    ),
                    Text('FEED', style: GoogleFonts.alike(fontSize: 16.0)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
