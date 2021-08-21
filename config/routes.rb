Rails.application.routes.draw do
  root to: 'patients#index'

  resources :patients, only: [:index, :show] do 
    resources :progress_words
    resources :visit_notes
  end
end
