require 'fileutils'

class Article < ApplicationRecord
  SLUG_HOMEPAGE = '__homepage'

  belongs_to :space, optional: true

  before_save :compile

  def compile
    extra_options = homepage? ? [] : [:number_sections, :table_of_contents]
    self.content = PandocRuby.convert(self.source, :s,
                                      {from: :markdown, to: :html },
                                      :katex, *extra_options)
  end

  def assets_dir(*p)
    return nil if self.id.blank?
    prefix = File.join Config.app.upload, 'articles', self.id.to_s
    FileUtils.mkdir_p(prefix) unless Dir.exist? prefix

    File.join prefix, *p
  end

  def assets
    Dir.glob(File.join assets_dir, '*').collect {|asset| File.basename asset}
  end

  def homepage?
    self.slug == SLUG_HOMEPAGE
  end

  def self.new_template
    Article.new
  end

  def self.homepage
    find_by_slug SLUG_HOMEPAGE
  end

  def self.create_homepage!
    create! title: 'Homepage', slug: SLUG_HOMEPAGE, source: ''
  end

end
