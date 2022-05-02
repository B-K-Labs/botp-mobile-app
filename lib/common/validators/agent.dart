String? setupAgentUrlValidator(String setupAgentUrl) =>
    Uri.tryParse(setupAgentUrl)?.hasAbsolutePath ?? false
        ? null
        : "Invalid url";
