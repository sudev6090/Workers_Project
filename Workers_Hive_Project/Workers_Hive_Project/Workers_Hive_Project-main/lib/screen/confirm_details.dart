import 'dart:io';
import 'package:flutter/material.dart';
import 'package:workers_project/functions/workers_functions.dart';
import 'package:workers_project/widgets/bottom_nav_screen.dart';

class ConfirmDetailScreen extends StatefulWidget {
  final String name;
  final String work;
  final String place;
  final String phone;
  final String fees;
  final String image;
  final int index;

  const ConfirmDetailScreen({
    super.key,
    required this.name,
    required this.work,
    required this.place,
    required this.phone,
    required this.fees,
    required this.image,
    required this.index,
  });

  @override
  State<ConfirmDetailScreen> createState() => _ConfirmDetailScreenState();
}

class _ConfirmDetailScreenState extends State<ConfirmDetailScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 120),
          child: Container(
            height: 650,
            width: 320,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 252, 252, 252)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(image: FileImage(File(widget.image))),
                const SizedBox(
                  height: 10,
                ),
                textfeildDetails(text1: 'Name', text2: widget.name),
                textfeildDetails(text1: 'Job', text2: widget.work),
                textfeildDetails(text1: 'Place', text2: widget.place),
                textfeildDetails(text1: 'Phone No', text2: widget.phone),
                textfeildDetails(text1: 'Fees', text2: widget.fees),
                
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Cancellation'),
                          content: const Text('Are you Sure'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const MyBottom(),
                                  ),
                                  (route) => false,
                                );
                                deleteBookedWorker(widget.index);
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 87, 88, 90),
                  ),
                  child: const Text(
                    'Cancel Work',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  textfeildDetails({
    required String text1,
    required String text2,
  }) =>
      Text(
        '$text1: $text2',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );

}
