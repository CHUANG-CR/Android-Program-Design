# Week 7 & Next: 狀態管理 (StatefulWidget) 與平滑動畫 (AnimatedContainer)

本週是將 Birdle 遊戲轉化為「真正動態可遊玩」的關鍵章節。學習如何將靜態元件重構為 `StatefulWidget`、掌握 `setState` 驅動畫面重繪的底層流程、管理生命週期資源釋放，以及運用隱式動畫元件 `AnimatedContainer` 實現平滑的翻牌/顏色過渡效果。

---

## 1. 從 StatelessWidget 升級為 StatefulWidget

參考程式碼：[`lib/main.dart`](./lib/main.dart)

- **概念**：
  - `StatelessWidget` 是不可變的（Immutable），一旦繪製就無法主動改變外觀。
  - `StatefulWidget` 則將狀態抽離至獨立的 `State<T>` 類別管理，當內部狀態改變時，呼叫 `setState()` 即可請求 Flutter 排程重新執行 `build()` 方法。

```dart
class GamePage extends StatefulWidget {
  GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();
  ...
}
```

---

## 2. UI 狀態更新流程 (State Mutation Cycle)

講義手繪筆記剖析：
```
1. 使用者輸入猜測單字並按下送出
         │
         ▼
2. 呼叫 _game.guess(guess) 改變內部遊戲狀態
         │
         ▼
3. setState(() { ... }) 通知 Flutter 框架：「當前元件樹已髒 (dirty)」
         │
         ▼
4. Flutter 框架於下一個繪製週期觸發 _GamePageState 的 build() 方法
         │
         ▼
5. 重新讀取 _game.guesses 最新資料，計算新的 UI 並繪製至螢幕
```

```dart
GuessInput(
  onSubmitGuess: (String guess) {
    setState(() {
      _game.guess(guess);
    });
  },
)
```

---

## 3. 控制器生命週期管理 (`dispose`)

在 Week 6 中，`TextEditingController` 與 `FocusNode` 放置於 `StatelessWidget` 中無法釋放。本週將 `GuessInput` 也升級為 `StatefulWidget`：
```dart
class _GuessInputState extends State<GuessInput> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // 元件自組件樹卸載時釋放底層原生資源，避免記憶體洩漏
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  ...
}
```

---

## 4. 動畫效果：`AnimatedContainer`

使用 Flutter 內建的隱式動畫元件 `AnimatedContainer` 取代原本靜態的 `Container`：

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 500), // 動畫過渡時間
  curve: Curves.bounceIn,                       // 彈跳動畫曲線
  height: 60,
  width: 60,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
    color: switch (hitType) {
      HitType.hit => Colors.green,
      HitType.partial => Colors.yellow,
      HitType.miss => Colors.grey,
      _ => Colors.white,
    },
  ),
  child: Center(
    child: Text(
      letter.toUpperCase(),
      style: Theme.of(context).textTheme.titleLarge,
    ),
  ),
)
```

### 動畫特性
- 當 `hitType` 發生改變時（例如從白底變成綠底），`AnimatedContainer` 會在指定的時間 (`duration: 500ms`) 內自動進行顏色的插值漸變，並套用 `Curves.bounceIn` 曲線產生生動的動態效果。

---

## 5. 執行完整版 Birdle 應用程式

你可以直接前往根目錄下的完整專案 [`birdle/`](../birdle/)：
```bash
cd birdle
flutter run
```
在 Chrome、Windows 桌面或 Android 模擬器上享受完整的拼字遊玩體驗！
