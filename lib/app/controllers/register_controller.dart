import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_register_controller.dart';
import 'package:kas_app/app/models/interfaces/i_register_repository.dart';
import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class RegisterController implements IRegisterController {
  final IRegisterRepository repository = GetIt.I<IRegisterRepository>();
  @override
  Future<List<Register>> getRegisterByCrew({required int idCrew}) {
    // TODO: implement getRegisterByCrew
    throw UnimplementedError();
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
}
