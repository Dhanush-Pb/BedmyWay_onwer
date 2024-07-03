import 'package:bloc/bloc.dart';
import 'package:hotelonwer/model/mesage_model.dart';
import 'package:hotelonwer/repositoires/message_repository.dart';
import 'package:meta/meta.dart';

part 'scoketmsg_event.dart';
part 'scoketmsg_state.dart';

class ScoketmsgBloc extends Bloc<ScoketmsgEvent, ScoketmsgState> {
  final MessageRepository _messageRepository;
  ScoketmsgBloc({required MessageRepository messageRepository})
      : _messageRepository = messageRepository,
        super(ScoketmsgInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
  }

  void _onSendMessage(
      SendMessageEvent event, Emitter<ScoketmsgState> emit) async {
    try {
      await _messageRepository.sendMessage(event.message, event.userId);
      emit(SendMessageSuccessState());
    } catch (e) {
      emit(SendMessageFailureState(error: e.toString()));
    }
  }

  void _onReceiveMessage(
      ReceiveMessageEvent event, Emitter<ScoketmsgState> emit) async {
    try {
      await _messageRepository.storeReceivedMessage(
          event.message, event.userId);
      emit(ReceiveMessageSuccessState());
    } catch (e) {
      emit(ReceiveMessageFailureState(error: e.toString()));
    }
  }
}
