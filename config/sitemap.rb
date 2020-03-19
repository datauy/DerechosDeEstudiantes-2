require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://derechosdeestudiantes.edu.uy'
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'monthly', :priority => 0.9
  add '/sobre-el-proyecto', :changefreq => 'monthly'
  add '/denuncias/nueva', :changefreq => 'monthly'
  add '/preguntas', :changefreq => 'monthly'
  Question.find_each do |question|
    add question_path(question), :lastmod => question.updated_at, :priority => 0.5
  end
  Right.find_each do |right|
    add right_path(right), :lastmod => right.updated_at, :priority => 0.5
  end
end
#SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
