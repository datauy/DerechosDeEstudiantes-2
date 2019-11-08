require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://derechosdeestudiantes.edu.uy'
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'weekly', :priority => 0.9
  add '/sobre-nosotros', :changefreq => 'monthly'
  add '/denuncias/nueva', :changefreq => 'monthly'
  add '/preguntas', :changefreq => 'monthly'
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks