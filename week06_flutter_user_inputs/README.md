# Week 6: Flutter 使用者輸入元件與回調機制 (Inputs & Callbacks)

本週學習如何在 Flutter 中建置文字輸入元件、控制軟體鍵盤輸入、焦點管理、按鈕事件以及跨元件的回調函式 (Callback Function)。

---

## 1. 文字輸入框 (`TextField`) 與裝飾 (`InputDecoration`)

參考程式碼：[`lib/main_input.dart`](./lib/main_input.dart)

```dart
TextField(
  maxLength: 5, // 限制最多輸入 5 個字元
  autofocus: true, // 畫面載入時自動聚焦
  decoration: const InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(35)), // 圓角外框
    ),
  ),
  controller: _textEditingController,
  focusNode: _focusNode,
  onSubmitted: (input) {
    // 監聽鍵盤 Enter / 完成鍵
  },
)
```

---

## 2. 輸入控制器與焦點管理

- **`TextEditingController`**：
  - 用來讀取或修改 `TextField` 的文字內容 (`controller.text`)。
  - 清空輸入框：`_textEditingController.clear()`。
- **`FocusNode`**：
  - 代表組件在畫面上的輸入焦點。
  - 送出猜測後重新取得焦點：`_focusNode.requestFocus()`（確保使用者不需手動重新點擊輸入框即可繼續輸入）。

---

## 3. 回調函式 (Callback Function)

在 Flutter 中，子元件常透過 Callback 將事件或數據向外傳遞給父元件：
```dart
class GuessInput extends StatelessWidget {
  const GuessInput({super.key, required this.onSubmitGuess});

  // 接收一個函式型態物件
  final void Function(String) onSubmitGuess;
  ...
}

// 在父元件 GamePage 中使用具名參數傳遞回呼函式：
GuessInput(
  onSubmitGuess: (guess) {
    print('收到猜測: $guess');
  },
)
```

---

## 4. 送出按鈕 (`IconButton`)

使用水平排列的 `Row`，將 `TextField` 透過 `Expanded` 填滿剩餘空間，右側放置一個圓形送出圖示按鈕：
```dart
IconButton(
  padding: EdgeInsets.zero,
  icon: const Icon(Icons.arrow_circle_up),
  onPressed: () {
    onSubmitGuess(_textEditingController.text.trim());
    _textEditingController.clear();
    _focusNode.requestFocus();
  },
)
```
> [!NOTE]
> 在此版本中，`GuessInput` 仍繼承自 `StatelessWidget`。當元件被銷毀時，`TextEditingController` 與 `FocusNode` 無法被手動 `dispose()` 釋放，可能會產生資源洩漏（Memory Leak）。下一週 (Week 7) 將深入探討並改進為 `StatefulWidget`。
