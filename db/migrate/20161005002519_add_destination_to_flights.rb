class AddDestinationToFlights < ActiveRecord::Migration[5.0]
  def change
    add_column :flights, :destination, :string
  end
end
