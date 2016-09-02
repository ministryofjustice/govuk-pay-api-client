Rails.application.routes.draw do
  resources :fees,
    only: [:pay, :post_pay]
end
