FactoryGirl.define do
  factory :foreman_http_proxies_http_proxy, :class => ::ForemanHttpProxies::HttpProxy, :aliases => [:http_proxy] do
    name 'foreman_http_proxies'
    sequence(:url) { |n| "url_#{n}" }
    sequence(:port) { |n| n }
  end
end
