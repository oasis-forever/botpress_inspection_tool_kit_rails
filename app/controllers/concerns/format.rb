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
    learning_data = []
    hash_template = self.template
    CSV.foreach(training_data, headers: true) do |learning_datum|
      if hash_template[:data][:answers][:ja].last == learning_datum['Answers']
        hash_template[:data][:questions][:ja] << learning_datum['Questions']
      else
        hash_template =  template
        hash_template[:id] = learning_datum['Serial_Nums']
        hash_template[:data][:questions][:ja] << learning_datum['Questions']
        hash_template[:data][:answers][:ja] << learning_datum['Answers']
      end
      hash_template[:data][:questions][:ja].uniq!
      learning_data << hash_template
    end
    JSON.dump({ qnas: learning_data.uniq })
  end

  def self.json_filename
    "training_data_#{DateTime.current.strftime('%F%T').gsub('-', '').gsub(':', '')}.json"
  end

  def self.matrix_filename
    "matrix_#{DateTime.current.strftime('%F%T').gsub('-', '').gsub(':', '')}.csv"
  end
end