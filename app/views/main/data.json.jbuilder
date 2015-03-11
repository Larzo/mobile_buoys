
json.title 'buoy site data'
json.stations @stations do |station|
 json.id station.id
 json.name station.name
 json.number station.number
 json.profiles station.profiles.map{|prof| prof.id}
end

json.profiles @profiles do |profile|
 json.id profile.id
 json.name profile.name
end