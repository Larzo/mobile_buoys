
json.title 'buoy list'
json.stations @stations do |station|
 json.id station.id
 json.name station.name
 json.number station.number
 json.profiles station.profiles.map{|prof| prof.id}
end