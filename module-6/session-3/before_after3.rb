class Tax
  ### Truncated code
  def income_tax(gross_income)
    case @type
    when 'INDIVIDUAL'
      gross_income * 0.1
    when 'ENTERPRISE'
      gross_income * 0.2
    when 'GOVERMENT'
      gross_income * 0.05
    else
      gross_income * 0.3
    end
  end
  ### Others method with related switch statements
end

# ==================================
# my answer

class Tax
  ### Truncated code
  def income_tax(gross_income)
    types = {
      'INDIVIDUAL' => gross_income * 0.1,
      'ENTERPRISE' => gross_income * 0.2,
      'GOVERMENT' => gross_income * 0.05,
    }
    types.default = gross_income * 0.3
    types[@type]
  end
  ### Others method with related switch statements
end
