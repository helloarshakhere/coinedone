import 'package:bloc/bloc.dart';
import 'package:coinedone/apifetchservice.dart';
import 'package:coinedone/model/freetime.dart';
import 'package:meta/meta.dart';

part 'userdataget_event.dart';
part 'userdataget_state.dart';

class UserdatagetBloc extends Bloc<UserdatagetEvent, UserdatagetState> {
  final _data = apifetchdata();
  UserdatagetBloc() : super(LoadingState()) {
    on<UserdatagetEvent>((event, emit) async {
      if (event is LoadEvent) {
        emit(LoadingState());
        try {
          final _userdata = await _data.getdata();
          emit(LoadedState(userdataval: _userdata));
        } catch (err) {
          emit(FailToload(err: err.toString()));
        }
      }
      // TODO: implement event handler
    });
  }
}
