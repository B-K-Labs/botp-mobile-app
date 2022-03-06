// API endpoints

// Server
// 1. Development: replace by Wi-fi ip, which can be viewed in cmd > ipconfig
// 2. Production: your public url
const _server = "192.168.33.15";
const _port1 = "9000";
const _port2 = "9090";
const _basePath = "api/v1";
const _urlRoot1 = "http://$_server:$_port1/$_basePath";
const _urlRoot2 = "http://$_server:$_port2/$_basePath";

// Using urls
const urlSignUp = "$_urlRoot1/signup";
const urlSignIn = "$_urlRoot1/import";
