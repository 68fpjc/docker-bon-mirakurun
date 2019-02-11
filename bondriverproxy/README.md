# BonDriverProxy_Linux Dockerfile

## ベースDockerイメージ

[keymetrics/pm2](https://hub.docker.com/r/keymetrics/pm2)

## コンポーネント

* [BonDriverProxy_Linux](https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux) （サーバのみ）

## 環境変数

| 名前 | 説明 |
| - | - |
| `BONDRIVERPROXY_USELNB` | `0,1` のように、LNB電源を有効にするデバイス番号をカンマ区切りで指定します（BonDriverProxy_LinuxPT*.so.confの `USELNB=` を書き換えます）。 |

## 注意

* [docker-bon-mirakurun](../) 以外での用途については、あまり考慮していません。

以上