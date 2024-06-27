import 'package:MedInvent/features/Appointments/model/appointment.dart';
import 'package:MedInvent/features/Appointments/presentation/upcomingTemplate.dart';
import 'package:MedInvent/providers/appointmentsProvider.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class AppointmentDetails extends ConsumerStatefulWidget {
  const AppointmentDetails(
      {required this.appointment, required this.type, super.key});

  final Appointment appointment;
  final String type;

  @override
  ConsumerState<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends ConsumerState<AppointmentDetails> {
  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String weekday = DateFormat('EEE').format(dateTime);
    int day = dateTime.day;
    String month = DateFormat('MMMM').format(dateTime);

    return '$weekday, $day${daySuffix(day)} of $month';
  }

  String convertTime(String time) {
    DateTime dateTime = DateTime.parse('1970-01-01 $time');
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  void onCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Text("Confirmation"),
          content:
              const Text("Are you sure you want to cancel this appointment?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                ref.read(appointmentsProvider.notifier).cancelAppointment(
                    widget.appointment,
                    ref.read(userProvider).user!.userId,
                    context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
        title: const Text("Appointment details"),
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: screenHeight * 0.025),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              )),
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.035),
            child: Column(
              children: [
                if (widget.appointment.isCancelled)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: screenHeight * 0.025),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.red, width: 2.0),
                    ),
                    child: Text(
                      "This appointment is cancelled by ${widget.appointment.cancelledByType == 'user' ? "you" : "the clinic"}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (widget.appointment.session.isCancelled)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: screenHeight * 0.025),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.red, width: 2.0),
                    ),
                    child: Text(
                      "This session is cancelled by ${widget.appointment.session.cancelledByType}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.02),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr ${widget.appointment.session.doctor.fname} ${widget.appointment.session.doctor.lname}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.appointment.session.doctor.specialization,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.appointment.session.clinic.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDate(widget.appointment.session.date),
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            convertTime(widget.appointment.session.timeFrom),
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Patient's name",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.appointment.patientTitle} ${widget.appointment.patientName}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Appointment number",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.appointment.appointmentNo.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Mobile number",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.appointment.contactNo,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.appointment.email != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.appointment.email!,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      const Text(
                        "NIC",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.appointment.nic,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      if (widget.type == "past")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Status",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.appointment.isAttended
                                  ? "Attender"
                                  : "Not attended",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                if (!widget.appointment.isCancelled &&
                    !widget.appointment.session.isCancelled &&
                    widget.type == "upcoming")
                  ref.watch(appointmentsProvider).isLoading
                      ? const SpinKitCircle(
                          size: 15,
                          color: Colors.blue,
                        )
                      : Button(
                          text: "Cancel appointment",
                          onPressed: () => {onCancel(context)})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
