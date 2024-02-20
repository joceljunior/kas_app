import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/view/register/states/register_states.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/kas_error.dart';
import '../../../controllers/interfaces/i_register_controller.dart';

class RegisterListStore extends ValueNotifier<RegisterState> {
  RegisterListStore() : super(RegisterLoadingState());
  final IRegisterController controller = GetIt.I<IRegisterController>();

  bool loading = false;

  Future<void> getRegister({required String idCrew}) async {
    try {
      value = RegisterLoadingState();
      var result = await controller.getRegisterByCrew(idCrew: idCrew);
      value = RegisterListSuccessState(registers: result);
    } on RegisterError catch (e) {
      value = RegisterErrorState();
    } catch (e) {
      value = RegisterErrorState();
    }
  }
}
