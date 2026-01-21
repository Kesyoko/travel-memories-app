# requireで「mini_magick」Gem読み込み。下はstringioライブラリを読み込み。
require "mini_magick"
# メモリ上にあるバイナリデータ(string型)をファイルのように扱うため必要
require "stringio"

class ImagePreprocessor
  # 画像を加工して返す処理
  def self.call(uploaded_file)
    # 画像をMiniMagickを用いて読み込み。uploaded_file.readで投稿画像のバイナリを読み取っている。
    image = MiniMagick::Image.read(uploaded_file.read)

    # 保存する前に画像加工を行う。サイズとフォーマットを変更 「>」で小さい画像は伸ばさない。
    image.resize "1200x1200>"
    image.format "webp"

    # IO=入出力のこと。下ではイメージのバイナリデータを抜き出しioに代入。
    io = StringIO.new(image.to_blob)
    # 巻き戻しする。＝先頭に戻してる
    io.rewind

    io
  end
end
