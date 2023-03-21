// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterCreateStore on _RegisterCreateStore, Store {
  late final _$loadingAtom =
      Atom(name: '_RegisterCreateStore.loading', context: context);

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

  late final _$isEditAtom =
      Atom(name: '_RegisterCreateStore.isEdit', context: context);

  @override
  bool get isEdit {
    _$isEditAtom.reportRead();
    return super.isEdit;
  }

  @override
  set isEdit(bool value) {
    _$isEditAtom.reportWrite(value, super.isEdit, () {
      super.isEdit = value;
    });
  }

  late final _$studentsAtom =
      Atom(name: '_RegisterCreateStore.students', context: context);

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
      Atom(name: '_RegisterCreateStore.messageError', context: context);

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

  late final _$getStudentsAsyncAction =
      AsyncAction('_RegisterCreateStore.getStudents', context: context);

  @override
  Future<void> getStudents({required int idCrew}) {
    return _$getStudentsAsyncAction
        .run(() => super.getStudents(idCrew: idCrew));
  }

  late final _$getStudentsToEditAsyncAction =
      AsyncAction('_RegisterCreateStore.getStudentsToEdit', context: context);

  @override
  Future<void> getStudentsToEdit({required RegisterCrew register}) {
    return _$getStudentsToEditAsyncAction
        .run(() => super.getStudentsToEdit(register: register));
  }

  late final _$postRegisterAsyncAction =
      AsyncAction('_RegisterCreateStore.postRegister', context: context);

  @override
  Future<void> postRegister() {
    return _$postRegisterAsyncAction.run(() => super.postRegister());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
isEdit: ${isEdit},
students: ${students},
messageError: ${messageError}
    ''';
  }
}
