// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$loadingAtom = Atom(name: '_HomeStore.loading', context: context);

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

  late final _$crewTotalAtom =
      Atom(name: '_HomeStore.crewTotal', context: context);

  @override
  int? get crewTotal {
    _$crewTotalAtom.reportRead();
    return super.crewTotal;
  }

  @override
  set crewTotal(int? value) {
    _$crewTotalAtom.reportWrite(value, super.crewTotal, () {
      super.crewTotal = value;
    });
  }

  late final _$studentTotalAtom =
      Atom(name: '_HomeStore.studentTotal', context: context);

  @override
  int? get studentTotal {
    _$studentTotalAtom.reportRead();
    return super.studentTotal;
  }

  @override
  set studentTotal(int? value) {
    _$studentTotalAtom.reportWrite(value, super.studentTotal, () {
      super.studentTotal = value;
    });
  }

  late final _$getTotalsAsyncAction =
      AsyncAction('_HomeStore.getTotals', context: context);

  @override
  Future<void> getTotals() {
    return _$getTotalsAsyncAction.run(() => super.getTotals());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
crewTotal: ${crewTotal},
studentTotal: ${studentTotal}
    ''';
  }
}
