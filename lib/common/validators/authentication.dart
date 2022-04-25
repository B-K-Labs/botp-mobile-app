// Blockchain address
String? bcAddressValidator(String? bcAddress) =>
    bcAddress == null || bcAddress.isEmpty
        ? "Missing blockchain address"
        : null;

// Private key
String? privateKeyValidator(String? privateKey) =>
    privateKey == null || privateKey.isEmpty ? "Missing private key" : null;

// Password
String? passwordStrictValidator(String? password) => password == null ||
        password.isEmpty
    ? "Missing password"
    : password.length < 6
        ? "Password must be at least 6 characters"
        : RegExp(r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\`\~\!\@\#\$\%\^\&\*\(\)\-\_\=\+\[\{\]\}\\\|\;\:\'\"\,\<\.\>\/\?]).{6,}$''')
                .hasMatch(password)
            ? null
            : "Must contain one uppercase, lowercase, digit, and special character";

String? passwordNormalValidator(String? password) =>
    password == null || password.isEmpty ? "Missing password" : null;
