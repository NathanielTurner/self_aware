module FeatureHelper

  def set_user
    newuser = User.new(
      name: random('name'),
      email: random('email'),
      password: 'password',
      password_confirmation: 'password'
    )
    newuser.skip_confirmation!
    newuser.save
    return newuser
  end

  def set_tasks(how_many, user_id, seed = false)
    tasks = []
    unless seed == true
      how_many.times do
        tasks << Task.create( user_id: user_id, title: random('title'),
                     description: random('description'), monday: random('monday'),
                     assigned_by: random('assigned_by'), friday: random('friday'),
                     difficulty: random('difficulty'), sunday: random('sunday'),
                     completed_on: random('completed_on'), style: random('style'),
                     reminder_type: random('reminder_type'), risk: random('risk'),
                     due_date: random('due_date'), home_page: false,
                     tuesday: random('tuesday'), wednesday: random('wednesday'),
                     thursday: random('thursday'), completed: random('completed'),
                     saturday: random('saturday'), submitted: random('submitted'),
                     consecutive_submits: random('consecutive_submits'),
                     consecutive_record: random('consecutive_record'),
                     over_due: random('over_due'))
      end

      if tasks.count < 1
        raise "No tasks created"
      else
        return tasks
      end
    else
      how_many.times do
        tasks << Task.create( user_id: user_id, title: random('title'),
                     description: random('description'), monday: random('monday'),
                     assigned_by: random('assigned_by'), friday: random('friday'),
                     difficulty: random('difficulty'), sunday: random('sunday'),
                     style: random('style'), submit_count: random('submit_count'),
                     reminder_type: random('reminder_type'), risk: random('risk'),
                     due_date: random('due_date'), home_page: random('home_page'),
                     tuesday: random('tuesday'), wednesday: random('wednesday'),
                     thursday: random('thursday'), completed: random('completed'),
                     saturday: random('saturday'), submitted: random('submitted'),
                     consecutive_submits: random('consecutive_submits'),
                     consecutive_record: random('consecutive_record'),
                     performance: random('performance'),
                     over_due: random('over_due'))
      end

      if tasks.count < 1
        raise "No tasks created"
      else
        return tasks
      end
    end
  end

  def set_budget(id, amount)
    budget = Budet.new(user_id: id, balance: amount)
    return budget
  end

  def within_row(text, &block)
    within :xpath, "//table//tr[td[contains(.,\"#{text}\")]]" do
      yield
    end
  end

  def within_div(text, &block)
    within :xpath, "//div//[contains(.,\"#{text}\")]" do
      yield
    end
  end

  def within_span(text, &block)
    within :xpath, "//span//[contains(.,\"#{text}\")]]" do
      yield
    end
  end

  private

  def random(from_type)

    case from_type
      when 'completed', 'home_page', 'sunday', 'monday', 'tuesday',
            'wednesday', 'thursday', 'friday','saturday', 'submitted',
            'over_due'
        [true, false].sample
      when 'style'
        ['to_do','habit'].sample
      when 'risk', 'difficulty', 'user_id'
        rand(0..4)
      when 'title'
        Faker::Lorem.sentence(3, true, 3)
      when 'description'
        Faker::Lorem.paragraph(2, false, 10)
      when 'assigned_by', 'name'
        Faker::Name.name
      when 'completed_on'
        Faker::Time.between(Time.zone.now - 1.year, Time.zone.now)
      when 'reminder_type'
        ['email', 'notice', 'none'].sample
      when 'remind_at'
        Faker::Time.between(Time.zone.now - 12.hours, Time.zone.now + 12.hours, :day)
      when 'due_date'
        Faker::Time.between(Time.zone.now + 3.days, Time.zone.now + 1.month)
      when 'email'
        Faker::Internet.email
      when 'amount'
        Faker::Commerce.price
      when 'initial_amount'
        Faker::Number.decimal(5, 2)
      when 'submit_count', 'consecutive_submits', 'consecutive_record'
        rand(1..15)
      when 'performance'
        ['poor', 'low', 'adaquate', 'high', 'fantastic', 'phenominal'].sample
    end
  end


end
