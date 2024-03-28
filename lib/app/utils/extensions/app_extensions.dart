import 'package:flutter/material.dart';

class Extensions {}

extension ListUpdate<T> on List<T> {
  List<T> update(int pos, T t) {
    List<T> list = [];
    list.add(t);
    replaceRange(pos, pos + 1, list);
    return this;
  }
}

extension Responsive on BuildContext {
  T responsive<T>(
    T defaultVal, {
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    final wd = MediaQuery.of(this).size.width;
    return wd >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultVal)
        : wd >= 1024
            ? (lg ?? md ?? sm ?? defaultVal)
            : wd >= 768
                ? (md ?? sm ?? defaultVal)
                : wd >= 640
                    ? (sm ?? defaultVal)
                    : defaultVal;
  }
}

extension ExtendedIterable<T> on Iterable<T> {
  /// Returns a new [Iterable] containing duplicate elements.
  ///
  /// If [key] is provided, elements are considered duplicate based on the result
  /// of applying [key] to each element. If [key] is omitted, elements are
  /// considered duplicate based on their own values.
  ///
  /// Note that [Iterable] returned from this method can contain duplicate entries.
  ///
  Iterable<T> whereDuplicate<K>({K Function(T)? key}) =>
      _whereDuplicate(key ?? (i) => i);
  Iterable<T> _whereDuplicate<K>(K Function(T) key) => fold(
          (
            dups: <T>[],
            seen: <K>{},
            // (1) add item to the set 'seen'
            // (2) add item to the set 'dups' iff item is already seen
          ),
          (prev, item) => prev.seen.add(key(item))
              ? prev
              : (dups: prev.dups..add(item), seen: prev.seen)).dups;

  /// Returns a new [Iterable] containing distinct elements.
  ///
  Iterable<T> whereDistinct<K>({K Function(T)? key}) =>
      _whereDistinct(key ?? (i) => i);
  Iterable<T> _whereDistinct<K>(K Function(T) key) => fold(
          (
            distincts: <T>[],
            seen: <K>{},
            // (1) add item to the set 'seen'
            // (2) add item to the set 'distincts' iff item is not already seen
          ),
          (prev, item) => prev.seen.add(key(item))
              ? (distincts: prev.distincts..add(item), seen: prev.seen)
              : prev).distincts;

  /// Returns a new [Iterable] containing unique elements(singlicates).
  ///
  Iterable<T> whereUnique<K>({K Function(T)? key}) =>
      _whereUnique(key ?? (i) => i);
  Iterable<T> _whereUnique<K>(K Function(T) key) => fold(
          (
            unqs: <T>[],
            seen: <K>{},
            dups: {..._whereDuplicate(key).map(key)},
            // (1) add item to the set 'seen'
            // (2) add item to the set 'unqs' iff item is neither seen nor duplicate
          ),
          (p, i) => p.seen.add(key(i)) && !p.dups.contains(key(i))
              ? (unqs: p.unqs..add(i), seen: p.seen, dups: p.dups)
              : p).unqs;
}
