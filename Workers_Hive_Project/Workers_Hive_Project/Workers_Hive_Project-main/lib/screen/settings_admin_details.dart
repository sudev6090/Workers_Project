import 'dart:io';

import 'package:flutter/material.dart';
import 'package:workers_project/db/functions/db_functions.dart';

import 'package:workers_project/models/worker_model/worker_model.dart';
import 'package:workers_project/screen/settings_admin_edit.dart';
import 'package:workers_project/widgets/bottom_nav_screen.dart';

class AdminDetails extends StatefulWidget {
  const AdminDetails({super.key});

  @override
  State<AdminDetails> createState() => _AdminDetailsState();
}

class _AdminDetailsState extends State<AdminDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USER DETAILS'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<WorkerModel>>(
                valueListenable: workerListNotifier,
                builder: (context, workersList, _) {
                  return ListView.builder(
                    itemCount: workersList.length,
                    itemBuilder: (context, index) {
                      final worker = workersList[index];
                      return WorkerListItem(
                        worker: worker,
                        index: index,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkerListItem extends StatelessWidget {
  final WorkerModel worker;
  final int index;

  const WorkerListItem({super.key, required this.worker, required this.index});

  @override
  Widget build(BuildContext context) {
    getAllWorkers();
    final height = MediaQuery.sizeOf(context).height * 1;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            height: height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color.fromARGB(255, 205, 204, 204)),
              color: const Color.fromARGB(255, 111, 129, 144).withOpacity(0.2),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: const Color.fromARGB(255, 157, 167, 184),
                  margin: const EdgeInsets.only(right: 35),
                  child: worker.image.isNotEmpty
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: Image.file(File(worker.image)),
                        )
                      : Container(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      worker.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('WORK: ${worker.job}'),
                    Text('PLACE: ${worker.place}'),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(
                                  name: worker.name,
                                  work: worker.job,
                                  place: worker.place,
                                  phone: worker.phone,
                                  fees: worker.fees,
                                  image: worker.image,
                                  index: index),
                            ),
                          );
                        },
                        child: const Icon(Icons.edit)),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Deleting'),
                                  content: const Text('Are You Sure'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          deleteWorker(index);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyBottom()));
                                        },
                                        child: const Text('YES'))
                                  ],
                                );
                              });
                        },
                        child: const Icon(Icons.delete))
                  ],
                ),
                const SizedBox(
                  width: 1,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
