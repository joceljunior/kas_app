// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StudentCreateStore on _StudentCreateStore, Store {
  late final _$loadingAtom =
      Atom(name: '_StudentCreateStore.loading', context: context);

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
      Atom(name: '_StudentCreateStore.success', context: context);

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

  late final _$crewsAtom =
      Atom(name: '_StudentCreateStore.crews', context: context);

  @override
  List<Crew> get crews {
    _$crewsAtom.reportRead();
    return super.crews;
  }

  @override
  set crews(List<Crew> value) {
    _$crewsAtom.reportWrite(value, super.crews, () {
      super.crews = value;
    });
  }

  late final _$itensCrewsAtom =
      Atom(name: '_StudentCreateStore.itensCrews', context: context);

  @override
  List<Widget> get itensCrews {
    _$itensCrewsAtom.reportRead();
    return super.itensCrews;
  }

  @override
  set itensCrews(List<Widget> value) {
    _$itensCrewsAtom.reportWrite(value, super.itensCrews, () {
      super.itensCrews = value;
    });
  }

  late final _$itensSponsorAtom =
      Atom(name: '_StudentCreateStore.itensSponsor', context: context);

  @override
  List<Widget> get itensSponsor {
    _$itensSponsorAtom.reportRead();
    return super.itensSponsor;
  }

  @override
  set itensSponsor(List<Widget> value) {
    _$itensSponsorAtom.reportWrite(value, super.itensSponsor, () {
      super.itensSponsor = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: '_StudentCreateStore.messageError', context: context);

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

  late final _$createStudentAsyncAction =
      AsyncAction('_StudentCreateStore.createStudent', context: context);

  @override
  Future<void> createStudent({required bool isEdit, required Student student}) {
    return _$createStudentAsyncAction
        .run(() => super.createStudent(isEdit: isEdit, student: student));
  }

  late final _$getCrewsAsyncAction =
      AsyncAction('_StudentCreateStore.getCrews', context: context);

  @override
  Future<void> getCrews({Student? studentEdit, int? crewId}) {
    return _$getCrewsAsyncAction
        .run(() => super.getCrews(studentEdit: studentEdit, crewId: crewId));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
success: ${success},
crews: ${crews},
itensCrews: ${itensCrews},
itensSponsor: ${itensSponsor},
messageError: ${messageError}
    ''';
  }
}
