
macro make_component_transfer_funcs(char)
  def func_{{char.downcase.id}}(&block : Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}} -> Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}})
    func_{{char.downcase.id}} = yield Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  def func_{{char.downcase.id}}_identity()
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "identity"
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  def func_{{char.downcase.id}}_table(table_values : Array(IFNumber))
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "table"
    func_{{char.downcase.id}}.table_values = table_values.dup 
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  def func_{{char.downcase.id}}_discrete(table_values : Array(IFNumber))
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "discrete"
    func_{{char.downcase.id}}.table_values = table_values.dup 
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  def func_{{char.downcase.id}}_linear(slope : IFNumber, intercept : IFNumber)
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "linear"
    func_{{char.downcase.id}}.slope = slope 
    func_{{char.downcase.id}}.intercept = intercept 
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  def func_{{char.downcase.id}}_gamma(amplitude : IFNumber, exponent : IFNumber, offset : IFNumber)
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "linear"
    func_{{char.downcase.id}}.amplitude = amplitude 
    func_{{char.downcase.id}}.exponent = exponent 
    func_{{char.downcase.id}}.offset = offset 
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end  
end