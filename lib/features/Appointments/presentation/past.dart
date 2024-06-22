import 'package:MedInvent/features/Appointments/model/appointment.dart';
import 'package:MedInvent/features/Appointments/presentation/pastTemplate.dart';
import 'package:MedInvent/providers/appointmentsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Past extends ConsumerWidget {
  const Past({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //getting the screen size
    final double screenHeight = MediaQuery.of(context).size.height;

    List<Appointment> pastAppointments =
        ref.watch(appointmentsProvider).pastAppointments;

    return pastAppointments.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Column(
                  children: pastAppointments.map((appointment) {
                    return PastTemplate(
                      appointment: appointment,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
              ],
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(100),
            child: Center(
              child: Text(
                "You don't have any past appointments",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          );
  }
}
