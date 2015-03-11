
# angular needs an array not a hash with an array
@stat = @stations.map do |st|
  st.attributes.update({profiles: st.profiles.map{|prof| prof.id}})
end

json.array! @stat
