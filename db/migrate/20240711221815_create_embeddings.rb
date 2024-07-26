class CreateEmbeddings < ActiveRecord::Migration[7.1]
  def change
    create_table :embeddings do |t|
      t.references :embeddable, polymorphic: true, null: false

      t.vector :embedding, limit: 768, null: false

      t.index %i[embeddable_id embeddable_type], unique: true

      t.timestamps
    end
  end
end
