# docker-bon-mirakurun

[BonDriverProxy_Linux](https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux) + [Mirakurun](https://github.com/Chinachu/Mirakurun) のDockerイメージです。TVチューナは [PLEX PX-Q3U4](http://www.plex-net.co.jp/product/px-q3u4/) を想定しています。

録画・視聴アプリは含まれていません。EPGStation、TVTest、EDCB等、お好きなものをどうぞ。

## 動作環境

下記で動作確認しています。

* Ubuntu 18.04.1 LTS
* Docker version 19.03.6, build 369ce74a3c
* docker-compose version 1.24.1, build 4667896b

## 使い方

### 通常

    $ docker-compose build
    $ docker-compose up -d

### Mirakurunの代わりに [mirakc](https://github.com/masnagam/mirakc) を使う場合

    $ docker-compose -f docker-compose.mirakc.yml build
    $ docker-compose -f docker-compose.mirakc.yml up -d

| コンテナ | アクセス方法 |
| - | - |
| mirakurun（Mirakurun） | `http://ホスト:40772/` |
| bon（BonDriverProxy_Linux） | `ADDRESS=<ホストIPアドレス>` <br /> `PORT=1192` <br /> `BONDRIVER=/var/lib/BonDriverProxy_Linux/BonDriver_LinuxPT-??.so` <br /> ※ 上記`??` は `00` ～ `99` 。bonconfディレクトリ内のファイルを参照のこと |
| pcscd（pcscd） | なし（Mirakurun / mirakcコンテナ専用） |

* pcscdコンテナがカードリーダーを使用します。
* ホスト側で下記がインストール・実行されている必要があります。
    * [px4_drv](https://github.com/nns779/px4_drv)
        * [docker-compose.bon.yml](docker-compose.bon.yml) で、ホスト側の `/dev/px4video0` ～ `/dev/px4video7` をコンテナに渡しています。
            * `/dev/px4video4` ～ `/dev/px4video7` はコメントアウトしてあるので、PX-W3U4等の4チャンネルチューナでも動くかもしれません。動かないかもしれません。
            * `devices` の指定を `/dev/px4video0:/dev/pt3video0` → `/dev/pt3video0:/dev/pt3video0` のように書き換えれば、ひょっとしたら [PT3ドライバ](https://github.com/m-tsudo/pt3) でも動くかもしれません。動かないかもしれません。
* `/dev/px4video0` と `/dev/px4video1` がBS・CSチューナであると仮定し、LNB電源をONにしています（ちゃんと動いているかどうかは未確認）。必要に応じて、Composeファイルで定義されている環境変数 `BONDRIVERPROXY_USELNB` を変更・コメントアウトしてください。

以上