import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_tips/data/models/module.dart';
import 'package:photo_tips/data/network_exception.dart';
import 'package:photo_tips/data/repositories/module_repository.dart';

part 'module_state.dart';
part 'module_cubit.freezed.dart';

class ModuleCubit extends Cubit<ModuleState> {
  final ApiModuleRepository _moduleRepository;

  ModuleCubit(this._moduleRepository) : super(ModuleState.initial());

  Future<void> getAllModules() async {
    try {
      emit(ModuleState.loading());
      final modules = await _moduleRepository.fetchAllModules();

      modules.sort((a,b)=>a.indexNumber.compareTo(b.indexNumber));
      modules.forEach((module) { 
        module.entries.sort((a,b)=>a.indexNumber.compareTo(b.indexNumber));
        module.entries.forEach((entry) {
          entry.textLecture.sort((a,b)=>a.indexNumber.compareTo(b.indexNumber));
          entry.videoLecture.sort((a,b)=>a.indexNumber.compareTo(b.indexNumber));
         });
      });
      
      emit(ModuleState.loaded(modules));
    } on NetworkException {
      emit(ModuleState.error("Не удалось загрузить модули"));
    }
  }
}
