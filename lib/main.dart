import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const StopWatch());
}

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  _StopWatch createState() => _StopWatch();
}

class _StopWatch extends State<StopWatch> {
  int _counter = 0;
  Duration duration = Duration.zero;
  late Timer _timer;
  bool _condition = false;

  Future<void> start() async {
    _condition = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _counter++;
          duration = Duration(seconds: _counter);
        });
      },
    );
  }

  Future<void> pause() async {
    _condition = false;
    _timer.cancel();
  }

  Future<void> reset() async {
    _counter = 0;
    duration = Duration.zero;
    _timer.cancel();
    _condition = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Секундомер',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.yellow,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        strokeWidth: 20,
                        color: Colors.yellow,
                        value: _counter.remainder(60) / 60,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        duration.inMinutes.toString(),
                        style: const TextStyle(
                            fontSize: 90, color: Colors.black54),
                      ),
                      const Text(
                        ':',
                        style: TextStyle(fontSize: 90, color: Colors.black54),
                      ),
                      Text(
                        duration.inSeconds
                            .remainder(60)
                            .toString()
                            .padLeft(2, '0'),
                        style: const TextStyle(
                            fontSize: 90, color: Colors.black54),
                      ),
                    ],
                  )
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    reset();
                  });
                },
                child: const Text(
                  'СБРОС',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'start',
          backgroundColor: Colors.yellowAccent,
          onPressed: () {
            if (!_condition) {
              setState(() {
                start();
              });
            } else {
              setState(() {
                pause();
              });
            }
            // start();
          },
          child: Icon(
            _condition ? Icons.pause : Icons.play_arrow,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
