import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/services/database/goal.dart';
import 'package:final_projek/widgets/edit_goal.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Goal.readProgres(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final documentSnapshot = snapshot.data!.docs[index];
              final String docId = snapshot.data!.docs[index].id;
              int goal = documentSnapshot['goal'];

              return StreamBuilder<QuerySnapshot>(
                stream: Book.finishedBook(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    final documentSnapshot = snapshot.data!.docs;
                    var total = documentSnapshot.length;
                    double percent = total / goal;
                    String percentString = '${(percent * 100).round()}%';
                    return Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffC5930B),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 50,
                              percent: percent,
                              lineWidth: 10,
                              backgroundColor: Colors.white54,
                              progressColor: Colors.white,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                percentString,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AutoSizeText(
                                        'Your Goals Almost Done',
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          AutoSizeText(
                                            total.toString() +
                                                ' of ' +
                                                goal.toString() +
                                                ' is Completed',
                                            maxLines: 1,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                          EditGoal(
                                            documentId: docId,
                                            goal: goal,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.black,
            ),
          ),
        );
      },
    );
  }
}
