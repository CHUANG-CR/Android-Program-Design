# Week 5: Flutter 組件樹架構與 Birdle 遊戲模型實作

本週正式進入 Birdle (仿知名拼字遊戲 Wordle) 專案的核心開發。學習 Flutter 的組件樹 (Widget Tree) 佈局架構、Android 模擬器管理、自訂 Tile 方格元件，以及撰寫純 Dart 核心遊戲邏輯。

---

## 1. 模擬器管理與執行

### 查看可用模擬器
```bash
flutter emulators
```
輸出範例：
```
1 available emulator:
Id           • Name         • Manufacturer • Platform
Medium_Phone • Medium Phone • Generic      • android
```

### 啟動特定 Android 模擬器
```bash
flutter emulators --launch Medium_Phone
```

### 載入程式至模擬器
```bash
flutter run
```

---

## 2. Flutter 主程式架構與組件樹 (Widget Tree)

Flutter 採用**宣告式 UI (Declarative UI)**，所有畫面元素皆為 Widget，彼此層層嵌套形成樹狀結構：

```
MainApp (自訂根元件)
 └─ MaterialApp (Material Design 風格容器、全域主題)
     └─ Scaffold (頁面基本骨架：AppBar、Body、Drawer 等)
         ├─ AppBar (頂部導覽列，標題 'Birdle')
         └─ Center / Padding (佈局容器)
             └─ GamePage (主遊戲畫面)
                 └─ Column (垂直排列各列猜測)
                     └─ Row (水平排列五個字母方格)
                         └─ Tile (自訂字母方格元件)
                             └─ Container (背景色、邊框)
                                 └─ Center
                                     └─ Text (字母字元)
```

---

## 3. Birdle 核心遊戲模型 (`lib/game.dart`)

參考程式碼：[`lib/game.dart`](./lib/game.dart)

### 資料結構
- **`HitType`**：列舉型態，表示單一字母的比對結果：
  - `none`：尚未比對（白色底）
  - `hit`：字母正確且位置完全吻合（綠色底）
  - `partial`：字母包含在答案中但位置不對（黃色底）
  - `miss`：字母不在答案中（灰色底）
- **`Letter`**：Dart 3 Record 型態 `({String char, HitType type})`。
- **`Word`**：實作 `IterableMixin<Letter>` 的 5 字母封裝。
- **`Game`**：遊戲狀態機，管理最大猜測次數 (`maxGuesses`)、當前目標單字 (`_wordToGuess`)、歷史猜測紀錄 (`_guesses`) 以及輸贏判定 (`didWin` / `didLose`)。

### 比對演算法重點 (`evaluateGuess`)
1. **第一輪（Hit 比對）**：優先找出位置完全吻合的字元，標記為 `Hit`，並統計未完全吻合的目標字元計數。
2. **第二輪（Partial / Miss 比對）**：針對非 Hit 的字元，檢查是否在剩餘目標字元計數中。若有則標記為 `Partial` 並將計數減一；若無則標記為 `Miss`。
> 這樣的二階段演算法能精準處理「重複字母」的比對問題（例如答案只有一個 'a'，但使用者猜了兩個 'a'，僅會有一個被標為黃色/綠色）。

---

## 4. 方格元件設計 (`Tile`)

參考程式碼：[`lib/main_tile.dart`](./lib/main_tile.dart)

使用 Dart 3 的 `switch` 表達式依據 `hitType` 決定方格顏色：
```dart
color: switch (hitType) {
  HitType.hit => Colors.green,
  HitType.partial => Colors.yellow,
  HitType.miss => Colors.grey,
  _ => Colors.white,
}
```

---

## 5. 多列棋盤排版 (`GamePage`)

參考程式碼：[`lib/main_gamepage.dart`](./lib/main_gamepage.dart)

透過集合 for 迴圈 (Collection for) 優雅展開 5 次猜測、每次 5 個方格的網格矩陣：
```dart
Column(
  spacing: 5.0,
  children: [
    for (final guess in _game.guesses)
      Row(
        spacing: 5.0,
        children: [
          for (final letter in guess) Tile(letter.char, letter.type),
        ],
      ),
  ],
)
```

---

## 6. 開發與調試工具 (Flutter DevTools)

執行 `flutter run` 時，終端機會提供 DevTools 的網址：
```
The Flutter DevTools debugger and profiler on Android SDK built for x86 is available at:
http://127.0.0.1:9101?uri=...
```
在瀏覽器打開可使用：
- **Widget Tree Inspector**：即時檢視與點選組件結構。
- **Layout Explorer**：檢查 Flex (Column / Row / Expanded) 佈局尺寸。
- **Performance Profiler**：監控畫面幀率 (FPS) 與繪製耗時。
