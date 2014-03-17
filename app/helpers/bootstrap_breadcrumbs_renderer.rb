module SimpleNavigation
  module Renderer
    class BootstrapBreadcrumbs < Base

      def render(item_container)
        content = li_tags(item_container).join(join_with)
        if content.length > 1 && content !~ /^<li class="active/
          output = content_tag(:ul,
            prefix_for(content) + content,
            :id => item_container.dom_id,
            :class => [item_container.dom_class, 'breadcrumb'].compact.join(' '))
        end
      end

      protected

      def li_tags(item_container)
        item_container.items.inject([]) do |list, item|
          if item.selected?
            if include_sub_navigation?(item)
              list << content_tag(:li,
                link_to(item.name, item.url,
                {method: item.method}.merge(item.html_options.except(:class,:id))))
              list.concat li_tags(item.sub_navigation)
            else
              list << content_tag(:li, item.name, { class: 'active' })
            end
          end
          list
        end
      end

      def join_with
        @join_with ||= options[:join_with] || '/'
        content_tag(:li, content_tag(:span, @join_with, :class => 'divider'))
      end

      def suppress_link?(item)
        super || (options[:static_leaf] && item.active_leaf_class)
      end

      def prefix_for(content)
        content.empty? ? '' : options[:prefix] || ''
      end

      # Extracts the options relevant for the generated link
      #
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