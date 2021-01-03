require 'csv'
require 'json'

class JsonConvertersController < ApplicationController
  include JsonGenerator

  def select_csv
  end

  def download
    if csv_learning_data = file_params[:csv_learning_data]
      json_learning_data = generate_json_file(csv_learning_data)
      send_data(
        json_learning_data,
        filename: "learning_data_#{DateTime.current.strftime('%F%T').gsub('-', '').gsub(':', '')}.json"
      )
    else
      flash[:alert] = 'Choose a learning data csv.'
      render :select_csv
    end
  end

  private

  def file_params
    params.permit(:csv_learning_data)
  end
end
