module ForemanHttpProxies
  module Actions
    module HttpProxy
      class Update < ::Actions::EntryAction
        def plan(http_proxy)
        end

        def humanized_name
          _('Update HTTP Proxy')
        end
      end
    end
  end
end
