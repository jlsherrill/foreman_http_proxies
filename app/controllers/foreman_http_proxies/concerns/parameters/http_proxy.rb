module ForemanHttpProxies
  module Concerns
    module Parameters
      module HttpProxy
        extend ActiveSupport::Concern

        class_methods do
          def http_proxy_params_filter
            Foreman::ParameterFilter.new(::ForemanHttpProxies::HttpProxy).tap do |filter|
              filter.permit_by_context :id, :name, :url, :port, :username, :password, :nested => true
            end
          end
        end

        def http_proxy_params
          self.class.http_proxy_params_filter.filter_params(params, parameter_filter_context, :http_proxy)
        end
      end
    end
  end
end
