module ForemanHttpProxies
  class HttpProxiesController < ApplicationController
    include Concerns::Parameters::HttpProxy
    include Foreman::Controller::AutoCompleteSearch
    before_filter :find_resource, :only => [:edit, :update, :destroy]

    def index
      @http_proxies = resource_base_search_and_page
    end

    def new
      @http_proxy = ForemanHttpProxies::HttpProxy.new
    end

    def create
      @http_proxy = ForemanHttpProxies::HttpProxy.new(http_proxy_params)
      if @http_proxy.save
        process_success
      else
        process_error
      end
    end

    def edit
    end

    def update
      if @http_proxy.update_attributes(http_proxy_params)
        process_success
      else
        process_error
      end
    end

    def destroy
      if @http_proxy.destroy
        process_success
      else
        process_error
      end
    end

    def resource_class
      ForemanHttpProxies::HttpProxy
    end
  end
end
