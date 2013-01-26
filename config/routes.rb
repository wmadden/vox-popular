LeanBar::Application.routes.draw do

  namespace :patron do
    resources :playlists do
      resources :placements
    end
  end


  namespace :venue do
    resources :playlists do
      resources :placements do
        resources :votes
      end
    end
  end

end
