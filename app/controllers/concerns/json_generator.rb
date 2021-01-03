module JsonGenerator
  def gen_hash_template
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

  def generate_json_file(csv_learning_data)
    learning_data = []
    hash_template = gen_hash_template
    CSV.foreach(csv_learning_data, headers: true) do |learning_datum|
      if hash_template[:data][:answers][:ja].last == learning_datum['Answers']
        hash_template[:data][:questions][:ja] << learning_datum['Questions']
      else
        hash_template = gen_hash_template
        hash_template[:id] = learning_datum['Serial_Nums']
        hash_template[:data][:questions][:ja] << learning_datum['Questions']
        hash_template[:data][:answers][:ja] << learning_datum['Answers']
      end
      hash_template[:data][:questions][:ja].uniq!
      learning_data << hash_template
    end
    JSON.dump({ qnas: learning_data.uniq })
  end
end
