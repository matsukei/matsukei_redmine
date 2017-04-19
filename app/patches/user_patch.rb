require_dependency 'user'

module MatsukeiRedmine
  module UserPatch
    extend ActiveSupport::Concern

    included do
      unloadable

    end

    def wants_replies_in_reverse_order?
      self.pref[:replies_sorting] == 'desc'
    end

  end
end

MatsukeiRedmine::UserPatch.tap do |mod|
  User.send :include, mod unless User.include?(mod)
end
