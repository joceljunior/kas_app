import "package:collection/collection.dart";
import 'package:get_it/get_it.dart';

import 'package:kas_app/app/controllers/interfaces/i_register_controller.dart';
import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/models/register_crew.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/app/repositories/interfaces/i_register_repository.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class RegisterController implements IRegisterController {
  final IRegisterRepository repository = GetIt.I<IRegisterRepository>();
  @override
  Future<List<RegisterCrew>> getRegisterByCrew({required int idCrew}) async {
    try {
      List<RegisterCrew> registers = [];
      var result = await repository.getRegisterByCrew(idCrew: idCrew);

      if (result.isEmpty) {
        throw RegisterError(message: "Não consta registro para esta turma!");
      }
      var group = groupBy(result, (Register reg) => reg.dateCreate);
      var list = group.forEach((key, value) {
        var i = RegisterCrew(
          date: key,
          registers: value,
          idCrew: value.first.crewId,
        );
        registers.add(i);
      });
      return registers;
    } on RegisterError catch (e) {
      throw RegisterError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postRegister({
    required List<Student> studentsRegister,
    required DateTime dateCreate,
  }) async {
    try {
      List<Register> registers = [];
      studentsRegister.forEach((e) {
        var register = Register(
            crewId: e.crew.id!,
            studentId: e.id!,
            participation: e.isRegister,
            justification: e.justification,
            dateCreate: dateCreate);
        registers.add(register);
      });
      var result = await repository.postRegister(registers: registers);
      return result;
    } on RegisterError catch (e) {
      throw RegisterError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> deleteCrew({required int idRegister}) {
    // TODO: implement deleteCrew
    throw UnimplementedError();
  }

  @override
  Future<bool> updateCrew({required Register registerEdit}) {
    // TODO: implement updateCrew
    throw UnimplementedError();
  }
}
