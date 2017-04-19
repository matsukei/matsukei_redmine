require_dependency 'user'

module MatsukeiRedmine
  module UserPreferencePatch
    extend ActiveSupport::Concern

    included do
      unloadable

    end

    def replies_sorting; self[:replies_sorting] end
    def replies_sorting=(order); self[:replies_sorting]=order end

  end
end

MatsukeiRedmine::UserPreferencePatch.tap do |mod|
  UserPreference.send :include, mod unless UserPreference.include?(mod)
end
