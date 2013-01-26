LeanBar::Application.routes.draw do

  namespace :patron do
    resources :playlists do
      resources :placements do
        member do
          post :upvote
          post :dismiss
        end
      end
    end
  end


  namespace :venue do
    resources :playlists do

      resources :placements do

        member do
          put :start_playing_track
          put :finish_playing_track
        end

      end

    end
  end

end
