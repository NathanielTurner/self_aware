module TasksHelper
	def days_till(date)
		if ( (Time.zone.now) - date ).to_i / (24*60*60) == 0
			return 'Today'
		else
			"In \n #{(((Time.zone.now) - date ).to_i / (24*60*60)).abs} Days"
		end
	end

	def days_from(date)
		(((Time.zone.now) - date ).to_i / (24*60*60)).abs
	end

	def get_difficulty(num)
		case num
		  when 0
		  	'easy'
		  when 1
		  	'normal'
		  when 2
		  	'hard'
		  when 3
		  	'very hard'
		  when 4
		  	'nightmarish'
		end
	end

	def get_days_true(task)
		string = ''
		if task.monday
			string += 'Monday '
		end
		if task.tuesday
			string += 'Tuesday '
		end
		if task.wednesday
			string += 'Wednesday '
		end
		if task.thursday
			string += 'Thursday '
		end
		if task.friday
			string += 'Friday '
		end
		if task.saturday
			string += 'Saturday '
		end
		if task.sunday
			string += 'Sunday '
		end
		return string
	end

	def submit_day_name
	  Time.zone.now.strftime('%A').downcase
	end

	def good_to_dos(to_dos)
		tasks = to_dos.where(completed: true, over_due: false, )
		count = {'easy' => 0, 'normal' => 0, 'hard' => 0, 'vhard' => 0, 'nightmare' => 0}
		tasks.each do |task|
			case task.difficulty
			  when 0
			  	count['easy'] += 1
			  when 1
			  	count['normal'] += 1
			  when 2
			  	count['hard'] += 1
			  when 3
			  	count['vhard'] += 1
			  when 4
			  	count['nightmare'] += 1
			end
		end
		return count.key(count.values.max)
	end

	def bad_to_dos(to_dos)
		tasks = to_dos.where( over_due: false )
		count = {'easy' => 0, 'normal' => 0, 'hard' => 0, 'vhard' => 0, 'nightmare' => 0}
		tasks.each do |task|
		  case task.difficulty
		    when 0
		    	count['easy'] += 1
		    when 1
		    	count['normal'] += 1
		    when 2
		    	count['hard'] += 1
		    when 3
		    	count['vhard'] += 1
		    when 4
		    	count['nightmare'] += 1
		    end
			end
		return count.key(count.values.max)
	end

	def good_habits(habits)
		tasks = habits.where("consecutive_record > 6")
		count = {'easy' => 0, 'normal' => 0, 'hard' => 0, 'vhard' => 0, 'nightmare' => 0}
		tasks.each do |task|
			case task.difficulty
		  	when 0
		  		count['easy'] += 1
		  	when 1
		  		count['normal'] += 1
		  	when 2
		  		count['hard'] += 1
		  	when 3
		  		count['vhard'] += 1
		  	when 4
		  		count['nightmare'] += 1
			end
		end
		return count.key(count.values.max)
	end

	def bad_habits(habits)
		tasks = habits.where("consecutive_record < 4")
		count = {'easy' => 0, 'normal' => 0, 'hard' => 0, 'vhard' => 0, 'nightmare' => 0}
		tasks.each do |task|
			case task.difficulty
		  	when 0
		  		count['easy'] += 1
		  	when 1
		  		count['normal'] += 1
		  	when 2
		  		count['hard'] += 1
		  	when 3
		  		count['vhard'] += 1
		  	when 4
		  		count['nightmare'] += 1
			end
		end
		return count.key(count.values.max)
	end


end
