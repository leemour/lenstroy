module SimpleNavigation
  module Renderer
    class Bootstrap < Base
      def render(item_container)
        return '' if skip?(item_container)
        config_selected_class = SimpleNavigation.config.selected_class
        SimpleNavigation.config.selected_class = 'active'

        list_items = item_container.items
        list_items = list_items.select {|item| included? item} if options[:only]
        list_content = list_items.reduce('', &method(:process))

        SimpleNavigation.config.selected_class = config_selected_class
        content_tag(:ul, list_content,
          {:id => item_container.dom_id, :class => item_container.dom_class})
      end

      protected

      def skip?(item_container)
        return true if skip_if_empty? && item_container.empty?
        return true unless options[:except]
        return false unless defined? item_container.key
        if options[:except].is_a? Array
          options[:except].include?(item_container.key.to_s)
        else
          options[:except] == item_container.key.to_s
        end
      end

      def included?(item)
        if options[:only].is_a? Array
          options[:only].include?(item.key.to_s)
        else
          options[:only] == item.key.to_s
        end
      end

      def process(content, item)
        li_options = item.html_options.reject {|k, v| k == :link}
        li_content = tag_for(item, li_options.delete(:icon))
        if include_sub_navigation?(item)
          item.sub_navigation.dom_class = [item.sub_navigation.dom_class,
            'dropdown-menu'].flatten.compact.join(' ')
          li_content << render_sub_navigation_for(item)
          li_options[:class] = [li_options[:class], 'dropdown'].
            flatten.compact.join(' ')
        end
        content << content_tag(:li, li_content, li_options)
      end

      def tag_for(item, icon = nil)
        unless item.url or include_sub_navigation?(item)
          return item.name
        end
        url = item.url
        link = []
        link << content_tag(:i, '', :class => [icon].flatten.compact.join(' ')) unless icon.nil?
        link << item.name
        if include_sub_navigation?(item)
          url = '#'
          item_options = item.html_options
          item_options[:link] = Hash.new if item_options[:link].nil?
          item_options[:link][:class] = [] if item_options[:link][:class].nil?
          item_options[:link][:class] << 'dropdown-toggle'
          item_options[:link][:'data-toggle'] = 'dropdown'
          item.html_options = item_options
          link << content_tag(:b, '', :class => 'caret')
        end
        link_to(link.join(" ").html_safe, url, options_for(item))
      end
    end
  end
end
SimpleNavigation.register_renderer bootstrap: SimpleNavigation::Renderer::Bootstrap