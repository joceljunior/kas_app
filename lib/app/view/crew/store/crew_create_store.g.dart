// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CrewCreateStore on _CrewCreateStore, Store {
  late final _$loadingAtom =
      Atom(name: '_CrewCreateStore.loading', context: context);

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

  late final _$successAtom =
      Atom(name: '_CrewCreateStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: '_CrewCreateStore.messageError', context: context);

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

  late final _$createCrewAsyncAction =
      AsyncAction('_CrewCreateStore.createCrew', context: context);

  @override
  Future<void> createCrew({required Crew crew}) {
    return _$createCrewAsyncAction.run(() => super.createCrew(crew: crew));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
success: ${success},
messageError: ${messageError}
    ''';
  }
}
