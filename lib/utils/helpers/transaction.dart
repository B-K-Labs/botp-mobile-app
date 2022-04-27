DateTime dateTimeFromSecondsSinceEpoch(String millisecondsSinceEpoch) =>
    DateTime.fromMillisecondsSinceEpoch(int.parse(millisecondsSinceEpoch));

String shortenNotifyMessage(String notifyMessage) =>
    // Example: "[khiem20tc] Facebook need your confirmation to your account password" would be
    // "[khiem20tc] Facebook need your confirmation to you..."
    notifyMessage.length > 40
        ? notifyMessage.replaceRange(40, notifyMessage.length, '...')
        : notifyMessage;
