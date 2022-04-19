String shortenBcAddress(String bcAddress) =>
    // Example: "0xf95Bb564A60Ba1F20352dFad20D5509719Ee6757" would be "0xf95Bb5...Ee6757"
    bcAddress.length > 14
        ? bcAddress.replaceRange(8, bcAddress.length - 6, '...')
        : bcAddress;
