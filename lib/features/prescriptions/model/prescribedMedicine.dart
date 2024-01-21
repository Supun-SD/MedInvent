class PrescribedMedicine {
  String name;
  String dosage;
  int qty;
  bool isAfterMeal;
  String frequency;
  List<String> reminders;
  int daysLeft;

  PrescribedMedicine(this.name, this.dosage, this.qty, this.isAfterMeal,
      this.frequency, this.reminders, this.daysLeft);
}
