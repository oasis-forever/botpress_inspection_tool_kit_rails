require 'rails_helper'

RSpec.describe "Top", type: :system do
  before do
    visit root_path
  end

  describe 'Check if each link enables users to get to a proper path' do
    it 'enables users to get to root_path' do
      click_on 'Top'
      expect(page).to have_current_path root_path
    end

    it 'enables users to get to json_converters_select_csv_path' do
      click_on 'Learning Data Converter from CSV to JSON'
      expect(page).to have_current_path json_converters_select_csv_path
    end

    it 'enables users to get to converse_api_select_data_path' do
      click_on 'Matrix Chart of Confidence'
      expect(page).to have_current_path converse_api_select_data_path
    end
  end
end
