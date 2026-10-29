# Week 1: Flutter 環境建置與 Dart 基礎入門

本週為課程起始週，核心目標是完成 Flutter 開發環境安裝、熟悉 VS Code 開發工具、建立第一個 Flutter 專案，並學習 Dart 程式語言的基本語法與函式呼叫。

---

## 1. 安裝 Flutter SDK

官方安裝文件：[Flutter Quick Install](https://docs.flutter.dev/learn/pathway/quick-install)

### 安裝步驟
1. **VS Code 擴充套件**：
   - 開啟 VS Code，點選左側「擴充套件 (Extensions)」（快捷鍵 `Ctrl + Shift + X`）。
   - 搜尋 `Flutter`，點擊「安裝 (Install)」（會一併自動安裝 Dart 擴充套件）。
2. **下載 Flutter SDK**：
   - 按 `Ctrl + Shift + P` 開啟命令面板 (Command Palette)。
   - 輸入 `flutter`，選擇 **Flutter: Create New Project**。
   - 點擊提示對話框中的 **Download SDK**。
3. **選擇安裝目錄**：
   - 在跳出的資料夾選取器中，選擇存放 Flutter SDK 的目錄（例如 `flutter_sdk`），點擊 **Clone Flutter**。
   - VS Code 會自動從 GitHub 下載 Flutter SDK。
4. **加入系統環境變數 (PATH)**：
   - 下載完成後，點擊右下角彈出視窗的 **Add SDK to PATH**（將 SDK 新增至 PATH）。
5. **環境驗證**：
   - 重新啟動 VS Code，開啟內建終端機（Terminal）。
   - 執行檢測命令：
     ```bash
     flutter doctor
     ```
   - 確認 Android SDK、Chrome、VS Code 等開發相依套件狀態。

---

## 2. 建立第一個 Flutter 專案 (`birdle`)

官方教學：[Create an App Pathway](https://docs.flutter.dev/learn/pathway/tutorial/create-an-app)

### 指令與操作流程
```bash
# 建立一個乾淨無樣板的空專案
flutter create birdle --empty

# 進入專案資料夾
cd birdle

# 啟動應用程式
flutter run
```

### 選擇執行目標裝置
執行 `flutter run` 後，Flutter 會列出目前可用的執行裝置，例如：
- `[1]: Windows (windows)`
- `[2]: Chrome (web)`
- `[3]: Edge (edge)`
- 或已連接的 Android 模擬器 / 實體機

### 終端機常用互動指令
- `r`：**Hot Reload**（熱重載，快速套用程式碼變更，保持狀態）
- `R`：**Hot Restart**（熱重啟，重新載入程式碼並重設狀態）
- `h`：列出所有可用互動指令 (Help)
- `d`：Detach（與偵錯工作階段分離，應用程式繼續在裝置上執行）
- `c`：清除終端機畫面
- `q`：結束執行 (Quit)

### 體驗熱重載 (Hot Reload)
1. 用 VS Code 開啟 `birdle` 目錄。
2. 開啟 `lib/main.dart`。
3. 將畫面中的文字改成 `'Hello Stust!!'`（參考 [`main_empty.dart`](./main_empty.dart)）。
4. 在執行中的終端機按下 `r`，即可在數毫秒內看到畫面即時更新。

---

## 3. Dart 語言基礎語法

線上即時執行工具：[DartPad](https://dartpad.dev/)

### (1) 變數與字串插值 (String Interpolation)
參考程式碼：[`hello_world.dart`](./hello_world.dart)
```dart
void main() {
  const version = '0.0.1';
  print('Version: $version');
}
```
- `void main()`：Dart 程式的唯一起始進入點。
- `const`：編譯時期常數，賦值後不可變更。
- `$version`：字串插值語法，將變數值嵌入字串中。

### (2) 函式定義與呼叫
參考程式碼：[`function_basics.dart`](./function_basics.dart)
```dart
void printVersion(String version) {
  print('Version: $version');
}

void main() {
  const version = '0.2';
  printVersion(version);
}
```
- 函式語法結構：`回傳型態 函式名稱(參數型態 參數名稱) { ... }`
- 此處 `void` 代表無回傳值，接受一個 `String` 參數。
