module ConverseApiHelper
  def evaluate_confidence(row)
    return unless row.include?('%')
    if row.to_f == 0.0
      ''
    elsif row.to_f >= 70.0
      'excellent'
    elsif row.to_f >= 50.0
      'good'
    elsif row.to_f >= 30.0
      'bad'
    else
      'useless'
    end
  end
end
