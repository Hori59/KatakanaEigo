Rails.application.routes.draw do
  # 管理者
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # ユーザのログイン/ログアウト機能
  devise_for :users, skip: :all
  devise_scope :user do
    # 新規登録画面表示
    get  'users/sign_up',       to: 'users/registrations#new',     as: :new_user_registration
    # 新規登録
    post 'users',               to: 'users/registrations#create',  as: :user_registration
    # ユーザ編集画面表示
    get 'users/edit', to: 'users/registrations#edit',  as: :edit_user_registration
    # ユーザ上書き
    put 'users', to: 'users/registrations#update',     as: :update_user_registration
    # ユーザ削除
    delete 'users',             to: 'users/registrations#destroy', as: :destroy_user_registration

    # ログイン画面表示
    get 'users/log_in',         to: 'users/sessions#new',          as: :new_user_session
    # ログイン
    post 'users/log_in',        to: 'users/sessions#create',       as: :user_session
    # ログアウト
    delete 'users/log_out',     to: 'users/sessions#destroy',      as: :destroy_user_session

    # パスワードをお忘れですか？の画面を表示
    get '/users/password/new',  to: 'users/passwords#new',         as: :new_user_password
    # パスワード変更メール送信
    post 'users/password',      to: 'users/passwords#create',      as: :post_user_password
    # パスワード変更画面を表示
    get '/users/password/edit', to: 'users/passwords#edit',        as: :edit_user_password
    # パスワードを変更
    patch '/users/password',    to: 'users/passwords#update',      as: :user_password
  end

  # ルート設定
  root 'words#index'
  # アバウトページ
  get 'about' => 'words#about'

  # ワード周辺機能
  resources :words do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  # ユーザ周辺機能
  resources :users, only: [:show]
  # ユーザ復活機能後回し
  # patch '/users/restore', to: 'users#restore', as: :user_restore

  # 問合せ機能
  get 'contact' => 'contact#index' # 入力画面
  post 'contact/confirm' => 'contact#confirm' # 確認画面
  post 'contact/thanks' => 'contact#thanks' # 送信完了画面
  get 'search' => 'words#search' # 検索機能
end
