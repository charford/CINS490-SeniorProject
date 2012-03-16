JobmeApp::Application.routes.draw do

  resources :administrators, :only => [:create, :destroy]
  resources :hiring_managers, :only => [:create, :destroy]
  resources :evaluators, :only => [:create, :destroy]
  #resources :pages
  # resources :admin
  
  
  resources :sessions, :only => [:create, :new, :destroy]

  resources :users, :only => [:new, :create, :edit, :update, :destroy, :show] do
    resources :references, :only => [:index, :create, :new, :show, :destroy]
  end

  resources :jobs do
    resources :jobapps do
      resources :questions, :only => [:destroy]
      resources :applicants do
        resources :answers, :only => [:destroy]
        resources :comments, :only => [:create, :edit, :update, :destroy]
        resources :ratings, :only => [:create, :destroy]
      end
    end
  end

  root :to => 'pages#index'
  
  match '/logout', :to => 'sessions#destroy'
  match '/login', :to => 'sessions#new'
  match '/signup', :to => 'users#new'
  match '/jobs/:job_id/applicants/:applicant_id/resume', :to => 'applicants#resume'
  match '/jobs/:job_id/jobapps/:jobapp_id/applicants/:applicant_id/answers/:answer_id/get_attachment', :to => 'answers#get_attachment'
  match '/jobs/:job_id/jobapps/:jobapp_id/applicants/:applicant_id/answers/:answer_id/show_attachment', :to => 'answers#show_attachment'
  match '/references/:user_id/:reference_hash', :to => 'references#new'
  match '/users/:id/jobapps', :to => 'users#jobapps'
  match '/admin/users', :to => 'admin#users'
  match '/admin', :to => 'admin#index'
  match '/admin/jobs', :to => 'admin#jobs'
  match '/admin/applicants', :to => 'admin#applicants'
  match '/admin/ratings', :to => 'admin#ratings'
  match '/admin/permissions', :to => 'admin#permissions'
  match '/users/:user_id/deactivate', :to => 'users#deactivate'

end
