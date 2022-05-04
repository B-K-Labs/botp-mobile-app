DateTime dateTimeFromSecondsSinceEpoch(String millisecondsSinceEpoch) =>
    DateTime.fromMillisecondsSinceEpoch(int.parse(millisecondsSinceEpoch));

String shortenNotifyMessage(String notifyMessage) {
  // Example: "[khiem20tc] Facebook need your confirmation to your account password" would be
  // "[khiem20tc] Facebook need your confirmation to you..."
  final String puredNotifyMessage =
      notifyMessage.replaceAll("\n", "").replaceAll("\t", "");
  const int maxLength = 35;
  return puredNotifyMessage.length > maxLength
      ? puredNotifyMessage.replaceRange(
          maxLength, puredNotifyMessage.length, '...')
      : puredNotifyMessage;
}
