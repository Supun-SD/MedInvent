import 'package:MedInvent/features/Profile/presentation/main_profile.dart';
import 'package:MedInvent/features/Register/presentation/pages/landing_page.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_1.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_2.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_3.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_4.dart';
import 'package:MedInvent/features/home/presentation/home.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_1.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_2.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_3.dart';
import 'package:MedInvent/features/prescriptions/presentation/NewPrescription_1.dart';
import 'package:MedInvent/features/prescriptions/presentation/prescriptionDetails.dart';
import 'package:MedInvent/features/prescriptions/presentation/prescription_1.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(routes: [
    GoRoute(
        name: 'landing',
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Landing());
        }),
    GoRoute(
        name: 'login',
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        }),
    GoRoute(
        name: 'register1',
        path: '/register1',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Register1());
        }),
    GoRoute(
        name: 'register2',
        path: '/register2',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Register2());
        }),
    GoRoute(
        name: 'register3',
        path: '/register3',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Register3());
        }),
    GoRoute(
        name: 'register4',
        path: '/register4',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Register4());
        }),
    GoRoute(
        name: 'forgotPassword1',
        path: '/forgotPassword1',
        pageBuilder: (context, state) {
          return const MaterialPage(child: PasswordReset1());
        }),
    GoRoute(
        name: 'forgotPassword2',
        path: '/forgotPassword2',
        pageBuilder: (context, state) {
          return const MaterialPage(child: PasswordReset2());
        }),
    GoRoute(
        name: 'forgotPassword3',
        path: '/forgotPassword3',
        pageBuilder: (context, state) {
          return const MaterialPage(child: PasswordReset3());
        }),
    GoRoute(
        name: 'home',
        path: '/home',
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        }),
    GoRoute(
        name: 'prescriptions',
        path: '/prescriptions',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Prescriptions());
        }),
    // GoRoute(
    //     name: 'appointments',
    //     path: '/appointments',
    //     pageBuilder: (context, state) {
    //       return const MaterialPage(child:);
    //     }),
    // GoRoute(
    //     name: 'map',
    //     path: '/map',
    //     pageBuilder: (context, state) {
    //       return const MaterialPage(child:);
    //     }),
    // GoRoute(
    //     name: 'search',
    //     path: '/search',
    //     pageBuilder: (context, state) {
    //       return const MaterialPage(child:);
    //     }),
    // GoRoute(
    //     name: 'newsFeed',
    //     path: '/newsFeed',
    //     pageBuilder: (context, state) {
    //       return const MaterialPage(child:);
    //     }),
    GoRoute(
        name: 'profile',
        path: '/profile',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ProfilePage());
        }),
    GoRoute(
        name: 'prescriptionDetails',
        path: '/prescriptionDetails',
        pageBuilder: (context, state) {
          return const MaterialPage(child: PrescriptionDetails());
        }),
    GoRoute(
        name: 'newPrescription',
        path: '/newPrescription',
        pageBuilder: (context, state) {
          return const MaterialPage(child: NewPrescription());
        }),
  ]);
}
