// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CrewListStore on _CrewListStore, Store {
  late final _$loadingAtom =
      Atom(name: '_CrewListStore.loading', context: context);

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

  late final _$crewsAtom = Atom(name: '_CrewListStore.crews', context: context);

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

  late final _$messageErrorAtom =
      Atom(name: '_CrewListStore.messageError', context: context);

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

  late final _$getCrewsAsyncAction =
      AsyncAction('_CrewListStore.getCrews', context: context);

  @override
  Future<void> getCrews() {
    return _$getCrewsAsyncAction.run(() => super.getCrews());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
crews: ${crews},
messageError: ${messageError}
    ''';
  }
}
