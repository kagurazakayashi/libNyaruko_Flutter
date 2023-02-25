library libnyaruko_flutter;

typedef NotificationFunction = Function(dynamic object);

/// 通知中心：用於跨組件通信
class NotificationCenter {
  final Map<String, NotificationFunction> _notifications = <String, NotificationFunction>{};
  // 單例，用靜態例項化一個類物件。
  static final NotificationCenter instance = NotificationCenter._internal();
  // 工廠方法，獲取該類的例項，將例項物件對應的方法返回出去
  factory NotificationCenter() {
    return instance;
  }
  // 透過私有方法隱藏構造方法，防止被誤建立
  NotificationCenter._internal() {
    // 此處進行初始化操作
  }

  /// 檢查是否有觀察者 [postName]
  static bool has(String postName) {
    return NotificationCenter.instance._notifications.containsKey(postName);
  }

  /// 添加 [postName] 觀察者，[object] 為觀察者方法
  static bool add(String postName, NotificationFunction object) {
    Map<String, dynamic Function(dynamic)> notifications = NotificationCenter.instance._notifications;
    if (notifications.containsKey(postName)) {
      return false;
    }
    NotificationCenter.instance._notifications[postName] = object;
    return true;
  }

  /// 移除 [postName] 觀察者
  static bool remove(String postName) {
    Map<String, dynamic Function(dynamic)> notifications = NotificationCenter.instance._notifications;
    if (notifications.containsKey(postName)) {
      NotificationCenter.instance._notifications.remove(postName);
      return true;
    }
    return false;
  }

  /// 發送 [postName] 通知，[object] 為通知參數，[remove] 為是否發送後移除觀察者，[isAsync] 為是否為異步
  static bool post(String postName, {dynamic object, bool remove = false, bool isAsync = false}) {
    Map<String, dynamic Function(dynamic)> notifications = NotificationCenter.instance._notifications;
    if (notifications.containsKey(postName)) {
      if (isAsync) {
        Future<dynamic>.delayed(Duration.zero, () {
          notifications[postName]!(object);
          if (remove) {
            NotificationCenter.instance._notifications.remove(postName);
          }
        });
      } else {
        notifications[postName]!(object);
        if (remove) {
          NotificationCenter.instance._notifications.remove(postName);
        }
      }
      return true;
    }
    return false;
  }
}
