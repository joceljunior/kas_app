import '../../models/register.dart';

abstract class IRegisterRepository {
  Future<bool> postRegister({
    required List<Register> registers,
    required bool isEdit,
  });
  Future<List<Register>> getRegisterByCrew({required int idCrew});
}
