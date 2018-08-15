# frozen_string_literal: true

module Firebase
  module Auth
    module IDTokenKeeper
      class Config
        attr_accessor :firebase_project_id

        def initialize
          self.firebase_project_id = DEFAULT_FIREBASE_PROJECT_ID
        end

        private

        DEFAULT_FIREBASE_PROJECT_ID = 'default_firebase_project_id'
      end
    end
  end
end
