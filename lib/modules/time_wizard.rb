module TimeWizard

	def current_day_name
    Time.zone.now.strftime('%A').downcase
  end

	def day_name(date)
		date.strftime('%A').downcase
	end

	def current_week_of_month

	end

	def new_week?
		Time.zone.now.beginning_of_day == Time.zone.now.beginning_of_week
	end

	def new_month?
		Time.zone.now.beginning_of_day == Time.zone.now.beginning_of_month
	end

	def week_end?
		day = day_name(Time.zone.now)
		case day
		when "saturday", "sunday"
			true
		else
			false
		end
	end

	def week_day?
		day = day_name(Time.zone.now)
		case day
		when "monday", "tuesday", "wednesday", "thursday", "friday"
			true
		else
			false
		end
	end

	def days_till_new_week
		(((Time.zone.now).end_of_week + 1.day) - (Time.zone.now)).to_i/(24*60*60)
	end

	def days_till_new_month
		(((Time.zone.now).end_of_month + 1.day) - (Time.zone.now)).to_i/(24*60*60)
	end

	def days_in_current_month
		((Time.zone.now.beginning_of_month - Time.zone.now.end_of_month).to_i /
		 	  (24*60*60)).abs
	end

	def days_till(date)
		(((Time.zone.now) - date ).to_i / (24*60*60)).abs
	end


end
