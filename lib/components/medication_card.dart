import 'package:MedInvent/features/Daily_medication/Presentation/daily_medication.dart';
import 'package:flutter/material.dart';
import '../features/Daily_medication/models/DailyMedication.dart';

class MedicationCard extends StatelessWidget {
  final List<DailyMedication> dailyMedications;

  const MedicationCard({Key? key, required this.dailyMedications})
      : super(key: key);

  int calculateTotalMedicationIntake(DailyMedication dailyMedication) {
    int totalIntakes = 0;
    for (var medicine in dailyMedication.presMedicine) {
      totalIntakes += medicine.medicationIntake.length;
    }
    return totalIntakes;
  }

  int calculateTakenMedicationIntakes(DailyMedication dailyMedication) {
    int takenIntakes = 0;
    for (var medicine in dailyMedication.presMedicine) {
      for (var intake in medicine.medicationIntake) {
        if (intake.taken) {
          takenIntakes++;
        }
      }
    }
    return takenIntakes;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DailyMedicationDetails(dailyMedications: dailyMedications)),
        )
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.025, horizontal: screenWidth * 0.08),
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              "Your daily medications",
              style: TextStyle(fontSize: 16),
            )),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            ...dailyMedications
                .map((dailyMed) => PrescriptionTemplate(
                    dailyMedication: dailyMed,
                    totalMeds: calculateTotalMedicationIntake(dailyMed),
                    takenMeds: calculateTakenMedicationIntakes(dailyMed)))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class PrescriptionTemplate extends StatelessWidget {
  const PrescriptionTemplate(
      {super.key,
      required this.dailyMedication,
      required this.totalMeds,
      required this.takenMeds});
  final DailyMedication dailyMedication;
  final int totalMeds;
  final int takenMeds;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dailyMedication.presName),
          const SizedBox(
            height: 8,
          ),
          StepProgressIndicator(totalSteps: totalMeds, currentStep: takenMeds)
        ],
      ),
    );
  }
}

class StepProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 25,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black12, Colors.black12],
            ),
          ),
        ),
        Container(
          width: currentStep * 25,
          height: 25,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(150, 63, 195, 128), Colors.black12],
            ),
          ),
        ),
        Positioned(
          left: 25 * (currentStep - 1),
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.transparent,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
