import 'package:MedInvent/features/Appointments/model/appointment.dart';
import 'package:MedInvent/features/Appointments/presentation/upcomingTemplate.dart';
import 'package:MedInvent/providers/appointmentsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Upcoming extends ConsumerWidget {
  const Upcoming({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;

    List<Appointment> upcomingAppointments =
        ref.watch(appointmentsProvider).upcomingAppointments;

    return upcomingAppointments.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Column(
                  children: upcomingAppointments.map((appointment) {
                    return UpcomingTemplate(
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
                textAlign: TextAlign.center,
                "You don't have any upcoming appointments",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
  }
}
