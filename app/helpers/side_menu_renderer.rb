module SimpleNavigation
  module Renderer
    class SideMenu < List
      # def render(item_container)
      #   return '' if skip_if_empty? && item_container.empty?
      #   items = item_container.items.select &method(:included?)
      #   options[:only] = nil
      #   content = list_content(items)
      #   tag = options[:ordered] ? :ol : :ul
      #   content_tag(tag, content, item_container.dom_attributes)
      # end

      # protected

      # def list_content(items)
      #   items.map do |item|
      #     li_options = item.html_options.except(:link)
      #     li_content = tag_for(item)
      #     if include_sub_navigation?(item)
      #       li_content << render_sub_navigation_for(item)
      #     end
      #     content_tag(:li, li_content, li_options)
      #   end.join
      # end

      # def included?(item)
      #   if options[:except]
      #     not [*options[:except]].include? item.key
      #   elsif options[:only]
      #     [*options[:only]].include? item.key
      #   else
      #     true
      #   end
      # end

      def tag_for(item)
        url = suppress_link?(item) ? "#" : item.url
        item_options = options_for(item)
        item_options[:class] += ' selected' if suppress_link?(item)
        link_to item.name.html_safe, url, item_options
      end

      def suppress_link?(item)
        item.url.nil? || (item.selected? && !include_sub_navigation?(item))
      end
    end
  end
end

SimpleNavigation.register_renderer side_menu: SimpleNavigation::Renderer::SideMenu