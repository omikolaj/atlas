class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :topLevelDomain
      t.string :alpha2Code
      t.string :alpha3code
      t.integer :callingCodes
      t.string :capital
      t.string :region
      t.string :subregion
      t.string :demonym
      t.float :area
      t.string :timezones
      t.string :borders
      t.string :nativeName
      t.string :currency_name
      t.string :currency_symbol
      t.string :native_lang_name
      t.string :language_name
      t.string :flag_path
    end
  end
end
