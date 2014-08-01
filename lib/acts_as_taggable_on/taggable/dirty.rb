module ActsAsTaggableOn::Taggable
  module Dirty
    def self.included(base)
      base.extend ActsAsTaggableOn::Taggable::Dirty::ClassMethods

      base.initialize_acts_as_taggable_on_dirty
    end

    module ClassMethods
      def initialize_acts_as_taggable_on_dirty
        tag_types.map(&:to_s).each do |tags_type|
          tag_type         = tags_type.to_s.singularize

          I18n.available_locales.each do |locale|
            class_eval <<-RUBY, __FILE__, __LINE__ + 1
              def #{tag_type}_list_#{locale.to_s}_changed?
                changed_attributes.include?("#{tag_type}_list_#{locale.to_s}")
              end

              def #{tag_type}_list_#{locale.to_s}_was
                changed_attributes.include?("#{tag_type}_list_#{locale.to_s}") ? changed_attributes["#{tag_type}_list_#{locale.to_s}"] : __send__("#{tag_type}_list_#{locale.to_s}")
              end

              def #{tag_type}_list_#{locale.to_s}_change
                [changed_attributes['#{tag_type}_list_#{locale.to_s}'], __send__('#{tag_type}_list_#{locale.to_s}')] if changed_attributes.include?("#{tag_type}_list_#{locale.to_s}")
              end

              def #{tag_type}_list_#{locale.to_s}_changes
                [changed_attributes['#{tag_type}_list_#{locale.to_s}'], __send__('#{tag_type}_list_#{locale.to_s}')] if changed_attributes.include?("#{tag_type}_list_#{locale.to_s}")
              end
            RUBY
          end

        end
      end
    end
  end
end
