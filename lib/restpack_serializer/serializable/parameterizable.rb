module RestPack::Serializer::Parameterizable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :serializable_parameters

    def allow_parameters(*parameters)
      @serializable_parameters = []
      parameters.each do |parameter|
        @serializable_parameters << parameter.to_sym
      end
    end
  end
end
