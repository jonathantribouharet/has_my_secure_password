module ActiveRecord; module Acts; end; end
module ActiveRecord::Acts::HasMySecurePassword

  def self.included(klass)
		klass.class_eval do
			extend(ClassMethods)
		end
  end

	module ClassMethods
		
		def has_my_secure_password(options = {:presence => true})
			include BCrypt
			include ActiveRecord::Acts::HasMySecurePassword::InstanceMethods
			
			attr_reader :password
			
			validates :password_digest, options
		
			if respond_to?(:attributes_protected_by_default)
				def self.attributes_protected_by_default
					super + ['password_digest']
				end
			end

		end
		
  end
	
	module InstanceMethods
		
		def authenticate(unencrypted_password)
			if BCrypt::Password.new(self.password_digest) == unencrypted_password
				self
			else
				false
			end
		end	

		def password=(new_password)
			@password = new_password
      self.password_digest = BCrypt::Password.create(@password) if !@password.blank?
		end	
		
	end	

end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::HasMySecurePassword)


module ActiveRecord; module ConnectionAdapters; end; end
module ActiveRecord::ConnectionAdapters::HasMySecurePasswordTableDefinition
	
	def password(options = {})
		column :password_digest, :string, options
	end
	
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, ActiveRecord::ConnectionAdapters::HasMySecurePasswordTableDefinition)
