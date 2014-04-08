SimpleNavigation.config.selected_class = 'active'
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.item :about,        'О нас',                '/about' do |about|
      about.item :how_we_work,  'Как мы работаем',      '/about/how-we-work'
      about.item :contacts,     'Контакты',             '/about/contacts'
    end
    primary.item :houses,       'Загородные дома',      '/houses' do |houses|
      houses.item :brus,        'Из бруса',             '/houses/brus'
      houses.item :karkass,     'Каркасные дома',       '/houses/karkass'
      houses.item :gazobeton,   'Дома из газобетона',   '/houses/gazobeton'
      houses.item :srub,        'Срубы, бани',          '/houses/srub'
    end
    primary.item :works,        'Виды работ',           '/works' do |works|
      works.item :krovlia,      'Кровельные работы',    '/works/krovel'
      works.item :fasad,        'Фасадные работы',      '/works/fasad'
      works.item :otdelka,      'Внутренняя отедка',    '/works/otdelka'
      works.item :zabor,        'Заборы',               '/works/zabor'
      works.item :fundament,    'Фундамент',            '/works/fundament'
    end
    primary.item :repair,       'Ремонт квартир/офисов','/repair' do |repair|
      repair.item :design,      'Дизайн интерьера',     '/repair/design'
      repair.item :otdelka,     'Отделочные работы',    '/repair/fasad'
      repair.item :otdelka,     'Перепланировка',       '/repair/otdelka'
    end
    primary.item :projects,     'Проектирование',       '/projects' do |projects|
      projects.item :dom,       'Проекты домов',        '/projects/dom'
      projects.item :kvartira,  'Проекты квартир',      '/projects/kvartira'
      projects.item :bania,     'Проекты бань',         '/projects/bania'
    end
    primary.item :gallery,      'Галерея',              '/gallery'


    primary.item :promotions,    'Акции',          '/promotions' do |promotions|
      promotions.item :dom,      'Скидка на ремонт квартиры',
                                 '/promotions/renovation-discount'
      promotions.item :kvartira, 'Скидка на ремонт квартиры',
                                 '/promotions/free-estimate-offer'
    end
  end
end