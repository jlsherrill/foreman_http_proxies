require 'deface'

module ForemanHttpProxies
  class Engine < ::Rails::Engine
    isolate_namespace ForemanHttpProxies

    engine_name 'foreman_http_proxies'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    initializer 'foreman_http_proxies.load_app_instance_data' do |app|
      ForemanHttpProxies::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_http_proxies.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_http_proxies do
        requires_foreman '>= 1.4'

        # Add permissions
        security_block :foreman_http_proxies do
        end

        # add menu entry
        menu :top_menu, :http_proxies,
             url_hash: { controller: :'foreman_http_proxies/http_proxies', action: :index },
             caption: 'HTTP Proxies',
             parent: :infrastructure_menu,
             after: :domains
      end
    end

    # Precompile any JS or CSS files under app/assets/
    # If requiring files from each other, list them explicitly here to avoid precompiling the same
    # content twice.
    assets_to_precompile =
      Dir.chdir(root) do
        Dir['app/assets/javascripts/**/*', 'app/assets/stylesheets/**/*'].map do |f|
          f.split(File::SEPARATOR, 4).last
        end
      end
    initializer 'foreman_http_proxies.assets.precompile' do |app|
      app.config.assets.precompile += assets_to_precompile
    end
    initializer 'foreman_http_proxies.configure_assets', group: :assets do
      SETTINGS[:foreman_http_proxies] = { assets: { precompile: assets_to_precompile } }
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanHttpProxies::HostExtensions)
        HostsHelper.send(:include, ForemanHttpProxies::HostsHelperExtensions)
      rescue => e
        Rails.logger.warn "ForemanHttpProxies: skipping engine hook (#{e})"
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanHttpProxies::Engine.load_seed
      end
    end

    initializer 'foreman_http_proxies.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_http_proxies'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
