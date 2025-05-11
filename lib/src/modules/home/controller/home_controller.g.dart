// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$cepAtom =
      Atom(name: '_HomeControllerBase.cep', context: context);

  @override
  String get cep {
    _$cepAtom.reportRead();
    return super.cep;
  }

  @override
  set cep(String value) {
    _$cepAtom.reportWrite(value, super.cep, () {
      super.cep = value;
    });
  }

  late final _$addressFutureAtom =
      Atom(name: '_HomeControllerBase.addressFuture', context: context);

  @override
  ObservableFuture<AddressModel?>? get addressFuture {
    _$addressFutureAtom.reportRead();
    return super.addressFuture;
  }

  @override
  set addressFuture(ObservableFuture<AddressModel?>? value) {
    _$addressFutureAtom.reportWrite(value, super.addressFuture, () {
      super.addressFuture = value;
    });
  }

  late final _$addressHistoryAtom =
      Atom(name: '_HomeControllerBase.addressHistory', context: context);

  @override
  ObservableList<AddressModel> get addressHistory {
    _$addressHistoryAtom.reportRead();
    return super.addressHistory;
  }

  @override
  set addressHistory(ObservableList<AddressModel> value) {
    _$addressHistoryAtom.reportWrite(value, super.addressHistory, () {
      super.addressHistory = value;
    });
  }

  late final _$searchCepAsyncAction =
      AsyncAction('_HomeControllerBase.searchCep', context: context);

  @override
  Future<void> searchCep() {
    return _$searchCepAsyncAction.run(() => super.searchCep());
  }

  late final _$loadSavedAddressesAsyncAction =
      AsyncAction('_HomeControllerBase.loadSavedAddresses', context: context);

  @override
  Future<void> loadSavedAddresses() {
    return _$loadSavedAddressesAsyncAction
        .run(() => super.loadSavedAddresses());
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  void setCep(String value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setCep');
    try {
      return super.setCep(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cep: ${cep},
addressFuture: ${addressFuture},
addressHistory: ${addressHistory}
    ''';
  }
}
