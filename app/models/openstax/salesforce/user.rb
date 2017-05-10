module OpenStax::Salesforce
  class User < ActiveRecord::Base
    validates :uid, presence: true
    validates :oauth_token, presence: true
    validates :refresh_token, presence: true
    validates :instance_url, presence: true

    after_save :ensure_only_one_record

    def self.save_from_omniauth!(auth)
      where(uid: auth[:uid]).first_or_initialize.tap do |user|
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.refresh_token = auth.credentials.refresh_token
        user.instance_url = auth.credentials.instance_url
        user.save!
      end
    end

    def ensure_only_one_record
      self.class.where{id != my{self.id}}.destroy_all
    end
  end
end
