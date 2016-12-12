require 'test_plugin_helper'

module ForemanHttpProxies
  class HttpProxiesTest < ActiveSupport::TestCase
    let(:http_proxy) {FactoryGirl.create(:http_proxy)}

    test 'create' do
      proxy = HttpProxy.new(:name => 'foobar', :url => "http://someurl/", :port => 5000)

      assert proxy.save
    end

    test 'create requires url' do
      proxy = HttpProxy.new(:name => 'foobar', :port => 5000)

      refute proxy.save
    end

    test 'create requires port' do
      proxy = HttpProxy.new(:name => 'foobar',:url => "http://someurl/")

      refute proxy.save
    end

    test 'search by name' do
      assert_equal 1, HttpProxy.search_for("name = #{http_proxy.name}")
    end
  end
end