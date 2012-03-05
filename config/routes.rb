JobmeApp::Application.routes.draw do

  resources :references, :only => [:create, :new, :show]
  resources :administrators, :only => [:create, :new, :destroy]
  resources :hiring_managers, :only => [:create, :new, :destroy]
  resources :evaluators, :only => [:create, :new, :destroy]
  resources :users
  resources :pages
  resources :sessions, :only => [:create, :new, :destroy]

  resources :jobs do
    resources :jobapps do
      resources :questions, :only => [:create, :new, :edit, :update, :destroy]
    end
    resources :applicants do
      resources :answers, :only => [:create, :new, :edit, :update, :destroy]
      resources :comments, :only => [:create, :new, :edit, :update, :destroy]
      resources :ratings, :only => [:create, :new, :destroy]
    end
  end

  root :to => 'pages#index'
  
  match '/logout', :to => 'sessions#destroy'
  match '/login', :to => 'sessions#new'
  match '/jobs/:job_id/applicants/:applicant_id/resume', :to => 'applicants#resume'
  match '/jobs/:job_id/applicants/:applicant_id/answers/:answer_id/get_attachment', :to => 'answers#get_attachment'
  match '/jobs/:job_id/applicants/:applicant_id/answers/:answer_id/show_attachment', :to => 'answers#show_attachment'
  match '/references/:user_id/:reference_hash', :to => 'references#new'
end
