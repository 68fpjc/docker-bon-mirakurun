# Mirakurun Dockerfile

## ベースDockerイメージ

[keymetrics/pm2](https://hub.docker.com/r/keymetrics/pm2)

## コンポーネント

* [Mirakurun](https://github.com/Chinachu/Mirakurun)
* [arib-b25-stream-test](https://www.npmjs.com/package/arib-b25-stream-test)
* [BonDriverProxy_Linux](https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux) （クライアントのみ）

## 環境変数

| 名前 | 説明 |
| - | - |
| `MIRAKURUN_WAITFOR` | `host:port` のように指定すると、指定のポートとポートにアクセスできるまでMirakurunの起動を待機します。無指定の場合は待機しません。 |

## 注意

[docker-bon-mirakurun](../) 以外での用途については、あまり考慮していません。

以上