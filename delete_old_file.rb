#!/home/sanadan/.rbenv/shims/ruby
#!/usr/bin/ruby1.9.1
# coding: utf-8
# 古いファイルを削除して空き容量を確保
#   2012/12/06  真田  新規作成

TARGET = "/media/tv"
SPACE = 50 # GB単位
print "#{SPACE} GB 空きを確保します\n"

# 戻り値は1K-blocks単位
def get_free( target )
  df = `df #{target}`
  df = df.split( "\n" )
  df = df[ 1 ].split( " " )
  return df[ 3 ].to_i
end

def get_oldest_file( target )
  ls = `ls -rt #{target}`
  ls.force_encoding( 'utf-8' )
p ls.encoding
#p ls
  ls = ls.split( "\n" )
  ls.delete_if { |x| x == "lost+found" }
  return File.join( target, ls[ 0 ] )
end

free = get_free( TARGET ) / 1024 / 1024
print "#{free} GB free\n"

while ( get_free( TARGET ) < SPACE * 1024 * 1024 )
  file = get_oldest_file( TARGET )
  print "Delete: #{file}\n"
  File.delete( file )
end

free = get_free( TARGET ) / 1024 / 1024
print "#{free} GB free\n"
