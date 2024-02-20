// ignore_for_file: avoid_function_literals_in_foreach_calls, depend_on_referenced_packages

import "package:collection/collection.dart";
import 'package:get_it/get_it.dart';

import 'package:kas_app/app/controllers/interfaces/i_register_controller.dart';
import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/app/models/student_register.dart';
import 'package:kas_app/app/repositories/interfaces/i_register_repository.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class RegisterController implements IRegisterController {
  final IRegisterRepository repository = GetIt.I<IRegisterRepository>();
  @override
  Future<List<Register>> getRegisterByCrew({required String idCrew}) async {
    try {
      List<Register> registers = [];
      var result = await repository.getRegisterByCrew(idCrew: idCrew);

      if (result.isEmpty) {
        throw RegisterError(message: "Não consta registro para esta turma!");
      }

      var group = groupBy(result, (Register reg) => reg.dateRegister);

      // Itera sobre cada grupo
      group.forEach((key, value) {
        // Cria uma lista de registros para cada grupo
        var registersForGroup = <Register>[];
        value.forEach((reg) {
          // Cria um novo registro para cada registro dentro do grupo
          reg.studentRegisters.forEach((studentRegister) {
            registersForGroup.add(Register(
                studentRegisters: [studentRegister],
                crewId: reg.crewId,
                dateRegister: key));
          });
        });
        // Adiciona os registros criados para o grupo à lista de registros principal
        registers.addAll(registersForGroup);
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
    required List<StudentRegister> studentsRegister,
    required DateTime dateRegister,
    required bool isEdit,
    required String crewId,
  }) async {
    try {
      var register = Register(
        crewId: crewId,
        studentRegisters: studentsRegister,
        dateRegister: dateRegister,
      );

      var result =
          await repository.postRegister(register: register, isEdit: isEdit);
      return result;
    } on RegisterError catch (e) {
      throw RegisterError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }
}
