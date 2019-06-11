
class AppointmentService {
  static final instance = AppointmentService();

  Future getAvailableAppointments(DateTime start, DateTime end) async {
    final DateTime now = DateTime.now();
    return [
      DateTime(now.year, now.month, now.day, 13, 30, 0),
      DateTime(now.year, now.month, now.day, 14, 30, 0),
      DateTime(now.year, now.month, now.day, 15, 30, 0),
    ];
  }
}