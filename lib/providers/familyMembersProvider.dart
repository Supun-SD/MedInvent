import 'package:MedInvent/features/Profile/data/datasources/familyMembers.dart';
import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMembersNotifier extends StateNotifier<List<FamilyMember>> {
  FamilyMembersNotifier() : super(familyMembers);

  void addFamilyMember(FamilyMember fm) {
    state = [...state, fm];
  }
}

final familyMembersProvider =
    StateNotifierProvider<FamilyMembersNotifier, List<FamilyMember>>((ref) {
  return FamilyMembersNotifier();
});
