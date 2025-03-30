part of 'packages_cubit.dart';

abstract class PackagesState extends Equatable {
  final List<PackagesModel>? packagesList;
  final PackagesModel? package;
  final DioException? error;

  const PackagesState({this.packagesList, this.error, this.package});

  @override
  List<Object?> get props => [packagesList, error];
}

class PackagesInitialState extends PackagesState {
  const PackagesInitialState(
      {List<PackagesModel>? packagesList, DioException? error})
      : super(error: error, packagesList: packagesList);
}

class PackagesLoadedState extends PackagesState {
  const PackagesLoadedState(
      {List<PackagesModel>? packagesList, DioException? error})
      : super(error: error, packagesList: packagesList);
}

class PackagesErrorState extends PackagesState {
  const PackagesErrorState({DioException? error}) : super(error: error);
}

class PackageInitialState extends PackagesState {
  const PackageInitialState(
      {PackagesModel? package, DioException? error})
      : super(error: error, package: package);
}

class PackageLoadedState extends PackagesState {
  const PackageLoadedState(
      {PackagesModel? package, DioException? error})
      : super(error: error, package: package);
}

class PackageErrorState extends PackagesState {
  const PackageErrorState({DioException? error}) : super(error: error);
}
