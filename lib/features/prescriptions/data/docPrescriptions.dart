import 'package:MedInvent/features/prescriptions/model/docPrescription.dart';
import 'package:MedInvent/features/prescriptions/model/prescribedMedicine.dart';

List<DocPrescription> docPrescriptions = [
  DocPrescription("Fever", "2023/12/30", "Dr Sumudu Akalanka", null, [
    PrescribedMedicine(
        "Panadol", "100mg", 2, true, "N/A", ["8.00am", "4.00pm", "12.00pm"], 5)
  ]),
  DocPrescription("Cold", "2023/12/31", "Dr. Aisha Rahman", null, [
    PrescribedMedicine(
        "Zyrtec", "10mg", 1, true, "After meals", ["9.00am", "6.00pm"], 2),
    PrescribedMedicine(
        "Vicks Vaporub", "N/A", 1, false, "External use only", ["N/A"], 3)
  ]),
  DocPrescription("Allergies", "2024/01/02", "Dr. Carlos Rodriguez", null, [
    PrescribedMedicine(
        "Claritin", "10mg", 1, true, "Before bedtime", ["10.00pm"], 7),
    PrescribedMedicine("Nasonex", "50mcg", 1, true, "N/A", ["8.00am"], 1)
  ])
];
