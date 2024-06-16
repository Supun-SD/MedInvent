import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/Appointments/model/appointment.dart';
import 'package:MedInvent/features/Map/map_screen.dart';
import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:MedInvent/features/prescriptions/presentation/MyPrescriptions.dart';
import 'package:MedInvent/providers/appointmentsProvider.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/medication_card.dart';
import 'package:MedInvent/features/Daily_medication/Presentation/daily_medication.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late String greeting;
  String medication1 = "Fever";
  String medication2 = "Diabetes";
  Image profilePhoto = Image.asset("assets/images/pic.png");
  final _controller = PageController();
  String username1 = "Amali";

  @override
  void initState() {
    setGreeting();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String userID = ref.watch(userProvider)!.userId;
      ref
          .read(appointmentsProvider.notifier)
          .fetchAppointments(context, userID);
    });

    super.initState();
  }

  void setGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      greeting = "Good morning and stay healthy.";
    } else if (hour < 18) {
      greeting = "Good afternoon and stay healthy.";
    } else {
      greeting = "Good evening and stay healthy.";
    }
  }

  List<String> widgetIcons = [
    "assets/widgetIcons/pharmacy.png",
    "assets/widgetIcons/doctor.png",
    "assets/widgetIcons/checkout.png",
  ];

  List<String> widgetTexts = [
    "Find Pharmacy",
    "Find Doctor",
    "Add prescription",
  ];

  List<IconData> background = [
    Icons.local_pharmacy_rounded,
    Icons.health_and_safety,
    Icons.edit_document,
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    bool isAppointmentsLoading = ref.watch(appointmentsProvider).isLoading;
    User user = ref.watch(userProvider)!;
    List<Appointment> upcomingAppointments =
        ref.watch(appointmentsProvider).upcomingAppointments;

    List shortcutActions = [
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const MapPage(selectedCategory: "pharmacies")),
        );
      },
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MapPage(selectedCategory: "doctors")),
        );
      },
      () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(screenHeight * 0.05)),
          ),
          context: context,
          builder: (BuildContext context) {
            return const AssignNewPrescription();
          },
        );
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      drawer: const SideNavBar(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,

        // greadient top bar
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
            Container(
              width: double.infinity,
              height: screenHeight * 0.065,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF474CA0),
                    Color(0xFF468FA0),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                //greating bar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 25,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          child: profilePhoto,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                greeting,
                                style:
                                    TextStyle(fontSize: screenHeight * 0.014),
                              ),
                              Text(
                                "Hi ${user.fname}!",
                                style: TextStyle(
                                    fontSize: screenHeight * 0.03,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //for space
                SizedBox(
                  height: screenHeight * 0.025,
                ),

                // medication tracker
                SizedBox(
                  height: screenHeight * 0.25,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: [
                      InkWell(
                        child: Medication_card(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          medication1: medication1,
                          medication2: medication2,
                          User: "${user.fname} ${user.lname}",
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DailyMed()),
                          );
                        },
                      ),
                      InkWell(
                        child: Medication_card(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            medication1: medication1,
                            medication2: medication2,
                            User: username1,
                            color: Colors.white),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DailyMed()),
                          );
                        },
                      )
                    ],
                  ),
                ),

                //upcoming appointments
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                upcomingAppointments.isEmpty
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08),
                        child: Row(
                          children: [
                            Container(
                              height: screenHeight * 0.17,
                              width: screenWidth * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upcoming\nAppointments',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.025),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Icon(Icons.arrow_forward)
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),

                            //appointment tabs
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05),
                                height: screenHeight * 0.17,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: isAppointmentsLoading
                                      ? const SpinKitCircle(
                                          size: 25,
                                          color: Colors.indigoAccent,
                                        )
                                      : Text(
                                          "You don't have any upcoming appointments",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.03),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: screenWidth * 0.08),
                              height: screenHeight * 0.12,
                              width: screenWidth * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upcoming\nAppointments',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.025),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Icon(Icons.arrow_forward)
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ...upcomingAppointments
                                .map((appointment) =>
                                    UpcomingWidget(appointment: appointment))
                                .toList()
                          ],
                        ),
                      ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.04),
                  height: screenHeight * 0.28,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Shortcut(
                        icon: widgetIcons[index],
                        text: widgetTexts[index],
                        background: background[index],
                        onTap: shortcutActions[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//shortcuts
class Shortcut extends StatelessWidget {
  const Shortcut(
      {required this.text,
      required this.icon,
      required this.background,
      required this.onTap,
      super.key});

  final String icon;
  final String text;
  final IconData background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              blurRadius: 10,
            ),
          ],
          color: const Color(0xFFF0FCFB),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Stack(
              children: [
                Icon(
                  background,
                  color: const Color(0xFF99C5C1).withOpacity(0.3),
                  size: screenWidth * 0.25,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          icon,
                          width: screenWidth * 0.07,
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                          textAlign: TextAlign.center,
                          text,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({required this.appointment, super.key});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.08,
            width: screenWidth * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/images/doctor.jpg",
                    height: screenHeight * 0.05,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr ${appointment.session.doctor.fname} ${appointment.session.doctor.lname}",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      appointment.session.doctor.specialization,
                      style: TextStyle(fontSize: screenWidth * 0.03),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.04,
            width: screenWidth * 0.75,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF474CA0),
                  Color(0xFF468FA0),
                ],
              ),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: screenWidth * 0.03,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        appointment.session.clinic.name,
                        style: TextStyle(
                            color: Colors.white, fontSize: screenWidth * 0.028),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: screenWidth * 0.03,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        appointment.session.date,
                        style: TextStyle(
                            color: Colors.white, fontSize: screenWidth * 0.028),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: screenWidth * 0.03,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        appointment.session.timeFrom,
                        style: TextStyle(
                            color: Colors.white, fontSize: screenWidth * 0.028),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
