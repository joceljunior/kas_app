import '../register.dart';

abstract class IRegisterRepository {
  Future<bool> postRegister({required List<Register> registers});
  Future<List<Register>> getRegisterByCrew({required int idCrew});
}
