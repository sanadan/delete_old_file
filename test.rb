#!/home/sanadan/.rbenv/shims/ruby
#!/usr/bin/ruby1.9.1
# coding: utf-8
# delete_old_file.rbのテスト
#   2013/04/12  真田  新規作成

print "----- delete_old_file.rb 実行 -----\n"
`./delete_old_file.rb > test.log`
print File.open( 'test.log' ).read
print "----- delete_old_file.rb 終了 -----\n"

print "testディレクトリ作成\n"
`sudo mkdir test`

print "削除できないファイル作成\n"
`sudo touch test/test.txt`

print "----- delete_old_file.rb 実行 -----\n"
`./delete_old_file.rb > test.log`
print File.open( 'test.log' ).read
print "----- delete_old_file.rb 終了 -----\n"

print "testディレクトリ削除\n"
`sudo rm -rf test`

print "testディレクトリ作成\n"
`mkdir test`

print "削除できるファイル作成\n"
`touch test/test2.txt`

print "----- delete_old_file.rb 実行 -----\n"
`./delete_old_file.rb > test.log`
print File.open( 'test.log' ).read
print "----- delete_old_file.rb 終了 -----\n"

print "testディレクトリ削除\n"
`rm -rf test`
