module Pastenum

  class TargetTemplateErrorDirectCall < StandardError; end
  class TargetUnreachable < StandardError; end
  class IniuriamOrdinis < StandardError; end
  
  module Defaults
     Raw = false #  Pastenum::Defaults::Raw
     Verbose = false #  Pastenum::Defaults::Verbose
     MaxPages = 2
  end

  
end