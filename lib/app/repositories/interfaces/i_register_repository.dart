import '../../models/register.dart';

abstract class IRegisterRepository {
  Future<bool> postRegister({
    required Register register,
    required bool isEdit,
  });
  Future<List<Register>> getRegisterByCrew({required String idCrew});
}
