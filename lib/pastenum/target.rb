module Pastenum
  class Target
    # attr_accessor :enabled, :dork

    def initialize(dork_url)
      @dork = dork_url
    end

    def search
      raise TargetTemplateErrorDirectCall
    end

  end
end