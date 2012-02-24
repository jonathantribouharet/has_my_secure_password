module ActiveRecord; module Acts; end; end
module ActiveRecord::Acts::HasMySecurePassword

  def self.included(klass)
		klass.class_eval do
			class_attribute :has_my_secure_password_field
			self.has_my_secure_password_field = :email
			extend(ClassMethods)
		end
  end

	module ClassMethods
		
		def has_my_secure_password(options = {:presence => true}, &block)			
			require 'bcrypt'
			include ActiveRecord::Acts::HasMySecurePassword::InstanceMethods
			
			yield self if block_given?
			
			attr_reader :password
			
			validates :password_digest, options
		
			if respond_to?(:attributes_protected_by_default, true)
				def self.attributes_protected_by_default
					super + ['password_digest']
				end
			end

			def self.authenticate(email, password)
				send('find_by_' + self.has_my_secure_password_field.to_s, email, password).try(:authenticate, password) || false
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
