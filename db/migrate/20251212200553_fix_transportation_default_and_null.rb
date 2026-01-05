class FixTransportationDefaultAndNull < ActiveRecord::Migration[7.1]
  def up
    change_column_default :travel_records, :transportation, 9


    execute <<~SQL
      UPDATE travel_records
      SET transportation = 9
      WHERE transportation IS NULL;
    SQL
  end

  def down
    # 元に戻したくなったときに使う
    execute <<~SQL
      UPDATE travel_records
      SET transportation = NULL
      WHERE transportation = 9;
    SQL

    change_column_default :travel_records, :transportation, nil
  end
end
