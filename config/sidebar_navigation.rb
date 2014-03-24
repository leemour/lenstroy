SimpleNavigation.config.selected_class = 'active'
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :houses,       'Загородные дома',      '/houses' do |houses|
      houses.item :brus,        'Из бруса',             '/houses/brus'
      houses.item :karkass,     'Каркасные дома',       '/houses/karkass'
      houses.item :gazobeton,   'Дома из газобетона',   '/houses/gazobeton'
      houses.item :srub,        'Срубы, бани',          '/houses/srub'
    end
  end
end