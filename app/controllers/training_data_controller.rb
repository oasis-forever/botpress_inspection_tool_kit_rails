class TrainingDataController < ApplicationController
  extend Format

  def select
    @training_data = TrainingData.new
  end

  def download
    @training_data = TrainingData.new(training_data: params[:training_data])
    if @training_data.save
      send_data(Format.to_json(@training_data.training_data), filename: Format.json_filename)
    else
      render :select
    end
  end
end
