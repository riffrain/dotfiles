<?php

/**
 * hogehoge
 * hugahugahu
 *
 * hgoehroehgore
 *
 */
class Hoge
{
  /**
   * 説明分
   *
   * @param bool $hoge
   * @return bool
   */
  public function foobar(bool $hoge): bool
  {
    return !$hoge;
  }
}

$hoge = new Hoge();

$hoge->foobar(true);

array_map(
  function () {
  },
  []
);
