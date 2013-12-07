require 'middleman-core/templates'

module Middleman
  module Sample # Sample はカスタムテンプレートの名称に合わせて変更する
    class Template < Middleman::Templates::Base

      # `middleman init` で利用するオプションを反映する
      class_option 'css_dir',
        default: 'stylesheets',
        desc: 'The path to the css files'
      class_option 'js_dir',
        default: 'javascripts',
        desc: 'The path to the javascript files'
      class_option 'images_dir',
        default: 'images',
        desc: 'The path to the image files'

      # テンプレートが置かれたディレクトリを指定
      def self.source_root
        File.join(File.dirname(__FILE__), 'template')
      end

      # `middleman init` 時にテンプレートをコピーする処理を書く
      def build_scaffold
        template 'shared/config.tt', File.join(location, 'config.rb')
        copy_file 'source/index.html.erb', File.join(location, 'source/index.html.erb')
        copy_file 'source/layouts/layout.erb', File.join(location, 'source/layouts/layout.erb')

        # それぞれの空ディレクトリを作りファイルをコピーする
        empty_directory File.join(location, 'source', options[:css_dir])
        copy_file 'source/stylesheets/style.css.sass', File.join(location, 'source', options[:css_dir], 'style.css.sass')

        empty_directory File.join(location, 'source', options[:js_dir])
        copy_file 'source/javascripts/all.js.coffee', File.join(location, 'source', options[:js_dir], 'all.js.coffee')

        empty_directory File.join(location, 'source', options[:images_dir])
        copy_file 'source/images/mm-blue-w-text.svg', File.join(location, 'source', options[:images_dir], 'mm-blue-w-text.svg')
      end

    end
  end
end

# Middleman に sample テンプレートの存在を知らせる
Middleman::Templates.register :sample, Middleman::Sample::Template
