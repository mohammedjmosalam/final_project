part of 'chatting_cubit.dart';

class ChattingState extends Equatable {
  const ChattingState({
    required this.massageController,
    required this.streamChattingController,
  });
  final TextEditingController massageController;
  final StreamController<List<ChatModel>> streamChattingController;
  ChattingState copyWith({
    TextEditingController? massageController,
    StreamController<List<ChatModel>>? streamChattingController,
  }) =>
      ChattingState(
        massageController: massageController ?? this.massageController,
        streamChattingController:
            streamChattingController ?? this.streamChattingController,
      );
  @override
  List<Object> get props => [
        massageController,
        streamChattingController,
      ];
}
