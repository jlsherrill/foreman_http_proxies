Rails.application.routes.draw do
  scope :foreman_http_proxies, :path => '/' do
    resources :http_proxies, :controller => 'foreman_http_proxies/http_proxies'
  end

  namespace :foreman_http_proxies, path: '/foreman_http_proxies' do
    namespace :api, :defaults => { :format => 'json' } do
      scope '(:apiv)', :module => :v2, :defaults => { :apiv => 'v2' }, :apiv => /v2/,
                       :constraints => ApiConstraints.new(:version => 2) do
        resources :http_proxies, :except => [:new, :edit]
      end
    end
  end
end
