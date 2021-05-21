# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'lists#about'
  resources :lists, only: %i[index show create new destroy] do
    collection do
      get :search, as: :search
    end

    resources :bookmarks, only: %i[new create] do
      resources :comments, only: %i[new create]
    end
  end
  resources :bookmarks, only: :destroy
end
