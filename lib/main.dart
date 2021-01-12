import 'package:flutter/material.dart';

// ポイント1
// pubspec.yamlの以下の場所に  flutter_hooks: ^0.15.0、
// hooks_riverpod: ^0.12.1を追記(インデント注意)
// dependencies:
//   flutter:
//     sdk: flutter
//   flutter_hooks: ^0.15.0
//   hooks_riverpod: ^0.12.1

// ポイント2
// main.dartに以下の2行を追加してパッケージを使えるようにする
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(
    // ポイント3
    // MyApp()をProviderScopeで包む
    ProviderScope(child: MyApp()),
  );
}

// ポイント4
// 引数を以下のようにしてStateProviderオブジェクトを
// 生成してstringStateProviderに入れる
final stringStateProvider = 
  StateProvider((ref) => 'Hello world');

// ポイント5
// HookWidgetを継承する
class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {

    // 動作確認用1
    print("buildメソッド");

    // ポイント6
    // useProvider(stringStateProvider)で
    // オブジェクトを生成してstringstateに入れる
    // buildメソッドの中に書くこと
    final stringstate = useProvider(stringStateProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Change Hello world'),
        ),
        body: Center(

          // ポイント7
          // stringstate.stateで文字列を取り出す
          child: Text(stringstate.state),

        ),
        floatingActionButton: FloatingActionButton(
          
          // ボタンを押したとき
          onPressed: () {

            // ポイント8
            // stringstate.stateで新しい文字列を入れる
            stringstate.state = "こんにちは世界";
            // ポイント4のところで
            // Provider((ref) => 'Hello world');を
            // 使っていた場合、こんな感じで
            // Hello worldを更新することができない

            // 動作確認用2
            print("ボタン押下");

          },
        ),
      ),
    );
  }
}
