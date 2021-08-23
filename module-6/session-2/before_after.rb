def get_total_net_income(reports)
  total_net_income = 0
  reports.each do |report|
    gross_income = report.income - report.expense
    net_income = report.tax.income_tax(gross_income)
    total_net_income = total_net_income + net_income
  end

  total_net_income
end

# ==========================================

def get_total_net_income(reports)
  total_net_income = 0
  reports.each do |report|
    total_net_income = total_net_income + net_income(report)
  end

  total_net_income
end

def gross_income(income=report.income, expense=report.expense)
  income - expense
end

def net_income(report, tax=report.tax)
  gross_income = gross_income(report.income, report.expense)
  tax.income_tax(gross_income)
end
