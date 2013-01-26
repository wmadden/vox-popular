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

        member do
          put :start_playing_track
          put :finish_playing_track
        end

      end

    end
  end

end
