module Format
  def self.template
    {
      id: '',
      data: {
        action: 'text',
        contexts: [
          'hoge'
        ],
        enabled: true,
        answers: {
          ja: []
        },
        questions: {
          ja: []
        },
        'redirectFlow': '',
        'redirectNode': ''
      }
    }
  end

  def self.to_json(training_data)
    result = []
    hash_template = self.template
    CSV.foreach(training_data, headers: true) do |training_datum|
      if hash_template[:data][:answers][:ja].last == training_datum['Answers']
        hash_template[:data][:questions][:ja] << training_datum['Questions']
      else
        hash_template =  self.template
        hash_template[:id] = training_datum['Serial_Nums']
        hash_template[:data][:questions][:ja] << training_datum['Questions']
        hash_template[:data][:answers][:ja] << training_datum['Answers']
      end
      hash_template[:data][:questions][:ja].uniq!
      result << hash_template
    end
    JSON.dump({ qnas: result.uniq })
  end

  def self.json_filename
    "training_data_#{DateTime.current.strftime('%F%T').gsub('-', '').gsub(':', '')}.json"
  end

  def self.matrix_filename
    "matrix_#{DateTime.current.strftime('%F%T').gsub('-', '').gsub(':', '')}.csv"
  end
end
