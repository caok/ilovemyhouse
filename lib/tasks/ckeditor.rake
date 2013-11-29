require 'fileutils'

namespace :ckeditor do
  def copy_assets(regexp)
    Rails.application.assets.each_logical_path(regexp) do |name, path|
      asset = Rails.root.join('public', 'assets', name)
      p "Copy #{path} to #{asset}"
      FileUtils.mkdir_p(File.dirname(asset))
      FileUtils.cp path, asset
    end
  end

  desc 'Copy ckeditor assets, that cant be used with digest'
  task copy_nondigest_assets: :environment do
    copy_assets /ckeditor\/contents.css/
    copy_assets /ckeditor\/skins\/moono\/.+png/
  end

  desc "Create nondigest versions of all ckeditor digest assets"
  task "assets:precompile" do
    fingerprint = /\-[0-9a-f]{32}\./
    for file in Dir["public/assets/ckeditor/**/*"]
      next unless file =~ fingerprint
      nondigest = file.sub fingerprint, '.'
      if !File.exist?(nondigest) or File.mtime(file) > File.mtime(nondigest)
        FileUtils.cp file, nondigest, verbose: true
      end
    end
  end
end
