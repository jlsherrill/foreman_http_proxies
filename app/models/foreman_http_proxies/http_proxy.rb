module ForemanHttpProxies
  class HttpProxy < ActiveRecord::Base
    include Authorizable
    include Taxonomix
    include Encryptable
    include ForemanTasks::Concerns::ActionTriggering

    extend FriendlyId

    encrypts :password
    friendly_id :name

    validates :url, :presence => true
    validates :port, :presence => true

    scoped_search :on => :name

    def update_action
      ::ForemanHttpProxies::Actions::HttpProxy::Update
    end

    def destroy_action
      ::ForemanHttpProxies::Actions::HttpProxy::Destroy
    end
  end
end
