import 'package:MedInvent/features/Search/presentation/doctorProfile.dart';
import 'package:MedInvent/features/Search/models/appointment.dart';
import 'package:MedInvent/features/Search/models/Doctor.dart';
import 'package:flutter/material.dart';

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({required this.doctor, super.key});

  final Doctor doctor;

  @override
  State<DoctorAppointments> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  String selectedValue = 'Select a clinic';
  DateTime selectedDate = DateTime.now();

  List<String> clinics = [
    'Select a clinic',
    'Clinic 1',
    'Clinic 2',
    'Clinic 3',
    'Clinic 4'
  ];

  List<Appointment> appointments1 = [
    Appointment("Medical Clinic - Katubedda", "Monday, 15th Jan 2024",
        "5.30 PM", 10, 20, 2500.00, null),
    Appointment("Medical Clinic - Katubedda", "Tuesday, 16th Jan 2024",
        "10.00 AM", 5, 15, 3000.00, null),
    Appointment("Medical Clinic - Katubedda", "Wednesday, 17th Jan 2024",
        "2.45 PM", 8, 22, 2800.00, "Bring medical reports"),
    Appointment("Medical Clinic - Katubedda", "Thursday, 18th Jan 2024",
        "4.15 PM", 12, 18, 2600.00, null),
  ];

  List<Appointment> appointments2 = [
    Appointment("Unity Health Center - Kandy", "Monday, 15th Jan 2024",
        "11.30 AM", 19, 19, 2700.00, "Vaccination needed"),
    Appointment("Unity Health Center - Kandy", "Tuesday, 16th Jan 2024",
        "3.00 PM", 7, 21, 2900.00, null),
    Appointment("Unity Health Center - Kandy", "Wednesday, 17th Jan 2024",
        "1.00 PM", 9, 17, 2550.00, "Follow-up checkup"),
  ];

  List<Appointment> appointments3 = [
    Appointment("Maple Leaf Clinic - Kurunegala", "Friday, 19th Jan 2024",
        "1.00 PM", 15, 17, 2550.00, "Follow-up checkup"),
    Appointment("Maple Leaf Clinic - Kurunegala", "Sunday, 21th Jan 2024",
        "1.00 PM", 17, 17, 2550.00, "Follow-up checkup"),
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                painter: HalfCirclePainter(),
              ),
            ),
            Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.15,
                    ),
                    Positioned(
                      left: screenWidth * 0.08,
                      right: screenWidth * 0.08,
                      top: screenHeight * 0.01,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10)),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/pic.png",
                              height: screenHeight * 0.075,
                            ),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr ${widget.doctor.fname} ${widget.doctor.lname}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.05),
                                ),
                                Text(
                                  widget.doctor.specialization,
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  padding: EdgeInsets.all(screenWidth * 0.012),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.44,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedValue,
                          items: clinics.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  value,
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          dropdownColor: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0),
                          underline: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 15),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '${selectedDate.toLocal()}'.split(' ')[0],
                              ),
                              IconButton(
                                onPressed: () => _selectDate(context),
                                icon: const Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                AppointmentPageView(
                  appointments: appointments1,
                  doctor: "${widget.doctor.fname} ${widget.doctor.lname}",
                ),
                AppointmentPageView(
                  appointments: appointments2,
                  doctor: "${widget.doctor.fname} ${widget.doctor.lname}",
                ),
                AppointmentPageView(
                  appointments: appointments3,
                  doctor: "${widget.doctor.fname} ${widget.doctor.lname}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentTemplate extends StatelessWidget {
  const AppointmentTemplate(
      {required this.appointment, required this.doctor, super.key});

  final Appointment appointment;
  final String doctor;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 5)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.05,
                decoration: const BoxDecoration(
                  color: Color(0xFF2980B9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Center(
                  child: Text(
                    appointment.date,
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.04),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.clinic,
                      style: TextStyle(
                          fontSize: screenWidth * 0.034,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "5.30 PM",
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Active Patients : ${appointment.activePatients}",
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Channeling Fee : ${appointment.channelingFee} + Booking fee",
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Special Note : ${appointment.specialNote ?? "Not available"}",
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: appointment.maximumPatients ==
                                appointment.activePatients
                            ? Text(
                                "The session is full",
                                style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           AppointmentConfirmation(
                                    //             session: session,
                                    //           )),
                                    // );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF2980B9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: Text(
                                    "Book now",
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.034,
                                        color: Colors.white),
                                  ),
                                ),
                              ))
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.025)
            ],
          ),
        ),
      ],
    );
  }
}

class AppointmentPageView extends StatefulWidget {
  const AppointmentPageView(
      {required this.appointments, required this.doctor, super.key});

  final List<Appointment> appointments;
  final String doctor;

  @override
  State<AppointmentPageView> createState() => _AppointmentPageViewState();
}

class _AppointmentPageViewState extends State<AppointmentPageView> {
  int currentPage = 0;
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      height: screenHeight * 0.35,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.appointments.length,
            itemBuilder: (BuildContext context, int index) {
              return AppointmentTemplate(
                key: UniqueKey(),
                appointment: widget.appointments[index],
                doctor: widget.doctor,
              );
            },
          ),
          Positioned(
            bottom: screenHeight * 0.01,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.appointments.length,
                (int index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  width: 7.0,
                  height: 7.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? const Color(0xFF2980B9)
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
