#XXX: Some routes are probably missing (gw0)

RedmineApp::Application.routes.draw do
	match '/surveys/index', :to => 'surveys#index', :via => [:get, :post]
	match '/surveys/new', :to => 'surveys#new', :via => [:get, :post]
	match '/surveys/create', :to => 'surveys#create', :via => [:get, :post]
	match '/surveys/edit', :to => 'surveys#edit', :via => [:get, :post]
	match '/surveys/update', :to => 'surveys#update', :via => [:get, :post, :put]
	match '/surveys/show', :to => 'surveys#show', :via => [:get, :post] #?
	match '/surveys/results', :to => 'surveys#results', :via => [:get, :post] #_result
	match '/surveys/download', :to => 'surveys#download', :via => [:get, :post] #?
	match '/surveys/respond', :to => 'surveys#respond', :via => [:get, :post, :put]
	match '/surveys/preview', :to => 'surveys#preview', :via => [:get, :post]  #_preview
	match '/surveys/destroy', :to => 'surveys#destroy', :via => [:get, :post]  #?
end

