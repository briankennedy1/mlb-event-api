# Bonds events
`Event.where(bat_id: 'bondb001').count` - 14 ms
=> 12913

`Event.find_by_sql("SELECT * FROM events WHERE (events.bat_id = 'bondb001')").count` - 169 ms
=> 12913

`ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM events WHERE (events.bat_id = 'bondb001')")[0]` - 849 ms
=> {"count"=>"12913"}

# Bonds walks
`Event.where(bat_id: 'bondb001', event_cd: [14,15]).count` - 200 ms
=> 2558

`Event.find_by_sql("SELECT * FROM events WHERE (events.bat_id = 'bondb001' AND events.event_cd = 14 OR events.bat_id = 'bondb001' AND events.event_cd = 15)").count` - 237 ms
=> 2558

`ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM events WHERE (events.bat_id = 'bondb001' AND events.event_cd = 15 OR events.bat_id = 'bondb001' AND events.event_cd = 14)")[0]` - 197 ms
=> {"count"=>"2558"}
