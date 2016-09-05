Rails.application.routes.draw do
  resources :fees do
    member do
      get :pay
      get :post_pay
    end
  end
end
