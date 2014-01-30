Apptest::Application.routes.draw do
  root :to => "home#index"

  post '/cmd_exec' => 'home#cmd_exec'
  
end
