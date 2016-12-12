module ForemanHttpProxies
  module Actions
    module HttpProxy
      class Destroy < ::Actions::EntryAction
        def plan(http_proxy)
        end

        def humanized_name
          _('Delete HTTP Proxy')
        end
      end
    end
  end
end
