import 'package:MedInvent/features/prescriptions/data/myPrescriptions.dart';
import 'package:MedInvent/features/prescriptions/model/myPrescription.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPrescriptionsNotifier extends StateNotifier<List<MyPrescription>> {
  MyPrescriptionsNotifier() : super(myPrescriptions);

  void addNewMyPrescription(MyPrescription myPrescription) {
    state = [...state, myPrescription];
  }
}

final myPrescriptionsProvider =
    StateNotifierProvider<MyPrescriptionsNotifier, List<MyPrescription>>((ref) {
  return MyPrescriptionsNotifier();
});
