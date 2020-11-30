# Special macro for component transfer to need to rewrite less code for the `feFunc*` DSL
macro make_component_transfer_funcs(char)
  # DSL call for feFunc{{char.upcase.id}}
  def func_{{char.downcase.id}}(&block : Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}} -> Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}})
    func_{{char.downcase.id}} = yield Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  # DSL call for feFunc{{char.upcase.id}} with identity
  def func_{{char.downcase.id}}_identity()
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "identity"
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  # DSL call for feFunc{{char.upcase.id}} with table
  def func_{{char.downcase.id}}_table(table_values : Array(IFNumber))
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "table"
    func_{{char.downcase.id}}.table_values = table_values.dup 
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  # DSL call for feFunc{{char.upcase.id}} with discrete
  def func_{{char.downcase.id}}_discrete(table_values : Array(IFNumber))
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "discrete"
    func_{{char.downcase.id}}.table_values = table_values.dup 
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  # DSL call for feFunc{{char.upcase.id}} with linear
  def func_{{char.downcase.id}}_linear(slope : IFNumber, intercept : IFNumber)
    func_{{char.downcase.id}} = Celestine::Filter::ComponentTransfer::Func{{char.upcase.id}}.new
    func_{{char.downcase.id}}.type = "linear"
    func_{{char.downcase.id}}.slope = slope 
    func_{{char.downcase.id}}.intercept = intercept 
    func_{{char.downcase.id}}.draw(inner_elements)
    func_{{char.downcase.id}}
  end

  # DSL call for feFunc{{char.upcase.id}} with gamma
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