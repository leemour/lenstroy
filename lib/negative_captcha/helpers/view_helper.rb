module NegCaptcha
  module Helpers
    module ViewHelper
      include Padrino::Helpers::FormHelpers

      def negative_captcha(captcha)
        [
          hidden_field_tag('timestamp', value: captcha.timestamp),
          hidden_field_tag('spinner', value: captcha.spinner),
        ].join.html_safe
      end

      def negative_text_field_tag(captcha, field, options={})
        text_field_tag(
          captcha.fields[field],
          options.merge(value: captcha.values[field])
        ) +
          content_tag('div', class: 'reposition_field') do
          text_field_tag(field, :tabindex => '999', :autocomplete => 'off')
        end.html_safe
      end

      def negative_text_area_tag(captcha, field, options={})
        text_area_tag(
          captcha.fields[field],
          options.merge(value: captcha.values[field])
        ) +
          content_tag('div', class: 'reposition_field') do
          text_area_tag(field, :tabindex => '999', :autocomplete => 'off')
        end.html_safe
      end

      def negative_hidden_field_tag(captcha, field, options={})
        hidden_field_tag(
          captcha.fields[field],
          options.merge(value: captcha.values[field])
        ) +
        content_tag('div', class: 'reposition_field') do
          hidden_field_tag(field, :tabindex => '999')
        end.html_safe
      end

      def negative_file_field_tag(captcha, field, options={})
        file_field_tag(
          captcha.fields[field],
          options.merge(value: captcha.values[field])
        ) +
        content_tag('div', class: 'reposition_field') do
          file_field_tag(field, :tabindex => '999')
        end
      end

      def negative_check_box_tag(captcha, field, options={})
        check_box_tag(
          captcha.fields[field],
          options.merge(value: captcha.values[field])
        ) +
        content_tag('div', class: 'reposition_field') do
          check_box_tag(field, :tabindex => '999')
        end
      end

      def negative_password_field_tag(captcha, field, options={})
        password_field_tag(
          captcha.fields[field],
          options.merge(value: captcha.values[field])
        ) +
        content_tag('div', class: 'reposition_field') do
          password_field_tag(field, :tabindex => '999')
        end.html_safe
      end

      def negative_label_tag(captcha, field, name, options={})
        label_tag(name, options.merge(value: captcha.fields[field]))
      end
    end

    #TODO: Select, etc
  end
end