import 'package:MedInvent/providers/prescriptionsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/prescriptions/presentation/DocPrescriptions.dart';
import 'package:MedInvent/features/prescriptions/presentation/MyPrescriptions.dart';
import 'package:MedInvent/components/CustomTabBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Prescriptions extends ConsumerStatefulWidget {
  const Prescriptions({super.key});

  @override
  _PrescriptionsState createState() => _PrescriptionsState();
}

class _PrescriptionsState extends ConsumerState<Prescriptions> {
  String userID = "126b4f01-e486-461e-b20e-311e3c7c0ffb";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(prescriptionsProvider.notifier)
          .fetchPrescriptions(context, userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionsState = ref.watch(prescriptionsProvider);
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const SideNavBar(),
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
        title: const Text("Prescriptions"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
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
            ),
          ),
        ],
      ),
      body: prescriptionsState.isLoading
          ? const Center(
              child: SpinKitWave(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF474CA0),
                    Color(0xFF468FA0),
                  ],
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.025),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )),
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.035),
                  child: const CustomTabBar(
                      tabTitles: ["Doctor's Prescriptions", "My Prescriptions"],
                      tabViews: [DocPresContent(), MyPresContent()]),
                ),
              ),
            ),
    );
  }
}
