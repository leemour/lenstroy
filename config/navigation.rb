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
      houses.item :karkas,      'Каркасные дома',       '/houses/karkas'
      houses.item :gazobeton,   'Дома из газобетона',   '/houses/gazobeton'
      houses.item :srub,        'Срубы, бани',          '/houses/srub'
    end
    primary.item :works,        'Виды работ',           '/works' do |works|
      works.item :krovlia,      'Кровельные работы',    '/works/roof'
      works.item :fasad,        'Фасадные работы',      '/works/fasad'
      works.item :otdelka,      'Внутренняя отделка',   '/works/otdelka'
      works.item :zabor,        'Заборы',               '/works/fences'
      works.item :fundament,    'Фундамент',            '/works/foundation'
    end
    primary.item :renovation,   'Ремонт квартир/офисов','/renovation' do |renovation|
      renovation.item :otdelka, 'Отделочные работы',    '/renovation/finishing'
      renovation.item :otdelka, 'Перепланировка',       '/renovation/replanning'
    end
    primary.item :projects,     'Проектирование',       '/projects' do |projects|
      projects.item :dom,       'Проекты домов',        '/projects/house'
      projects.item :kvartira,  'Проекты квартир',      '/projects/flat'
      projects.item :bania,     'Проекты бань',         '/projects/bath-house'
    end
    primary.item :design,       'Дизайн интерьера',      '/design'
    # primary.item :gallery,      'Галерея',              '/gallery'

    primary.item :promotions,    'Акции',          '/promotions' do |promotions|
      promotions.item :new,      'Скидка новоселам',
                                 '/promotions/renovation-discount'
      promotions.item :estimate, 'Бесплатная смета',
                                 '/promotions/free-estimate-offer'
      promotions.item :materials,'Бесплатная закупка материалов',
                                 '/promotions/free-materials-purchasing'
      promotions.item :pensioner,'Скидка пенсионерам',
                                 '/promotions/pensioner-discount'
      promotions.item :recommend,'Скидка по рекомендации',
                                 '/promotions/recomendation-discount'
    end
  end
end