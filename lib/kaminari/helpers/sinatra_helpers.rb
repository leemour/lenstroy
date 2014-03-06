module Kaminari::Helpers
  module SinatraHelpers
    module HelperMethods
      def paginate(scope, options = {}, &block)
        current_path = request.path rescue nil
        current_params = Rack::Utils.parse_query(env['QUERY_STRING']).symbolize_keys rescue {}
        paginator = Kaminari::Helpers::Paginator.new(
          ActionViewTemplateProxy.new(:current_params => current_params, :current_path => current_path, :param_name => options[:param_name] || Kaminari.config.param_name),
          options.reverse_merge(:current_page => scope.current_page, :total_pages => scope.total_pages, :per_page => scope.limit_value, :param_name => Kaminari.config.param_name, :remote => false)
        )
        paginator.to_s
      end

      def link_to_previous_page(scope, name, options = {})
        params = options.delete(:params) || (Rack::Utils.parse_query(env['QUERY_STRING']).symbolize_keys rescue {})
        param_name = options.delete(:param_name) || Kaminari.config.param_name
        placeholder = options.delete(:placeholder)

        unless scope.first_page?
          query = params.merge(param_name => scope.prev_page)
          link_to name, request.path + (query.empty? ? '' : "?#{query.to_query}"), options.reverse_merge(:rel => 'previous')
        else
          placeholder
        end
      end

      def link_to_next_page(scope, name, options = {})
        params = options.delete(:params) || (Rack::Utils.parse_query(env['QUERY_STRING']).symbolize_keys rescue {})
        param_name = options.delete(:param_name) || Kaminari.config.param_name
        placeholder = options.delete(:placeholder)

        unless scope.last_page?
          query = params.merge(param_name => scope.next_page)
          link_to name, request.path + (query.empty? ? '' : "?#{query.to_query}"), options.reverse_merge(:rel => 'next')
        else
          placeholder
        end
      end
    end
  end
end