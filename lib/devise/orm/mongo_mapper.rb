require 'orm_adapter/adapters/mongo_mapper'

module Devise
  module Orm
    module MongoMapper
      extend ActiveSupport::Concern

      included do
        extend Devise::Models
        extend Devise::Orm::MongoMapper::Hook
      end

      module Hook
        def devise_modules_hook!
          extend Schema
          yield
	 #Uncomment for version of Devise under 1.2
         # return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end

      end

      module Schema
	#Uncomment for version of Devise under 1.2
        #include Devise::Schema

        # Tell how to apply schema methods
        def apply_devise_schema(name, type, options={})
          type = Time if type == DateTime
          key(name, type, options)
        end
      end

    end
  end
end

MongoMapper::Document.plugin Devise::Orm::MongoMapper
