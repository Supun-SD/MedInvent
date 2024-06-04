import 'package:MedInvent/features/prescriptions/presentation/PrescriptionTemplate.dart';
import 'package:MedInvent/providers/prescriptionsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocPresContent extends ConsumerWidget {
  const DocPresContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final docPrescriptions = ref.watch(prescriptionsProvider).docPrescriptions;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, vertical: screenHeight * 0.04),
        child: Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.1),
          child: Column(
            children: docPrescriptions.isEmpty
                ? [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.1,
                          horizontal: screenWidth * 0.15),
                      child: Text(
                        "You don't have any doctor prescriptions",
                        style: TextStyle(
                            fontSize: screenHeight * 0.018, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]
                : docPrescriptions.map((e) {
                    return PrescriptionTemplate(
                      p: e,
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }
}
