Rails.application.routes.draw do
  devise_for :users
  root "top#index"

  resources :travel_records, only: %i[new create update destroy show index edit] do
    # collectionでルート追加宣言
    collection do
      # autocompleteのルート追加
      get :autocomplete
    end
    # 関連テーブルを使用しどの記録に紐つく記録かわかるようにネスト
    resources :items
  end
    
  resources :inquiries, only: %i[new create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "/travel_records/by_date/:date", to: "travel_records#by_date", as: "travel_record_date"
  get "terms", to: "terms_of_use#index"
  get "privacy_policy", to: "privacy_policy#index"
  # ○日一覧記録のところにボタン設置。以下のルーティングは共有を受けた人がアクセスするページ。
  get "/shearing/:token", to: "shearing#index", as: "shearing"
end