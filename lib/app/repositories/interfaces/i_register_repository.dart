import '../../models/register.dart';

abstract class IRegisterRepository {
  Future<bool> postRegister({required List<Register> registers});
  Future<List<Register>> getRegisterByCrew({required int idCrew});
  Future<bool> updateCrew({required Register registerEdit});
  Future<bool> deleteCrew({required int idRegister});
}
