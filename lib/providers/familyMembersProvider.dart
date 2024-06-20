import 'dart:convert';
import 'package:MedInvent/providers/nearbyPharmaciesAndDoctorsProvider.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';

class FamilyMembersState {
  final List<FamilyMember> familyMembers;
  final bool isLoading;

  FamilyMembersState({required this.familyMembers, required this.isLoading});

  factory FamilyMembersState.initial() {
    return FamilyMembersState(familyMembers: [], isLoading: false);
  }
}

class FamilyMembersNotifier extends StateNotifier<FamilyMembersState> {
  FamilyMembersNotifier() : super(FamilyMembersState.initial());

  Future<void> getFamilyMembers(String userId) async {
    state =
        FamilyMembersState(familyMembers: state.familyMembers, isLoading: true);
    try {
      BaseClient baseClient = BaseClient();
      var response = await baseClient.get(
        '/DependMember/get/DependMembers/details/$userId',
      );
      if (response != null) {
        List<FamilyMember> familyMembers =
            FamilyMember.userDependFromJson(response);
        state =
            FamilyMembersState(familyMembers: familyMembers, isLoading: false);
      } else {
        throw Exception("Failed to get family members");
      }
    } catch (e) {
      _showErrorSnackBar('error', "Error getting family members");
    } finally {
      state = FamilyMembersState(
          familyMembers: state.familyMembers, isLoading: false);
    }
  }

  Future<void> createFamilyMember(
      FamilyMember fm, String userId, BuildContext context) async {
    state =
        FamilyMembersState(familyMembers: state.familyMembers, isLoading: true);

    try {
      BaseClient baseClient = BaseClient();
      var response = await baseClient.post(
        '/DependMember/add/new/DependMember/$userId',
        jsonEncode({
          "Fname": fm.fname,
          "Lname": fm.lname,
          "dob": fm.dob.toString().split("T")[0],
          "relationship": fm.relationship,
          "gender": fm.gender,
          "picPath": fm.picPath,
          "nic": fm.nic,
          "userID": userId
        }),
      );
      if (response != null) {
        Navigator.pop(context);
        state = FamilyMembersState(
            familyMembers: [fm, ...state.familyMembers], isLoading: false);
        _showErrorSnackBar('success', 'Family member added successfully');
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      _showErrorSnackBar('error', 'Error creating the family member');
    } finally {
      state = FamilyMembersState(
          familyMembers: state.familyMembers, isLoading: false);
    }
  }

  Future<void> deleteFamilyMember(String dependentId) async {
    state =
        FamilyMembersState(familyMembers: state.familyMembers, isLoading: true);
    try {
      BaseClient baseClient = BaseClient();
      await baseClient.delete('/DependMember/delete/DependMember/$dependentId');
      List<FamilyMember> updatedFamilyMembers = state.familyMembers
          .where((member) => member.dID != dependentId)
          .toList();
      state = FamilyMembersState(
          familyMembers: updatedFamilyMembers, isLoading: false);
      _showErrorSnackBar('success', 'Family member deleted successfully');
    } catch (e) {
      _showErrorSnackBar('error', 'Error deleting the family member');
    } finally {
      state = FamilyMembersState(
          familyMembers: state.familyMembers, isLoading: false);
    }
  }

  void _showErrorSnackBar(String type, String text) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
      ),
    );
  }
}

final familyMembersProvider =
    StateNotifierProvider<FamilyMembersNotifier, FamilyMembersState>(
        (ref) => FamilyMembersNotifier());
