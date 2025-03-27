import 'package:get_it/get_it.dart';
import '../logic/cubit/text_field_cubit.dart';


final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<TextFieldCubit>(TextFieldCubit());
}