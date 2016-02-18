class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.text :content, null: false
      t.text :author_name, null: false
      t.text :author_company, null: true
      t.string :image, null: true
      t.integer :position, null: true
      t.boolean :display, null: true, default: true
      t.boolean :home_page_highlight, null: true, default: true

      t.timestamps null: false
    end
  end
end
