DateTime dateTimeFromSecondsSinceEpoch(String millisecondsSinceEpoch) =>
    DateTime.fromMillisecondsSinceEpoch(int.parse(millisecondsSinceEpoch));

String shortenNotifyMessage(String notifyMessage) =>
    // Example: "[khiem20tc] Facebook need your confirmation to your account password" would be
    // "[khiem20tc] Facebook need your confirmation to you..."
    notifyMessage.length > 45
        ? notifyMessage.replaceRange(45, notifyMessage.length, '...')
        : notifyMessage;
