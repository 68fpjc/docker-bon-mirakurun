# docker-bon-mirakurun

[BonDriverProxy_Linux](https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux) + [Mirakurun](https://github.com/Chinachu/Mirakurun) のDockerコンテナです。TVチューナは [PLEX PX-Q3U4](http://www.plex-net.co.jp/product/px-q3u4/) を想定しています。

録画・視聴アプリは含まれていません。Chinachu、EPGStation、TVTest、EDCB等、お好きなものをどうぞ。

## 動作環境

下記で動作確認しています。

* Ubuntu 18.04.1 LTS
* Docker Engine - Community 18.09.1
* docker-compose version 1.6.2, build 4d72027

## 使い方

    docker-compose build
    docker-compose up -d

| コンテナ | アクセス方法 |
| - | - |
| mirakurun <br /> （Mirakurun） | `http://ホスト:40772/` |
| bon <br /> （BonDriverProxy_Linux） <br /> ※ 直接利用は非推奨 | `ADDRESS=<ホストIPアドレス>` <br /> `PORT=1192` <br /> `BONDRIVER=/app/driver/BonDriver_LinuxPT-??.so` <br /> ※ 上記`??` は `00` ～ `99` |

* ホスト側で下記がインストール・実行されている必要があります。
    * スマートカードリーダ + pcscd
        * ホスト側のソケットファイル（ `/var/run/pcscd/pcscd.comm` ）をコンテナに渡しています。
    * [px4_drv](https://github.com/nns779/px4_drv)
        * ホスト側の `/dev/px4video0` ～ `/dev/px4video7` をコンテナに渡しています。
            * PX-W3U4等の4チャンネルチューナの場合、 `/dev/px4video4` ～ `/dev/px4video7` をコメントアウトすれば動くかもしれません。動かないかもしれません。
            * `volumes` の指定を `/dev/px4video0:/dev/pt3video0` → `/dev/pt3video0:/dev/pt3video0` のように書き換えれば、ひょっとしたら [PT3ドライバ](https://github.com/m-tsudo/pt3) でも動くかもしれません。動かないかもしれません。
* `/dev/px4video0` と `/dev/px4video1` がBS・CSチューナであると仮定し、LNB電源をONにしています。必要に応じて、環境変数 `BONDRIVERPROXY_USELNB` を変更・コメントアウトしてください。
* コンテナmirakurunは、コンテナbonのBonDriverProxy_Linuxが起動されるまで待機します（環境変数 `MIRAKURUN_WAITFOR` で指定）。

以上
