# app/services/image_preprocessor.rb
require "mini_magick"
require "stringio"

class ImagePreprocessor
  def self.call(uploaded_file)
    # uploaded_file は ActionDispatch::Http::UploadedFile
    image = MiniMagick::Image.read(uploaded_file.read)

    # ✅ 保存前加工（講師要件）
    image.resize "1200x1200>"   # 例：長辺1200pxまで縮小（小さくするだけ）
    image.format "webp"

    io = StringIO.new(image.to_blob)
    io.rewind

    io
  end
end
