// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  late final _$loadingAtom =
      Atom(name: '_LoginStore.loading', context: context);

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

  late final _$sessionAtom =
      Atom(name: '_LoginStore.session', context: context);

  @override
  Session? get session {
    _$sessionAtom.reportRead();
    return super.session;
  }

  @override
  set session(Session? value) {
    _$sessionAtom.reportWrite(value, super.session, () {
      super.session = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: '_LoginStore.messageError', context: context);

  @override
  String get messageError {
    _$messageErrorAtom.reportRead();
    return super.messageError;
  }

  @override
  set messageError(String value) {
    _$messageErrorAtom.reportWrite(value, super.messageError, () {
      super.messageError = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginStore.login', context: context);

  @override
  Future<void> login({required User user}) {
    return _$loginAsyncAction.run(() => super.login(user: user));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
session: ${session},
messageError: ${messageError}
    ''';
  }
}
