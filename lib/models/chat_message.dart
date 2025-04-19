class ChatMessage {
  final String original;
  final String corrected;
  final String concise;
  final bool isUser;

  ChatMessage({
    required this.original,
    required this.corrected,
    required this.concise,
    required this.isUser,
  });
}