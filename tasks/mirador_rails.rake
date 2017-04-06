require 'open-uri'
require 'zip'

desc 'Update the Mirador version'
task :update, [:version] do |_t, args|
  puts "Updating mirador_rails to #{args[:version]}"
  zip_name = 'build.zip'
  build_url = "https://github.com/ProjectMirador/mirador/releases/download/#{args[:version]}/#{zip_name}"
  tmp_dir = FileUtils::mkdir_p(File.join(File.expand_path('..', File.dirname(__FILE__)), 'tmp', args[:version]))

  puts "Downloading from #{build_url}"
  File.open(File.join(tmp_dir, zip_name), 'wb') do |file|
    open(build_url, 'rb') do |read_file|
      file.write(read_file.read)
    end
  end

  puts "Extracting #{zip_name}"
  Zip::File.open(File.join(tmp_dir, zip_name)) do |zip_file|
    zip_file.each do |entry|
      dest_file = File.join(tmp_dir, entry.name)
      FileUtils.remove_entry(dest_file, true)
      entry.extract(dest_file)
    end
  end
  mirador_dir = File.join(tmp_dir, 'build', 'mirador')
  vendor_dir = File.join(File.expand_path('..', File.dirname(__FILE__)), 'vendor', 'assets')
  dirs_to_modify = %w(images locales)

  puts "Removing and copying #{dirs_to_modify}"
  dirs_to_modify.map { |d| FileUtils.rm_rf(File.join(vendor_dir, d)) }
  dirs_to_modify.map do |d|
    FileUtils.cp_r(File.join(mirador_dir, d), File.join(vendor_dir, d))
  end

  puts 'Copying stylesheets'
  FileUtils.cp(File.join(mirador_dir, 'css', 'mirador-combined.css') , File.join(vendor_dir, 'stylesheets'))

  puts 'Copying javascripts'
  FileUtils.cp(Dir.glob(File.join(mirador_dir, 'mirador.js')), File.join(vendor_dir, 'javascripts', 'mirador'))

  puts 'Updating js to use erb'
  mirador_erb = File.join(vendor_dir, 'javascripts', 'mirador', 'mirador.js.erb')
  mirador_js = File.join(vendor_dir, 'javascripts', 'mirador', 'mirador.js')

  text = File.read(mirador_js)
  puts 'Replacing images with erb tags'
  content = text.gsub("var backgroundImage = _this.state.getStateProperty('buildPath') + _this.state.getStateProperty('imagesPath') + 'debut_dark.png';", "var backgroundImage = \"<%= asset_path('debut_dark.png') %>\"")

  puts 'Comment out border image replacement, using SCSS instead'
  content = content.gsub("el.css('background-image','url('+this.getImagePath(imageName)+')');", 'el // Comment out, using SCSS instead \1')

  puts 'Replacing i18next template, with MiradorRails controller route (default)'
  content = content.gsub("loadPath: _this.state.getStateProperty('buildPath') + _this.state.getStateProperty('i18nPath')+'{{lng}}/{{ns}}.json'", "loadPath: '<%= MiradorRails::Engine.locales_mount_path %>' + '/{{lng}}/{{ns}}.json'")

  puts 'Removes tinymce library'
  content = content.gsub(/^!function\(e,t\).*(tinymce\S*){10,}.*\/\*!\n\n handlebars/m, "/*!\n\n handlebars")

  puts 'Removing OpenSeaDragon'
  content = content.gsub(/\/\/! openseadragon .*\/\/# sourceMappingURL=openseadragon.js.map/m, '')

  puts 'Removing jQuery'
  content = content.gsub(/\/\*! jQuery v.*\/*! jQuery Migrate/m, '/*! jQuery Migrate')

  puts 'Remove qtip map'
  content = content.gsub("//# sourceMappingURL=jquery.qtip.min.js.map", "\n")

  File.open(mirador_erb, 'w') { |f| f << content }
  FileUtils.rm(mirador_js)

  puts 'Removing FontAwesome from css'
  css_file = File.join(vendor_dir, 'stylesheets', 'mirador-combined.css')
  text = File.read(css_file)
  content = text.gsub(/\/\*!\n\s\*\s\sFont Awesome.*\/*! jQuery UI/m, '/*! jQuery UI')
  File.open(css_file, 'w') { |f| f << content }

  puts 'Removing MaterialIcons from css'
  css_file = File.join(vendor_dir, 'stylesheets', 'mirador-combined.css')
  text = File.read(css_file)
  content = text.gsub(/@font-face {\s*font-family: 'Material Icons';.*}/m, '')
  content = content.gsub(/\.material-icons {\s*font-family: 'Material Icons';.*}/m, '')
  File.open(css_file, 'w') { |f| f << content }
end
