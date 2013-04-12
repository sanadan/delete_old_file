#!/home/sanadan/.rbenv/shims/ruby
#!/usr/bin/ruby1.9.1
# coding: utf-8
# 古いファイルを削除して空き容量を確保
#   2012/12/06  真田  新規作成
#   2013/04/12  真田　削除アルゴリズムを大幅に見直し

#TARGET = "/media/tv"
TARGET = "test"
SPACE = 50 # GB単位

if !FileTest.directory?( TARGET )
  print "#{TARGET} はディレクトリではありません。\n"
  exit
end

print "#{SPACE} GB 空きを確保します。\n"

# 戻り値はGB単位
def get_free( target )
  df = `df #{target}`
  df = df.split( "\n" )
  df = df[ 1 ].split( " " )
  return df[ 3 ].to_i / 1024 / 1024
end


free = get_free( TARGET )
print "削除前：#{free} GB free\n"

ls = `ls -rt #{TARGET}`
ls.force_encoding( 'utf-8' ) # 2.0.0-p0でus-asciiになってしまうパターンがあったため
#p ls.encoding
ls = ls.split( "\n" )
ls.delete_if { |x| x == "lost+found" }
ls.each do |fn|
  break if get_free( TARGET ) >= SPACE * 1024 * 1024
  path = File.join( TARGET, fn )
  print "削除：#{path}\n"
  begin
    File.delete( path )
  rescue
    print "　　　削除失敗\n"
  end
end

free = get_free( TARGET )
print "削除後：#{free} GB free\n"

