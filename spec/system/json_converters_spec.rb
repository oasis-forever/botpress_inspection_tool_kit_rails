require 'rails_helper'

RSpec.describe "ConverseApi", type: :system do
  before do
    visit json_converters_select_csv_path
  end

  describe 'Convert learning CSV data to JSON data' do
    it 'enables users to get to json_converters_select_csv_path' do
      expect(page).to have_current_path json_converters_select_csv_path
    end

    context 'CSV file is chosen' do
      it 'succeeds in converting CSV file to JSON file' do
        attach_file 'Choose CSV Learning Data', "#{Rails.root}/spec/factories/learning_data.csv"
        click_on 'Export JSON'
        expect(download_file_name).to match(/learning_data.*json/)
      end
    end

    context 'CSV file is NOT chosen' do
      it 'shows error message' do
        click_on 'Export JSON'
        expect(page).to have_selector '.alert-danger', text: 'Choose a learning data csv.'
      end
    end
  end
end
