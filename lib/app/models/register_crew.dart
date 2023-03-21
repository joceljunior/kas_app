import 'package:kas_app/app/models/register.dart';

class RegisterCrew {
  final DateTime date;
  final int idCrew;
  final List<Register> registers;
  RegisterCrew({
    required this.idCrew,
    required this.date,
    required this.registers,
  });
}
