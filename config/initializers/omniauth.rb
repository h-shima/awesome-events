Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github, "d318875036b9165d10be", "008278dace7125bb79af6b5df27b88632647b765"
  else
    provider :github,
      # app/config/credentials.yml.enc ファイルに暗号化されて保存されている
      # 以下の書き方で複合した値を取り出すことができる
      Rails.application.credentials.github[:client_id]
      Rails.application.credentials.github[:client_secret]
  end
end
