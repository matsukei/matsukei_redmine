module MatsukeiRedmine
  class CustomPathFormat < Redmine::FieldFormat::LinkFormat
    add 'path'

    class << self
      def link_to_path(view, value)
        if value.present?
          value, display_name = (value || '').split('|')
          value = value.gsub(/\\/, '/')
          view.link_to display_name || File.basename(value), "file:///#{value}", 
            title: value, target: (value =~ /\.[a-zA-Z]+$/ ? '_blank' : nil)
        end
      end
    end

    def formatted_value(view, custom_field, value, customized = nil, html = false)
      self.class.link_to_path(view, value)
    end

  end
end
