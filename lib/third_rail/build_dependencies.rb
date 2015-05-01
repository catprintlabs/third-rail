components = []
component_dir = Dir.pwd + '/app/components/'
if Dir.exist?(component_dir)
  Dir.foreach(component_dir) do |item|
    next if item == '.' or item == '..'
    components << item if File.directory?(component_dir + item)
  end
end
dir = __FILE__.rpartition('/').first
config_dir = Pathname.new(dir + '../../../lib/volt_wrapper/app/main/config/')
File.open("#{config_dir.expand_path}/dependencies.rb", 'w') do |f|
  components.each do |component|
    f.write("component '#{component}'\n")
  end
end
