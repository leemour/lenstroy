module SimpleNavigation
  module Renderer
    class BootstrapBreadcrumbs < SimpleNavigation::Renderer::Base
      def render(item_container)
        items = li_tags(item_container).join
        unless items.empty?
          content_tag(:ol, items.prepend(prefix),
            id: item_container.dom_id, class: "breadcrumb")
        end
      end

      protected

      def prefix
        content_tag :li, link_to('Главная', '/', rel: 'nofollow')
      end

      def li_tags(item_container)
        item_container.items.inject([]) do |list, item|
          if item.selected?
            if include_sub_navigation?(item) && item.sub_navigation.selected?
              list << content_tag(:li,
                link_to(item.name, item.url, options_for(item)))
              list.concat li_tags(item.sub_navigation)
            else
              list << content_tag(:li, item.name, class: 'active') if item.selected?
            end
          end
          list
        end
      end

      def options_for(item)
        {method: item.method}.merge(item.html_options.except(:class, :id))
      end

      def suppress_link?(item)
        super || (options[:static_leaf] && item.active_leaf_class)
      end

      # Extracts the options relevant for the generated link
      def link_options_for(item)
        if options[:allow_classes_and_ids]
          opts = super
          opts[:id] = "breadcrumb_#{opts[:id]}" if opts[:id]
          opts
        else
          {:method => item.method}.merge(item.html_options.except(:class,:id))
        end
      end
    end
  end
end
SimpleNavigation.register_renderer :bootstrap_breadcrumbs => SimpleNavigation::Renderer::BootstrapBreadcrumbs