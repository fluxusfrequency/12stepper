class AddTranslationsToWorksheets < ActiveRecord::Migration
  def up
    Worksheet.create_translation_table!({
      :title => :string,
      :body => :text
    }, {
      :migrate_data => true
    })
  end

  def down
    Worksheet.drop_translation_table! :migrate_data => true
  end
end
