import 'package:MedInvent/features/Search/data/medicines.dart';
import 'package:MedInvent/features/prescriptions/model/newPrescribeMedicine.dart';
import 'package:flutter/material.dart';

class SearchMedicine extends StatefulWidget {
  final PageController pageController;
  final NewPrescribedMedicine newMed;

  const SearchMedicine(
      {super.key, required this.pageController, required this.newMed});

  @override
  State<SearchMedicine> createState() => SearchMedicineState();
}

class SearchMedicineState extends State<SearchMedicine> {
  List displayMedicine = List.from(medicines);

  void updateMedicineList(String value) {
    setState(() {
      displayMedicine = medicines
          .where((medicine) =>
              medicine.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(screenHeight * 0.06),
          topRight: Radius.circular(screenHeight * 0.06),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 30,
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  updateMedicineList(value);
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search the medicine",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
                child: displayMedicine.isEmpty
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.2),
                        child: Text(
                          "No result found",
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01),
                          child: Column(
                            children: [
                              ...displayMedicine.map((e) {
                                return InkWell(
                                  onTap: () {
                                    widget.newMed.name = e.name;
                                    widget.pageController.animateToPage(1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: screenHeight * 0.007),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.05,
                                        vertical: screenHeight * 0.01),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE6F5FF),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(screenHeight * 0.015),
                                          child: Image.asset(
                                            "assets/images/drugs.png",
                                            height: screenHeight * 0.05,
                                          ),
                                        ),

                                        SizedBox(
                                          width: screenWidth * 0.05,
                                        ),
                                        Text(
                                          e.name,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.038),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      )

                // : ListView.builder(
                //     itemCount: displayMedicine.length * 2 - 1,
                //     itemBuilder: (context, index) {
                //       if (index.isOdd) {
                //         return const Divider(
                //           color: Colors.grey,
                //           height: 1,
                //         );
                //       }
                //       final medicineIndex = index ~/ 2;
                //
                //       return ListTile(
                //         onTap: () {
                //           widget.newMed.name = displayMedicine[index].name;
                //           widget.pageController.animateToPage(1,
                //               duration: const Duration(milliseconds: 500),
                //               curve: Curves.easeInOut);
                //         },
                //         title: Text(displayMedicine[medicineIndex].name),
                //         leading: Image.asset(
                //           "assets/images/drugs.png",
                //           height: screenHeight * 0.05,
                //         ),
                //       );
                //     },
                //   ),
                )
          ],
        ),
      ),
    );
  }
}
