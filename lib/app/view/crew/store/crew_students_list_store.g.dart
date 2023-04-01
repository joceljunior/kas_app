// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_students_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CrewStudentsListStore on _CrewStudentsListStore, Store {
  late final _$loadingAtom =
      Atom(name: '_CrewStudentsListStore.loading', context: context);

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

  late final _$studentsAtom =
      Atom(name: '_CrewStudentsListStore.students', context: context);

  @override
  List<Student> get students {
    _$studentsAtom.reportRead();
    return super.students;
  }

  @override
  set students(List<Student> value) {
    _$studentsAtom.reportWrite(value, super.students, () {
      super.students = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: '_CrewStudentsListStore.messageError', context: context);

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

  late final _$getStudentsByCrewAsyncAction =
      AsyncAction('_CrewStudentsListStore.getStudentsByCrew', context: context);

  @override
  Future<void> getStudentsByCrew({required int idCrew}) {
    return _$getStudentsByCrewAsyncAction
        .run(() => super.getStudentsByCrew(idCrew: idCrew));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
students: ${students},
messageError: ${messageError}
    ''';
  }
}
