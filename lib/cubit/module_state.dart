part of 'module_cubit.dart';

@freezed
abstract class ModuleState with _$ModuleState {
  const factory ModuleState.initial() = ModuleInitial;
  const factory ModuleState.loading() = ModuleLoading;
  const factory ModuleState.loaded(List<Module> modules) = ModuleLoaded;
  const factory ModuleState.error(String message) = ModuleError;
}