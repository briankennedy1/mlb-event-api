Event.where(bat_id: 'bondb001').count

Event.find_by_sql("SELECT * FROM events WHERE (events.bat_id = 'bondb001')").count

ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM events WHERE (events.bat_id = 'bondb001')")[0]
