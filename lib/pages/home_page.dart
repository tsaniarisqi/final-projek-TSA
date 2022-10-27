import 'package:final_projek/widgets/progres_bar.dart';
import 'package:final_projek/widgets/readingStatusCard/currently_reading_card.dart';
import 'package:final_projek/widgets/readingStatusCard/finished_card.dart';
import 'package:final_projek/widgets/readingStatusCard/give_up_card.dart';
import 'package:final_projek/widgets/readingStatusCard/read_later_card.dart';
import 'package:final_projek/widgets/reading_status.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hi, Keysha',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'What book did you\n read today?',
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ],
                  ),
                  Image.asset(
                    'img/person.png',
                    height: 130,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),

              // progress bar
              const ProgressBar(),
              const SizedBox(
                height: 16,
              ),

              // reading status
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  children: const [
                    CurrentlyReadingCard(),
                    ReadLateCard(),
                    FinishedCard(),
                    GiveUpCard(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
