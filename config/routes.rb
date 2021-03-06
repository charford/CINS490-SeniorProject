JobmeApp::Application.routes.draw do
  resources :references, :only => [:new,:create]
  resources :administrators, :only => [:create, :destroy]
  resources :hiring_managers, :only => [:create, :destroy]
  resources :evaluators, :only => [:create, :destroy]
  resources :sessions, :only => [:create, :new, :destroy]
  resources :reset_requests, :only => [:destroy]
  resources :confirmations, :only => [:destroy]

  #resources :users, :only => [:new, :create, :edit, :update, :destroy, :show] do
  resources :users do
    resources :references, :only => [:index, :show, :destroy]
  end

  resources :jobs do
    resources :jobapps do
      resources :questions, :only => [:destroy]
      resources :applicants do
        resources :answers, :only => [:destroy]
        resources :additional_facts, :only => [:create, :edit, :update, :destroy]
        resources :ratings, :only => [:create, :destroy, :edit,:update]
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
  match '/admin/confirmations', :to => 'admin#confirmations'
  match '/admin', :to => 'admin#index'
  match '/admin/jobs', :to => 'admin#jobs'
  match '/admin/applicants', :to => 'admin#applicants'
  match '/admin/ratings', :to => 'admin#ratings'
  match '/admin/permissions', :to => 'admin#permissions'
  match '/admin/additional_facts', :to => 'admin#additional_facts'
  match '/admin/reset_requests', :to => 'admin#reset_requests'
  match '/users/:id/deactivate', :to => 'users#deactivate'
  match '/users/:id/activate', :to => 'users#activate'
  match '/users/:id/confirm/:confirm_hash', :to => 'users#confirm'
  match '/reset/:request_hash', :to => 'users#resetpw'
  match '/forgotpw', :to => 'users#forgotpw'
  match '/:user_id/request_reference', :to => 'users#request_reference'
  match '/jobs/:job_id/jobapps/:jobapp_id/applicants/:applicant_id/references/:reference_id/show_attachment', :to => 'references#show_attachment'
  match '/jobs/:job_id/jobapps/:jobapp_id/applicants/:applicant_id/references/:reference_id/get_attachment', :to => 'references#get_attachment'

end
