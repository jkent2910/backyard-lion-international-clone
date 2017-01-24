module GoogleHelper

  def google_map(center)
    "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=1500x400&zoom=10"
  end

end