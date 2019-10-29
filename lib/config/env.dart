class Env {
  static bool IS_DEVELOPMENT = true; // 是否为开发环境
  factory Env() => _getInstance();
  static Env get instance => _getInstance();
  static Env _instance;// 单例
  Env._internal() {
    // 初始化
  }
  static Env _getInstance() {
    if (_instance == null) {
      _instance = new Env._internal();
    }
    return _instance;
  }
}