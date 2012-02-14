version = File.read('../../VERSION').strip
File.open('version.rb', 'w') do |file|
  file.write <<EOF
module RMOF
  VERSION = '#{version}'
end
EOF
end
