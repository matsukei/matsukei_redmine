# coding: utf-8
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'custom_path_format'

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
