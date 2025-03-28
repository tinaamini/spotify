import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/music/tabState.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState(0));

  void selectTab(int index) {
    emit(TabState(index));
  }
}