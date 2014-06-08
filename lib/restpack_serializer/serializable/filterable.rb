module RestPack::Serializer::Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :serializable_filters

    def can_filter_by(*attributes)
      @serializable_filters = []
      attributes.each do |attribute|
        @serializable_filters << attribute.to_sym
      end
    end

    def filterable_by
      filters = [self.model_class.primary_key.to_sym]
      filters += self.model_class.reflect_on_all_associations(:belongs_to).map(&:foreign_key).map(&:to_sym)

      filters += serializable_filters if serializable_filters
      filters.uniq
    end
  end
end
