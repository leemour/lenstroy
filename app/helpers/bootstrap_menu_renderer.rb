module SimpleNavigation
  module Renderer
    class Bootstrap < Base
      def render(item_container)
        return '' if skip_if_empty? && item_container.empty?
        list_items = item_container.items.select &method(:included?)
        list_items.each(&method(:add_primary)) # Add parent item to sub_navigation
        list_content = list_items.map(&method(:process)).join('')
        content_tag(:ul, list_content,
          {:id => item_container.dom_id, :class => item_container.dom_class})
      end

      protected

      def included?(item)
        not [*options[:except]].include? item.key
      end

      def add_primary(item)
        if item.sub_navigation
          primary_item = Item.new(item.sub_navigation,
            item.key, item.name, item.url, class: 'primary')
          item.sub_navigation.items.prepend primary_item
        end
      end

      def process(item)
        li_options = item.html_options.except :link
        li_content = tag_for item, li_options.delete(:icon)
        if include_sub_navigation?(item)
          item.sub_navigation.dom_class = [item.sub_navigation.dom_class,
            'dropdown-menu'].flatten.compact.join(' ')
          li_content << render_sub_navigation_for(item)
          li_options[:class] = [li_options[:class],
            'dropdown'].flatten.compact.join(' ')
        end
        content_tag(:li, li_content, li_options)
      end

      def tag_for(item, icon = nil)
        url  = suppress_link?(item) ? "#" : item.url
        link = link_for(item, icon)
        item_options = options_for(item) || {}
        add_class(item_options, 'selected') if suppress_link?(item)
        link_to link.join(" ").html_safe, url, item_options
      end

      def suppress_link?(item)
        return false if include_sub_navigation?(item)
        item.url.nil? || item.selected?
      end

      def link_for(item, icon)
        link = []
        link << icon_tag(icon) unless icon.nil?
        link << item.name.html_safe
        if include_sub_navigation? item
          set_html_options_for! item
          link << content_tag(:b, '', :class => 'caret')
        end
        link
      end

      def add_class(item_options, klass)
        item_options[:class] ||= ''
        item_options[:class] += " #{klass}"
      end

      def icon_tag(icon)
        content_tag(:i, '', :class => [icon].flatten.compact.join(' '))
      end

      def set_html_options_for!(item)
        item_options = item.html_options
        item_options[:link] = Hash.new if item_options[:link].nil?
        item_options[:link][:class] = [] if item_options[:link][:class].nil?
        item_options[:link][:class] << 'dropdown-toggle'
        item_options[:link][:'data-toggle'] = 'dropdown'
        item.html_options = item_options
      end
    end
  end
end
SimpleNavigation.register_renderer bootstrap: SimpleNavigation::Renderer::Bootstrap