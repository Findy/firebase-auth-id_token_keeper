# frozen_string_literal: true

module Firebase
  module Auth
    module IDTokenKeeper
      module Generators
        class InstallGenerator < Rails::Generators::Base
          source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
          namespace 'firebase:auth:id_token_keeper:install'

          def copy_config_file
            template 'firebase_auth_id_token_keeper.rb', 'config/initializers/firebase_auth_id_token_keeper.rb'
          end
        end
      end
    end
  end
end
