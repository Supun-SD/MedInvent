import 'package:MedInvent/providers/dailyMedicationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/DailyMedication.dart';

class DailyMedicationDetails extends StatelessWidget {
  const DailyMedicationDetails({super.key, required this.dailyMedications});
  final List<DailyMedication> dailyMedications;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
        ),
        title: const Text("Daily medication details"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF474CA0),
              Color(0xFF468FA0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.025),
            decoration: const BoxDecoration(
                color: Color(0xFFfafafa),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                )),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07,
                  vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...dailyMedications
                      .map((dailyMed) => Pres(dailyMedication: dailyMed))
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Pres extends StatelessWidget {
  const Pres({super.key, required this.dailyMedication});
  final DailyMedication dailyMedication;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            dailyMedication.presName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          ...dailyMedication.presMedicine
              .map((med) => Med(medicine: med))
              .toList()
        ],
      ),
    );
  }
}

class Med extends StatelessWidget {
  const Med({super.key, required this.medicine});
  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFe3f6ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${medicine.name} (quantity : ${medicine.qty})",
              style: const TextStyle(fontSize: 15),
            ),
            const Divider(
              color: Colors.blue,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...medicine.medicationIntake
                      .map((intake) => Marker(medicationIntake: intake))
                ],
              ),
            ),
          ],
        ));
  }
}

class Marker extends ConsumerStatefulWidget {
  const Marker({super.key, required this.medicationIntake});
  final MedicationIntake medicationIntake;

  @override
  ConsumerState<Marker> createState() => _MarkerState();
}

class _MarkerState extends ConsumerState<Marker> {
  bool isLoading = false;

  String formatTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);

    String period = hours < 12 ? 'AM' : 'PM';

    if (hours > 12) {
      hours -= 12;
    } else if (hours == 0) {
      hours = 12;
    }

    return '$hours:${parts[1]} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: widget.medicationIntake.taken ? Colors.green : Colors.grey,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(13.0),
              child: SpinKitCircle(
                size: 15,
                color: Colors.blue,
              ),
            )
          else
            widget.medicationIntake.taken
                ? const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ))
                : Checkbox(
                    value: widget.medicationIntake.taken,
                    onChanged: (bool? value) async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        await ref
                            .read(dailyMedicationsProvider.notifier)
                            .updateDailyMedication(widget.medicationIntake.id,
                                widget.medicationIntake);
                        setState(() {
                          widget.medicationIntake.taken = value ?? false;
                          isLoading = false;
                        });
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.standard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
          Text(formatTime(widget.medicationIntake.time)),
        ],
      ),
    );
  }
}
