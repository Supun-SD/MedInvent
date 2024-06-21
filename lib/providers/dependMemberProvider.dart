import 'package:MedInvent/config/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../features/prescriptions/model/DependMember.dart';
import 'nearbyPharmaciesAndDoctorsProvider.dart';

class DependMembersState {
  final List<DependMember> dependMembers;
  final bool isLoading;

  DependMembersState({required this.dependMembers, required this.isLoading});

  factory DependMembersState.initial() {
    return DependMembersState(dependMembers: [], isLoading: false);
  }
}

class DependMembersNotifier extends StateNotifier<DependMembersState> {
  DependMembersNotifier() : super(DependMembersState.initial());

  Future<void> fetchDependentMembers(
      String userId, BuildContext context) async {
    state =
        DependMembersState(dependMembers: state.dependMembers, isLoading: true);
    final String apiUrl =
        '${ApiConfig.baseUrl}/DependMember/get/DependMembers/details/$userId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> dependMemberJson = jsonResponse['data'];
          List<DependMember> dependMembers = [];

          for (var json in dependMemberJson) {
            DependMember dm = DependMember.fromJson(json);
            dependMembers.add(dm);
          }
          state = DependMembersState(
              dependMembers: dependMembers, isLoading: false);
        }
      } else {
        throw Exception('Failed to load dependent members');
      }
    } catch (e) {
      Navigator.pop(context);
      _showSnackBar("Failed to get depend members", "error");
    } finally {
      state = DependMembersState(
          dependMembers: state.dependMembers, isLoading: false);
    }
  }

  void _showSnackBar(String text, String type) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
      ),
    );
  }
}

final dependMembersProvider =
    StateNotifierProvider<DependMembersNotifier, DependMembersState>(
        (ref) => DependMembersNotifier());
