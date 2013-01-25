LeanBar::Application.routes.draw do

  resources :playlists do
    resources :placements
  end

end
