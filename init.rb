# coding: utf-8
Redmine::Plugin.register :matsukei_redmine do
  name 'Matsukei Redmine plugin'
  author 'Matsukei Co.,Ltd'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/matsukei/matsukei_redmine'
  author_url 'http://www.matsukei.co.jp/'
end

require_relative 'lib/matsukei_redmine'

Redmine::WikiFormatting::Macros.register do
  desc <<DESC
UNCパスへのリンクを貼る
<pre>
使い方:
  !{{link(\\\\server\\path\\file)}}
  !{{link(\\\\server\\path\\file, 見積書)}}
</pre>
DESC
  macro :link do |obj, args|
    MatsukeiRedmine::CustomPathFormat.link_to_path(self, args.join('|')).html_safe
  end
end
