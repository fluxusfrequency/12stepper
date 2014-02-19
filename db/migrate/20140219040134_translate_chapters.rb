class TranslateChapters < ActiveRecord::Migration
  def up
    BigBook::Chapter.create_translation_table!({
      :title => :string,
      :body => :text
    }, {
      :migrate_data => true
    })
  end

  def down
    BigBook::Chapter.drop_translation_table! :migrate_data => true
  end
end
