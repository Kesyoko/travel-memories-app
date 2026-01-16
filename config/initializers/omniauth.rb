# getリクエストもできるようにする
# OmniAuth.config.allowed_request_methods = [:post, :get]
# getリクエストの時の警告をなくす
# OmniAuth.config.silence_get_warning = true

# Rails.application.config.middleware.use OmniAuth::Builder do
# provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
# OAuthのemailやアイコンのアクセスが求められる
# scope: 'email,profile',
# アカウントを選択する
# prompt: 'select_account',
# Googleアカウントのプロフィール画像の比率を「正方形」に設定する
# image_aspect_ratio: 'square',
# Googleのプロフィール画像のサイズを50ピクセルに設定する
# image_size: 50,
# リフレッシュトークンを取得する
# access_type: 'offline'
# }
# provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], {
#   scope: 'user:email' #OAuthのemailのアクセスが求められる
# }
# end
