def average_income_in(date_range)
  ### Truncated code
  total_days = (date_range.end_date - date_range.start_date).to_i
  total_income / total_days
end

class DateRange
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end
end

# =====================================
# my answer

def average_income_in(date_range)
  ### Truncated code
  total_days = date_range.range
  total_income / total_days
end

class DateRange
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def range
    (@end_date - @start_date).to_i
  end
end

# ======================================
# the answer

def average_income_in(date_range)
  ### Truncated code
  total_days = date_range.number_of_days
  total_income / total_days
end

class DateRange
  attr_reader :start_date, :end_date

  def number_of_days
    (@end_date - @start_date).to_i
  end
end

