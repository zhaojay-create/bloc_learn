class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    // 每隔一段时间生成一个值
    return Stream.periodic(
      const Duration(seconds: 1),
      // x 是当前触发的次数，从 0 开始
      (x) => ticks - x - 1,
    ).take(ticks);
  }

  // .take
  // 	•	Stream.periodic 默认会无限触发。
  //  •	.take(ticks) 限制只取前 ticks 个值。
  //  •	比如 ticks = 5 → 只会生成 5 次，然后结束。
}
