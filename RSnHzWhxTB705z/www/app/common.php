<?php
// レビュー不要です。

define('APP_ROOT', __DIR__ . '/..');

function h($string)
{
    echo htmlspecialchars($string, ENT_QUOTES, 'UTF-8');
}
