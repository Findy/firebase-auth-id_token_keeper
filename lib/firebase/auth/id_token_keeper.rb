# frozen_string_literal: true

module Firebase
  module Auth
    module IDTokenKeeper

       class << self
        def configure
          yield config
        end

        def config
          @config ||= Config.new
        end
      end
    end
  end
end

require 'firebase/auth/id_token_keeper/version'
require 'firebase/auth/id_token_keeper/config'
require 'firebase/auth/id_token_keeper/public_keys_endpoint'
require 'firebase/auth/id_token_keeper/id_token'
