// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterListStore on _RegisterListStore, Store {
  late final _$loadingAtom =
      Atom(name: '_RegisterListStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$registersAtom =
      Atom(name: '_RegisterListStore.registers', context: context);

  @override
  List<RegisterCrew> get registers {
    _$registersAtom.reportRead();
    return super.registers;
  }

  @override
  set registers(List<RegisterCrew> value) {
    _$registersAtom.reportWrite(value, super.registers, () {
      super.registers = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: '_RegisterListStore.messageError', context: context);

  @override
  String? get messageError {
    _$messageErrorAtom.reportRead();
    return super.messageError;
  }

  @override
  set messageError(String? value) {
    _$messageErrorAtom.reportWrite(value, super.messageError, () {
      super.messageError = value;
    });
  }

  late final _$getRegisterAsyncAction =
      AsyncAction('_RegisterListStore.getRegister', context: context);

  @override
  Future<void> getRegister({required int idCrew}) {
    return _$getRegisterAsyncAction
        .run(() => super.getRegister(idCrew: idCrew));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
registers: ${registers},
messageError: ${messageError}
    ''';
  }
}
