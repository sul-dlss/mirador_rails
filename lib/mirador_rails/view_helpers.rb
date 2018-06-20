module Mirador
  module ViewHelpers
    ##
    # @param [String] id
    # @param [String] height
    # @param [String] width
    # @param [String] position
    # @param [String] display
    # @param [String] instance_name
    # @param [Hash] options Mirador settings
    def mirador_tag(id: SecureRandom.uuid, height: '100%', width: '100%', position: 'relative', display: 'block', instance_name: nil, options: {})
      config = {
        id: id,
        buildPath: '/assets/',
        i18nPath: '',
        imagesPath: ''
      }.merge(options)

      styles = "height: #{height}; width: #{width}; " \
               "position: #{position}; display: #{display};"
      output = []
      output << content_tag(:div, '', id: id, style: styles)

      if instance_name
        output << '<script type="text/javascript">'                   \
                  '  $(function() {'                                  \
                  "    #{instance_name} = Mirador(#{config.to_json})"  \
                  '  });'                                             \
                  '</script>'
      else
        output << '<script type="text/javascript">'   \
                  '  $(function() {'                  \
                  "    Mirador(#{config.to_json})"    \
                  '  });'                             \
                  '</script>'
      end
      output.join.html_safe
    end
  end
end
