JobmeApp::Application.routes.draw do

  resources :administrators, :only => [:create, :new, :destroy]
  resources :hiring_managers, :only => [:create, :new, :destroy]
  resources :evaluators, :only => [:create, :new, :destroy]
  #resources :pages
  # resources :admin
  
  
  resources :sessions, :only => [:create, :new, :destroy]

  resources :users, :only => [:new, :create, :edit, :update, :destroy] do
    resources :references, :only => [:index, :create, :new, :show, :destroy]
  end

  resources :jobs do
    resources :jobapps do
      resources :questions, :only => [:create, :new, :edit, :update, :destroy]
      resources :applicants do
        resources :answers, :only => [:create, :new, :edit, :update, :destroy]
        resources :comments, :only => [:create, :new, :edit, :update, :destroy]
        resources :ratings, :only => [:create, :new, :destroy]
      end
    end
  end

  root :to => 'pages#index'
  
  match '/logout', :to => 'sessions#destroy'
  match '/login', :to => 'sessions#new'
  match '/jobs/:job_id/applicants/:applicant_id/resume', :to => 'applicants#resume'
  match '/jobs/:job_id/jobapps/:jobapp_id/applicants/:applicant_id/answers/:answer_id/get_attachment', :to => 'answers#get_attachment'
  match '/jobs/:job_id/jobapps/:jobapp_id/applicants/:applicant_id/answers/:answer_id/show_attachment', :to => 'answers#show_attachment'
  match '/references/:user_id/:reference_hash', :to => 'references#new'
  match '/users/:id/jobapps', :to => 'users#jobapps'
  match '/admin/users', :to => 'admin#users'
  match '/admin', :to => 'admin#index'
  match '/admin/jobs', :to => 'admin#jobs'
  match '/admin/applications', :to => 'admin#applications'
  match '/admin/ratings', :to => 'admin#ratings'
end
