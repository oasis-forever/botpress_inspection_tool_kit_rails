require 'rails_helper'

RSpec.describe "TrainingData", type: :system do
  before do
    visit training_data_select_path
  end

  describe 'Convert learning CSV data to JSON data' do
    context 'CSV file is chosen' do
      it 'succeeds in converting CSV file to JSON file' do
        expect(page).to have_current_path training_data_select_path
        attach_file 'Training data', "#{Rails.root}/spec/factories/training_data.csv"
        click_on 'Export JSON'
        expect(download_file_name).to match(/training_data.*json/)
      end
    end

    context 'CSV file is NOT chosen' do
      it 'shows error message' do
        expect(page).to have_current_path training_data_select_path
        click_on 'Export JSON'
        expect(page).to have_selector '.alert-danger', text: "Training data can't be blank"
      end
    end
  end
end
