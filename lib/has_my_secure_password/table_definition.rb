module ActiveRecord; module ConnectionAdapters; end; end
module ActiveRecord::ConnectionAdapters::HasMySecurePasswordTableDefinition
	
	def password(options = {})
		column :password_digest, :string, options
	end
	
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, ActiveRecord::ConnectionAdapters::HasMySecurePasswordTableDefinition)
