String shortenBcAddress(String bcAddress) =>
    // Example: 0xf95Bb564A60Ba1F20352dFad20D5509719Ee6757 would be 0xf95Bb5...Ee6757
    bcAddress.replaceRange(10, bcAddress.length - 8, '...');
