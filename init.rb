# coding: utf-8

require 'redmine'
require_dependency 'matsukei_redmine'
require 'matsukei_redmine_projects_helper_patch'

Redmine::Plugin.register :matsukei_redmine do
  name 'Matsukei Redmine plugin'
  author 'tachimasa & maeda-m'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/matsukei/matsukei_redmine'
  author_url 'http://www.matsukei.co.jp/'
end

Rails.configuration.to_prepare do
  unless ProjectsHelper.included_modules.include? MatsukeiRedmineProjectsHelperPatch
    ProjectsHelper.send(:include, MatsukeiRedmineProjectsHelperPatch)
  end
end
