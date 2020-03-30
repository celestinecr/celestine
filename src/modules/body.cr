module Celestine::Modules::Body
  property width : SIFNumber = 0
  property height : SIFNumber = 0

  def body_options
    %Q[width="#{width}" height="#{height}"]
  end
end