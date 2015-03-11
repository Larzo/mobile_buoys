
@prof = @profiles.map do |pr|
  pr.attributes.update({region: pr.region_id})
end

json.array! @prof
