module Chart
  def self.set_header(serial_nums)
    header = %w(Serial_Nums Test_Data)
    header.concat(serial_nums)
  end

  def self.set_answers_confidence(res_body)
    res_hash = JSON.parse(res_body)
    answers_confidence = 0.upto(res_hash.dig('suggestions').size - 1).map do |i|
      { res_hash.dig('suggestions')[i].dig('payloads')[1].dig('text') => res_hash.dig('suggestions')[i].dig('confidence') }
    end
  end

  def self.set_row(test_datum, answers_arr, res_body)
    row = [test_datum['Serial_Nums'], test_datum['Questions']]
    last_index = answers_arr.size - 1
    confidence = [].fill('0.0%', 0..last_index)
    answers_confidence = self.set_answers_confidence(res_body)
    answers_confidence.each do |ans_conf|
      index = answers_arr.find_index(ans_conf.keys.first)
      confidence[index] = "#{sprintf('%.1f', ans_conf.values.first * 100)}%"
    end
    row.concat(confidence)
  end
end
