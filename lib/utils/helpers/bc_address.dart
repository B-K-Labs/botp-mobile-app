String shortenBcAddress(String bcAddress) =>
    bcAddress.replaceRange(10, bcAddress.length - 8, '...');
