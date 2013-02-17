module Pastenum

  class TargetTemplateErrorDirectCall < StandardError; end
  class TargetUnreachable < StandardError; end
  
  module Defaults
     Raw = false #  Pastenum::Defaults::Raw
     Verbose = false #  Pastenum::Defaults::Verbose
  end

  
end