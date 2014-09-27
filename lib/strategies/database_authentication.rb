module Strategies
  class DatabaseAuthentication < ::Warden::Strategies::Base
    def valid?
      params['organization'].present?
    end

    def authenticate!
      organization = Organization.find_by_email(params['organization']['email']).try(:authenticate, params['organization']['password'])

      return success!(organization) if organization
      fail! I18n.t('sessions.create.invalid_credentials')
    end
  end
end

Warden::Strategies.add(:database_authentication, Strategies::DatabaseAuthentication)
