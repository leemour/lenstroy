module SimpleNavigation
  module Renderer
    class SideMenu < List
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