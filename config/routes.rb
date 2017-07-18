Rails.application.routes.draw do
  delete 'attachments/:id' => 'attachments#destroy'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions do
    resources :answers, shallow: true do
      patch :set_best_answer, on: :member
    end
  end

  root to: "questions#index"
end